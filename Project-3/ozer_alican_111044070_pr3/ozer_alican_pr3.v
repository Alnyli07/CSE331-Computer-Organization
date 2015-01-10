module ozer_alican_pr3( output [31:0] result);
	wire [5:0] opcode;
	wire [4:0] rs,rt;
	wire [15:0] immediate16;
	wire [31:0] immediate32,pc_in,pc_out;
	wire [31:0] reg32;
	wire carryOut,zero,overFlow;
	
	//modul aralarına kablo
	wire [31:0] RSvalue,RTvalue,WRData;	
	
	//modul bağlantıları
	PC pcModul(.PC_in(pc_in),.PC_out(pc_out));
	instMemory imModul(.PCin(pc_out),.instruction(reg32));	
	
	//gelen registerı parçala
	assign {opcode,rs,rt,immediate16} = reg32;
	
	//sign extend  32 bit
	assign immediate32 = {{16{immediate16[15]}},immediate16[15:0]};	
	
	//sadece branch lerde opcode[3]=0 yani registera yazma yok;  
	registerModul regMod(.readReg1(rs),.readReg2(rt),.writeReg(rt),
					.writeData(WRData),.write(opcode[3]),.readData1(RSvalue),.readData2(RTvalue));		
		
	aluModul aluMod(.OPCode(opcode),.Rs(RSvalue),.Rt(RTvalue),
						.Immediate(immediate32),.Result(WRData),.carryOut(carryOut),
						.Zero(zero),.overFlow(overFlow));
						
	//shift ve PC güncelleme
	assign pc_in = ( (opcode[3]==0) && (zero == 0)) ? (pc_out + 4 + (immediate32 << 2)) : (pc_out + 4 );
	//sonucu outputa yaz
	assign result = WRData;
		
endmodule
