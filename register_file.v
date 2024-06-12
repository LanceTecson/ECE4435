module register_file(reset,clock,we3,a1,a2,a3,wd3,rd1,rd2);
   
   input reset;
   input clock;
   input we3; // write-enable
   input [4:0] a1; // register address 1
   input [4:0] a2; // register address 2
   input [4:0] a3; // register address 3
   input [31:0] wd3; // write data
   output [31:0] rd1; // read register 1
   output [31:0] rd2; // read register 2
   
	reg [31:0] Q[31:0];
	integer i;
	
	always @(posedge reset, posedge clock) begin
			if (reset) begin
				for (i = 0; i < 32; i = i + 1) begin
					Q[i] <= 32'b0;
				end
			end
			else if (we3) begin
				if (a3 != 0) Q[a3] <= wd3;
				i <= 0;
				end
		end
//	always @(posedge clock) begin
//			if (we3) Q[a3] <= wd3;
//		end
	
	assign rd1 = (a1 != 0) ? Q[a1] : 0;
	assign rd2 = (a2 != 0) ? Q[a2] : 0;
endmodule
