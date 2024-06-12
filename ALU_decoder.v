module ALU_decoder(opb5,funct3,funct7b5,ALUOp,ALUControl);

   input opb5;
   input [2:0] funct3;
   input       funct7b5;
   input [1:0] ALUOp;
   output reg [3:0] ALUControl;
   
	always @(*) begin
		case (ALUOp)
			2'b00: ALUControl = 4'b0000;  // add
			2'b01: ALUControl = 4'b0001;  // sub
			2'b10: begin
				if (opb5 == 1'b0) begin
					case (funct3)
						3'b000: ALUControl = 4'b0000;								// addi
						3'b001: ALUControl = funct7b5 ? 4'b0000 : 4'b0110;	// slli ? 
						3'b010: ALUControl = 4'b0101;								// slti
						3'b011: ALUControl = 4'b1001;								// sltiu
						3'b100: ALUControl = 4'b0100;								// xori
						3'b101: ALUControl = funct7b5 ? 4'b1000 : 4'b0111;	// srai ? srli
						3'b110: ALUControl = 4'b0011;								// ori
						3'b111: ALUControl = 4'b0010;								// andi
						default: ALUControl = 4'b0000;							// add
					endcase
				end else begin
					case (funct3)
						3'b000: ALUControl = funct7b5 ? 4'b0001 : 4'b0000;	// sub ? add
						3'b001: ALUControl = funct7b5 ? 4'b0000 : 4'b0110;	// sll
						3'b010: ALUControl = funct7b5 ? 4'b0000 : 4'b0101;	// slt
						3'b011: ALUControl = funct7b5 ? 4'b0000 : 4'b1001;	// sltu
						3'b100: ALUControl = funct7b5 ? 4'b0000 : 4'b0100;	// xor
						3'b101: ALUControl = funct7b5 ? 4'b1000 : 4'b0111;	// sra ? srl
						3'b110: ALUControl = funct7b5 ? 4'b0000 : 4'b0011;	// or
						3'b111: ALUControl = funct7b5 ? 4'b0000 : 4'b0010;	// and
						default: ALUControl = 4'b0000;							// add
					endcase
				end
			end
			default: ALUControl = 4'b0000;  // add
		endcase
	end
	
endmodule
