module test_pr3;
	wire [31:0] result;
	/*ONEMLI:::instruction modül içindeki parametrede ayarlanmalı*/
	parameter numOfInstruction = 22;	
	parameter delayTime= numOfInstruction * 50;

	ozer_alican_pr3 topModul(.result(result));
		
	initial begin
		//register memory yi dosyadan okuma
		$readmemh("rMem.txt", topModul.regMod.rMem);
		//instruction memory yi okuma
		$readmemb("commands.txt", topModul.imModul.iMem);
		//istruction modülünün  işini bitirmesini bekliyor
		#delayTime	$writememh("result_rMem_nb.txt", topModul.regMod.rMem);
	end
endmodule
