module extend(Instr,ImmSrc,ImmExt);

   input [31:0] Instr;
   input [2:0] 	ImmSrc;
   output reg [31:0] ImmExt;
   
	always @(*) begin
		case (ImmSrc)
			3'b000:	ImmExt = {{20{Instr[31]}}, Instr[31:20]};  // I
			3'b001:	ImmExt = {{20{Instr[31]}}, Instr[31:25], Instr[11:7]};  // S
			3'b010:	ImmExt = {{19{Instr[31]}}, Instr[31], Instr[7], Instr[30:25], Instr[11:8], 1'b0};  // B
			3'b011:	ImmExt = {{12{Instr[31]}}, Instr[19:12], Instr[20], Instr[30:21], 1'b0};	// J
			3'b100:	ImmExt = {Instr[31:12], 12'b0};	// U
			default:	ImmExt = 32'b0;
		endcase
	end
	
endmodule
