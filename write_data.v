// Copyright (C) 2020  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"
// CREATED		"Mon Feb 12 00:08:16 2024"

module write_data(
	Addr,
	rd2,
	ReadData,
	StoreType,
	WriteData
);


input wire	[31:0] Addr;
input wire	[31:0] rd2;
input wire	[31:0] ReadData;
input wire	[1:0] StoreType;
output wire	[31:0] WriteData;

wire	[31:0] SelectByte;
wire	[31:0] store_byte_word;
wire	[31:0] store_half;
wire	[31:0] storeb0;
wire	[31:0] storeb1;
wire	[31:0] storeb2;
wire	[31:0] storeb3;
wire	[31:0] storeh0;
wire	[31:0] storeh1;





mux2	b2v_ByteWordSelectMux(
	.sel(StoreType[0]),
	.d0(rd2),
	.d1(SelectByte),
	.y(store_byte_word));
	defparam	b2v_ByteWordSelectMux.WIDTH = 32;

assign	storeh0[15:0] = rd2[15:0];


assign	storeb1[15:8] = rd2[7:0];


assign	storeb1[7:0] = ReadData[7:0];


assign	storeb2[31:24] = ReadData[31:24];


assign	storeb2[23:16] = rd2[7:0];


assign	storeb2[15:0] = ReadData[15:0];


assign	storeb3[31:24] = rd2[7:0];


assign	storeb3[23:0] = ReadData[23:0];


assign	storeh0[31:16] = ReadData[31:16];


assign	storeh1[15:0] = ReadData[15:0];


assign	storeh1[31:16] = rd2[31:16];


assign	storeb0[31:8] = ReadData[31:8];


assign	storeb0[7:0] = rd2[7:0];


assign	storeb1[31:16] = ReadData[31:16];



mux4	b2v_SelectByteMux(
	.d0(storeb0),
	.d1(storeb1),
	.d2(storeb2),
	.d3(storeb3),
	.sel(Addr[1:0]),
	.y(SelectByte));
	defparam	b2v_SelectByteMux.WIDTH = 32;


mux2	b2v_SelectHalfMux(
	.sel(Addr[1]),
	.d0(storeh0),
	.d1(storeh1),
	.y(store_half));
	defparam	b2v_SelectHalfMux.WIDTH = 32;


mux2	b2v_WriteDataMux(
	.sel(StoreType[1]),
	.d0(store_byte_word),
	.d1(store_half),
	.y(WriteData));
	defparam	b2v_WriteDataMux.WIDTH = 32;


endmodule
