module INSTMemory(
	input [31:0] PCin,
	output reg [31:0] instruction
);
	//4k byte adressing
	reg [7:0] IMEM [0:4095];
	
	always @ (PCin) 
	begin
		instruction = {IMEM[PCin],IMEM[PCin+1],IMEM[PCin+2],IMEM[PCin+3]};			
	end
	
endmodule