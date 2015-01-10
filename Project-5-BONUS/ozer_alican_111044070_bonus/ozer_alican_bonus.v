module ozer_alican_bonus(output [31:0] Result);
	
	wire [1:0] Branch;
	wire [4:0] rs,rt,rd,shamt,REGWRin,ALUCONTROL;
	wire [5:0] opcode,funct;	
	wire [15:0] offset;
	wire [25:0] targetAddress;	
	wire [31:0] signExtented,shamt32;
	wire zero,carry,overflow,RegWr,MemWrite,ALUMUX1,ALUMUX2,selectReg,MemtoReg;
	wire [31:0]PCin,PCOut,PCWire,REGOut1,REGOut2,reg32,ALUin1,ALUin2,
		ALUResult,MEMOut,WriteDATA;
	//moduls connection definition
	PCModul PC(PCin,PCOut);
	INSTMemory IM(PCOut,reg32);
	//gelen registerı parçala
	assign opcode=reg32[31:26];
	assign rs=reg32[25:21];
	assign rt=reg32[20:16];
	assign rd=reg32[15:11];
	assign shamt=reg32[10:6];
	assign funct=reg32[5:0];	
	assign targetAddress=reg32[25:0];
	assign offset=reg32[15:0];
	//sign extend to 32 bit
	assign signExtented = {{16{offset[15]}},offset[15:0]};
	assign shamt32 = {{28{shamt[4]}},shamt[3:0]};
	/**************/
	CONTROLLER CONTROL(opcode,funct,ALUCONTROL,ALUMUX1,ALUMUX2,RegWr,MemWrite,selectReg,MemtoReg,Branch);	
	
	mux2_5b wrReg(selectReg,rt,rd,REGWRin);

	REGMemory REG(rs,rt,REGWRin,WriteDATA,RegWr,REGOut1,REGOut2);
	
	mux2_32b alu1(ALUMUX1,REGOut1,shamt32,ALUin1);
	
	mux2_32b alu2(ALUMUX2,REGOut2,signExtented,ALUin2);
	
	ALUModul ALU(ALUCONTROL,ALUin1,ALUin2,ALUResult,zero,carry,overflow);
	
	DATAMemory DATAMEM(ALUResult,REGOut2,MemWrite,MEMOut);
	//sadece SW de memdeki data rege yazılır
	mux2_32b MemOrAlu(MemtoReg,ALUResult,MEMOut,WriteDATA);

	//jump , branc  ve pc guncelleme
	assign PCWire=PCOut+32'd4;
	assign PCin = 
		(Branch == 2'b00 && zero == 1'b1) ? (PCWire +signExtented * 4)://beq
		(Branch == 2'b01 && zero == 1'b0) ? (PCWire +signExtented * 4)://bne
		(Branch == 2'b10) ? {PCWire[31:28],targetAddress,2'b00}://jump
		PCWire;
		
	assign Result = ALUResult;
endmodule	

module mux2_32b(input select,input [31:0] in0,in1,output[31:0] out);
	assign out = (select == 1'b0) ? in0:
					(select == 1'b1) ? in1: 32'bx;
endmodule
module mux2_5b(input select,input [4:0] in0,in1,output[4:0] out);
	assign out = (select == 1'b0) ? in0:
					(select == 1'b1) ? in1: 5'bx;
endmodule
	