module ozer_alican_pr4(output [31:0] result);
	wire [5:0] opcode;
	wire [4:0] rs,rt;
	wire [15:0] immediate16;
	reg clock;
	
	wire [31:0] signExImm,pc_out,pc_in,RSvalue,RTvalue;
	wire [31:0] reg32,myData,alu_in,alu_out,toReg;
	wire carryOut,zero,overFlow;
	parameter BEQ = 6'b000100;
	parameter BNE = 6'b000101;

	instMemory imModul(.PC_in(pc_in),.clock(clock),.instruction(reg32),.PC_out(pc_out));	

	//gelen registerı parçala
	assign {opcode,rs,rt,immediate16} = reg32;
	
	//sign extend  32 bit
	assign signExImm = {{16{immediate16[15]}},immediate16[15:0]};	
	
	//branclerde ve sw de registera yazma yok;  
	regMemory regMod(.readReg1(rs),.readReg2(rt),.writeReg(rt),
					.writeData(toReg),.write((~opcode[5]) ~^ opcode[3]),.readData1(RSvalue),.readData2(RTvalue));		
	
	//ALU ya girişi seçen MUX :
	//sadece branclerde RS ve RT girer
	//diğerlerinde Rs ve İmmediate girer.
	assign alu_in = (opcode[5]==0 && opcode[3]==0) ? (RTvalue) : (signExImm);
	
	aluModul aluMod(.OPCode(opcode),.Rs(RSvalue),.Rt(alu_in),
						.Immediate(signExImm),.Result(alu_out),.carryOut(carryOut),
						.Zero(zero),.overFlow(overFlow));
						
	dataMemory datamem(.address(alu_out),.wrEn(opcode[3] && opcode[5]),.clk(clock),.data_in(RTvalue),.data_out(myData));
	
	//registere yazılacak veriyi seçme
	//aludanmı yoksa memorydenmi
	assign toReg = (opcode == 6'b100011) ? (myData) : alu_out;	
	
	//branclerde PC güncelleme	
	assign pc_in = (((opcode == BEQ) && (zero == 1)) || ((opcode == BNE) && (zero == 0))) ? (pc_out+ 4 + 4*signExImm) : (pc_out + 4);

	//sonucu outputa yaz
	assign result = alu_out;
		
endmodule

