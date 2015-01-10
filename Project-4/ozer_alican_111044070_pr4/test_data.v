module test_data;
	reg [31:0] adres,data_in;
	reg wb;
	wire [31:0] data_out;

	dataMemory datamem(.address(adres),.wrEn(wb),.data_in(data_in),.data_out(data_out));
	
	initial begin
		$readmemb("dMem.txt", datamem.dMem);
		adres=32'h00000000;
		data_in=32'hffffffff;
		wb=1'b0;
		#50;
		
		adres=32'h00000004;
		data_in=32'b1;
		wb=1'b1;
		#50;
		
		adres=32'h00000008;
		data_in=32'hffffffff;
		wb=1'b1;
		#50;
		
		$writememb("result_dMem.txt", datamem.dMem);
		end
endmodule
