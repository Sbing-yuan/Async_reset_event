module MUX2(
/*AUTOARG*/
   // Outputs
   Out,
   // Inputs
   SEL, In0, In1
   );

input   SEL;
input   In0;
input   In1;

output  Out;

assign  Out = SEL ? In1 : In0;

endmodule
