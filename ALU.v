module ALU(A,B,ALUcontrol,result,flags);

   input [31:0] A;
   input [31:0] B;
   input [3:0] 	ALUcontrol;
   output reg [31:0] result;
   output [3:0] flags;  // vcnz
   
	wire [31:0] invB;
	wire [31:0] sum;
	wire			cout;
	wire			assl;  // add sub or set less than
	
	assign invB = ALUcontrol[0] ? ~B : B;
	assign {cout, sum} = A + invB + ALUcontrol[0];
	
	always @(*) begin
		case(ALUcontrol)
			4'b0000	:	result = sum;
			4'b0001	:	result = sum;
			4'b0010	:	result = A & B;
			4'b0011	:	result = A | B;
			4'b0100	:	result = A ^ B;
			4'b0101	:	result = sum[31] ^ flags[3];
			4'b0110	:	result = A << B[4:0];
			4'b0111	:	result = A >> B[4:0];
			4'b1000	:	result = $signed(A) >>> B[4:0];
			4'b1001	:	result = {31'b0, ~cout};
			default	:	result = 0;
		endcase
	end

	assign assl = (~ALUcontrol[3] & ~ALUcontrol[2] & ~ALUcontrol[1]) | (~ALUcontrol[3] & ~ALUcontrol[1] & ALUcontrol[0]) | (~ALUcontrol[2] & ~ALUcontrol[1] & ALUcontrol[0]);
	
//	v
	assign flags[3] = assl & (A[31] ^ sum[31]) & ~(A[31] ^ B[31] ^ ALUcontrol[0]);
//	c
	assign flags[2] = assl & cout;
	
//	n
	assign flags[1] = result[31];

//	z
	assign flags[0] = (result == 32'b0) ? 1'b1 : 1'b0;
	

	

	
endmodule