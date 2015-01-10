module REGMemory(input [4:0] readReg1,readReg2,writeReg,
							input [31:0] writeData,
							input write,
							output reg [31:0] readData1,readData2);

	// Declare RMEM file 32 register 32 bit 
	reg [31:0] RMEM [0:31];
	
	//verilen registerların içeriğini outpulara yaz
	always @(readReg1 or readReg2 or writeReg or writeData or write)
	begin
		readData1 = RMEM[readReg1];
		readData2 = RMEM[readReg2];
		
		if(write == 1'b1 && writeReg != 5'b00000) begin
			RMEM[writeReg] = writeData;	
		end		
		
	end	
endmodule 