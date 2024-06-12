module mux3
  #(parameter WIDTH = 8)
   (d0,d1,d2,sel,y);

   input [WIDTH-1:0] d0;
   input [WIDTH-1:0] d1;
   input [WIDTH-1:0] d2;
   input [1:0]	     sel;
   output [WIDTH-1:0] y;   

  assign y = sel[1] ? d2 : (sel[0] ? d1 : d0);

endmodule
