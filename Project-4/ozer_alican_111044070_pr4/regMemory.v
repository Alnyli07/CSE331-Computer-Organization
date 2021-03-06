module regMemory(input [4:0] readReg1,readReg2,writeReg,
	input [31:0] writeData,
	input write,
	output reg [31:0] readData1,readData2
);

	// Declare rMem file 32 register 32 bit 
	reg [31:0] rMem [0:31];
	
	//verilen registerların içeriğini outpulara yaz
	always @(readReg1 or readReg2 or writeReg or writeData or write)
	begin
		readData1 <= rMem[readReg1];
		readData2 <= rMem[readReg2];
		
		if(write == 1) begin
			rMem[writeReg] <= writeData;	
		end		
	end	
endmodule 