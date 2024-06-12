module imm_src_decoder (op,ImmSrc);

   input [6:0] op;
   output reg [2:0] ImmSrc;
   
	always @(*) begin
		case (op)
			7'b0000011: ImmSrc = 3'b000;
			7'b0010011: ImmSrc = 3'b000;
			7'b1100111: ImmSrc = 3'b000;
			7'b0100011: ImmSrc = 3'b001;
			7'b1100011: ImmSrc = 3'b010;
			7'b1101111: ImmSrc = 3'b011;
			7'b0010111: ImmSrc = 3'b100;
			7'b0110111: ImmSrc = 3'b100;
			default:		ImmSrc = 3'b000;
		endcase
	end
	
endmodule
