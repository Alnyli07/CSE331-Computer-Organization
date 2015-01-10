module test_register;

	reg [4:0] readreg1, readreg2;
	reg [4:0] writereg;
	reg Write;
	reg [31:0] writedata; 
	wire [31:0] readdata1, readdata2;
 
    registerModul tester(.readReg1(readreg1), .readReg2(readreg2), .writeReg(writereg),.writeData(writedata),
		.write(Write),.readData1(readdata1), .readData2(readdata2));

	initial begin
	$readmemh("vectors.txt", tester.memory);
	
	#50;
	Write = 1;
	writereg = 5'd7;
	readreg1 = 5'd2;
	readreg2 = 5'd8;
	writedata = 32'hdddddddd;	
	 
	#50;
	Write = 1;
	writereg = 5'd13;
	readreg1 = 5'd1;
	readreg2 = 5'd3;
	writedata = 32'haaaaaaaa;
	 
	#50;
	Write = 0;
	writereg = 5'd24;
	readreg1 = 5'd25;
	readreg2 = 5'd23;
	writedata = 32'h11111111;
	
	#50;
	Write = 1;
	writereg = 11;
	readreg1 = 5'd14;
	readreg2 = 5'd17;
	writedata = 32'h15828762;
	#50;

	end
endmodule
