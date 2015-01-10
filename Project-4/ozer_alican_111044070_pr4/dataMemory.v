module dataMemory(input [31:0] address,
	input wrEn,clk,
	input [31:0] data_in,
	output reg[31:0] data_out
);
	parameter RAMSIZE=12;//2'12 BYTE RAM
	reg [7:0] dMem [0:4095];
	//overflowu engellemek icin mod alıyorum
	reg [RAMSIZE-1:0] new_address;	
	
	always @ (posedge clk)	begin
	new_address <= address[RAMSIZE-1:0];
		case (wrEn)
		
			1'b0: data_out = {dMem[new_address],dMem[new_address+1],dMem[new_address+2],dMem[new_address+3]};
			1'b1: {dMem[new_address],dMem[new_address+1],dMem[new_address+2],dMem[new_address+3]} = data_in;
			
		endcase
	end
	
endmodule
