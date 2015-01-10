module test_pr4_2;
	wire [31:0] result;
	//dosyadan kac instruction okunacak
	//instruction memory 4K
	//döngü icin gerekli
	parameter numOfInstruction = 18;
	parameter delayTime= (numOfInstruction+1) * 50;

	ozer_alican_pr4 topModul(.result(result));
		
	initial begin
	topModul.clock=0;
		//dosyadan okuma
		$readmemh("rMem.txt", topModul.regMod.rMem);
		$readmemb("iMem.txt", topModul.imModul.iMem);
		$readmemb("dMem.txt", topModul.datamem.dMem);
		//ilk degerleri dosyaya yazma
		$writememh("initial_rMem.txt", topModul.regMod.rMem);
		$writememb("initial_iMem.txt", topModul.imModul.iMem);
		$writememb("initial_dMem.txt", topModul.datamem.dMem);
		//instructionların btimesi için gereken süre
		#delayTime
		//son degerleri dosyaya yazma
		$writememh("result_rMem.txt", topModul.regMod.rMem);
		$writememb("result_iMem.txt", topModul.imModul.iMem);
		$writememb("result_dMem.txt", topModul.datamem.dMem);
		#50;
		$finish;
	end
	always begin
	#25 topModul.clock=~topModul.clock;
	end
endmodule
