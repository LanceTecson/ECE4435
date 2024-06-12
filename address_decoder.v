module address_decoder (MemWrite,Addr,RAM_CS,RAM_WE,ROM_CS,UART_WR, UART_RD, CE_SR,CE_UART);

   input MemWrite;
   input [31:0] Addr;
   output reg	RAM_CS;
   output reg	RAM_WE;
   output reg	ROM_CS;
   output reg 	UART_WR;
   output reg 	UART_RD;
   output reg 	CE_UART;
   output reg 	CE_SR;

	always @(*) begin
		RAM_CS = (Addr >= 32'h0400) & (Addr <= 32'h04ff);
		RAM_WE = MemWrite;
		ROM_CS = (Addr >= 32'h0000) & (Addr < 32'h0400);
		UART_WR = MemWrite;  // Tx 
		UART_RD = ~MemWrite;  // Rx
		CE_UART = Addr == 32'h0500;  // uart en
		CE_SR = Addr == 32'h0504; //status reg
	end
	
endmodule
