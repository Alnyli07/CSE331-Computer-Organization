module registerModul(input [4:0] readReg1,readReg2,writeReg,
							input [31:0] writeData,input write,
							output reg [31:0] readData1,readData2);

	// Declare memory file 32 register 32 bit 
	reg [31:0] memory [0:31];
	
	//write to memory
	always @(readReg1 or readReg2 or writeReg or writeData or write)	begin
		readData1 = memory[readReg1];
		readData2 = memory[readReg2];
		if(write == 1) begin
			memory[writeReg] = writeData;
			//$display("write=%h;\nwriteReg:%d;\nwriteData:%h\nMEM=%h",write,writeReg,writeData,memory[writeReg]);			  
			
		end		
	end	
endmodule 