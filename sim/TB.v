`timescale 1ns/1ps
`define VCDDUMP

module TB();

reg Async_reset_event;
reg sysclk;
reg ATPG_TM;
reg ATPG_RSTN;
reg sys_rstn;

task Async_event_set;
begin
    #1;
    Async_reset_event = 1'b1;
    #3;
    Async_reset_event = 1'b0;
end
endtask

integer rand_val;

initial begin
    ATPG_TM = 1'b0;
    ATPG_RSTN = 1'b1;
    Async_reset_event = 1'b0;
    sysclk = 1'b0;
    sys_rstn = 1'b1;
    repeat(5) @(posedge sysclk);
    sys_rstn = 1'b0;
    repeat(1) @(posedge sysclk);
    sys_rstn = 1'b1;
    repeat(10) 
    begin
        rand_val = $urandom_range(200,250);
        #(rand_val);
        Async_event_set();
    end
    $finish;
end

always #(10) sysclk = ~sysclk;

Async_reset_event UAsync_reset_event(
				     // Inputs
				     .Async_reset_event	(Async_reset_event),
				     .ATPG_TM		(ATPG_TM),
				     .ATPG_RSTN		(ATPG_RSTN),
				     .sysclk		(sysclk),
				     .sys_rstn		(sys_rstn));

`ifdef VCDDUMP
initial begin
    $dumpfile("Test.vcd");  //
    $dumpvars(0,TB);       
end
`endif

endmodule
