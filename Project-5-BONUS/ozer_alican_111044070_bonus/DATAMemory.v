module DATAMemory(input [31:0]Address, WriteData,
	input WrEn,
	output reg[31:0]ReadData);

	parameter RAMSIZE=12;//2'12 BYTE RAM
	reg [31:0] DMEM [0:4095];
	//overflowu engellemek icin mod alıyorum
	reg [RAMSIZE-1:0] new_address;	
	
	always @ (Address or WriteData or WrEn)begin
	new_address = Address[RAMSIZE-1:0];
		case (WrEn)
		
			1'b0: ReadData = DMEM[new_address];
			1'b1: DMEM[new_address]= WriteData;
			
		endcase
	end
endmodule
