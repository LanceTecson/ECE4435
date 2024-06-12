module register_n
  #(parameter WIDTH = 8)
   (reset,clock,enable,D,Q);

   input reset;
   input clock;
   input enable;
   input [WIDTH-1:0] D;
   output reg [WIDTH-1:0] Q;
	
	// async
   always @(posedge clock, posedge reset)
    begin
      if (reset == 1) Q <= 0;
      else Q <= enable ? D : Q;
    end

endmodule

// reset Q 0
// eneable Q Q = D rising edge
// !eneable Q = curr