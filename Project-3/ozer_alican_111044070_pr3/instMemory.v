module instMemory(input [31:0] PCin,output reg [31:0] instruction);
	parameter memory_size=128;//kendi degerinizi giriniz
	reg [31:0] iMem [0:memory_size-1];
	integer i = 1;

	always @ (PCin) begin
	//gönderirken 2 sola shift etmiştik şimdi tam tersine
		instruction <= iMem[PCin >> 2];
		i = i + 1;
		if(PCin >= memory_size * 4) begin
			#((memory_size-i)*50);//memory sonuna geldiğinde
		end
	end
	
endmodule
