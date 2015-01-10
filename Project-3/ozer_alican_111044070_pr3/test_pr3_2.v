module test_pr3_2;
	wire [31:0] result;	
	parameter numOfInstruction = 128;
	parameter delayTime= numOfInstruction * 50;

	ozer_alican_pr3 topModul(.result(result));
		
	initial begin
	 //initalize the hexadecimal reads from the vectors.txt file
		$readmemh("rMem.txt", topModul.regMod.rMem);
		$readmemb("iMem.txt", topModul.imModul.iMem);//read command from file
		#delayTime		$writememh("result_rMem.txt", topModul.regMod.rMem);
	end
	
	

endmodule
