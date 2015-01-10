module ozer_alican_pr2(input [31:0] reg32,output[31:0] result);
	reg [5:0] opcode,funct;
	reg [4:0] rs,rt,rd,shamt;
	wire carryOut,zero,overFlow;

	reg Write = 0;
	wire [31:0] RSvalue,RTvalue,RDvalue;
	
	registerModul regMod(.readReg1(rs),.readReg2(rt),.writeReg(rd),
					.writeData(RDvalue),.write(Write),.readData1(RSvalue),.readData2(RTvalue));		
		
	aluModul aluMod(.Funct(funct),.Shamt(shamt),.Rs(RSvalue),
					.Rt(RTvalue),.Result(RDvalue),.carryOut(carryOut),.Zero(zero),.overFlow(overFlow));	
	
	assign result = RDvalue;
	//listen reg32
	always @ (reg32 ) begin		
		$display("reg32:%b",reg32);
		{opcode,rs,rt,rd,shamt,funct} = reg32;
		#100;
		$display("opcode:%b,rs:%b,rt:%b,rd:%b,shamt:%b,funct:%b",opcode,rs,rt,rd,shamt,funct);		
		Write = 1;
	end		

endmodule
