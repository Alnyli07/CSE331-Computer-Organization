module test_iMem;
	reg [31:0] pc_in;
	wire [31:0] reg32,pc_out;
	reg clock;

	instMemory imModul(.PC_in(pc_in),.clock(clock),.instruction(reg32));	
	
	initial begin
	clock= 1;
	pc_in=32'b0;
		$readmemb("iMem.txt", imModul.iMem);
		
		#1550;
		$writememb("result_iMem.txt", imModul.iMem);
		
		
		end
		always begin
		pc_in=pc_in +4;
		#25 clock=~clock;
		end
endmodule