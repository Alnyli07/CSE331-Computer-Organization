module instMemory(input [31:0] PC_in,
input clock,
	output reg [31:0] instruction,
	output reg [31:0] PC_out
);
	//4k byte adressing
	reg [7:0] iMem [0:4095];
	initial begin
		#25;
		PC_out=32'b0;
		//senkronize olsun diye baslangıc veriyorum
		instruction <= {iMem[0],iMem[1],iMem[2],iMem[3]};	
		end
	
	always @ (posedge clock) 
	begin
		#50;
		instruction <= {iMem[PC_out],iMem[PC_out+1],iMem[PC_out+2],iMem[PC_out+3]};		
		PC_out <= PC_in;		
	end
	
endmodule
