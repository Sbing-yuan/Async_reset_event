module Async_reset_event(
/*AUTOARG*/
   // Inputs
   Async_reset_event, ATPG_TM, ATPG_RSTN, sysclk, sys_rstn
   );

input   Async_reset_event; // active high
input   ATPG_TM;
input   ATPG_RSTN;

input   sysclk;
input   sys_rstn;

reg [7:0] REG_SYS;

MUX2 ATPG_MUX_Async_reset_event (
    .Out(ATPG_Async_reset_event_rstn), 
    .SEL(ATPG_TM), 
    .In0(sys_rstn & !Async_reset_event), 
    .In1(ATPG_RSTN)
); 

MUX2 ATPG_MUX_I_reset_event (
    .Out(I_reset_event_rstn), 
    .SEL(ATPG_TM), 
    .In0(sync_Async_reset_event_rstn), 
    .In1(ATPG_RSTN)
); 

CDCSync_Signal_ResetL 
Sync_Async_reset_event_rstn(
    // Outputs
    .DO         (sync_Async_reset_event_rstn),
    // Inputs
    .clk        (sysclk),
    .rst_n      (ATPG_Async_reset_event_rstn),
    .DI         (1'b1)
);

always@(posedge sysclk or negedge I_reset_event_rstn)
    if(~I_reset_event_rstn)
        REG_SYS <= 8'd0;
    else
        REG_SYS <= REG_SYS + 8'd1;

endmodule
