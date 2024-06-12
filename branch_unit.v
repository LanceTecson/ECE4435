module branch_unit(Branch,flags,funct3,taken);

   input [3:0] flags;
   input [2:0] funct3;
   input Branch;
   output taken;
	
	reg satisfied;
   
	// vcnz
	always @(*) begin
		case (funct3)
			3'b000: satisfied = flags[0];															// beq
			3'b001: satisfied = ~flags[0];														// bne
			3'b100: satisfied = (flags[1] & ~flags[3]) | (~flags[1] & flags[3]);		// blt
			3'b101: satisfied = ~((flags[1] & ~flags[3]) | (~flags[1] & flags[3]));	// bge
			3'b110: satisfied = ~flags[2];														// bltu
			3'b111: satisfied = flags[2];															// bgeu
			default: satisfied = 0;
		endcase
	end
	
	assign taken = Branch & satisfied;
	
endmodule
