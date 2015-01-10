module CONTROLLER(
	input [5:0] OPCode,FCode,
	output [4:0] AluCtr,
	output AluMUX1,AluMUX2,RegWrite,MemWrite,selectReg,MemtoReg,
	output [1:0] Branch);	
	
	//R-TYPE ların fonksiyon kodları
	parameter R_TYPE=6'b000000;
	parameter ADD = 6'b100000;
	parameter SUB = 6'b100010;
	parameter AND = 6'b100100;
	parameter OR  = 6'b100101;
	parameter SRA = 6'b000011;
	parameter SRL = 6'b000010;
	parameter SLL = 6'b000000;
	parameter SLLV= 6'b000100;
	parameter SLT = 6'b101010;
	
	//I-TYPE ların opcodları
	parameter ADDI = 6'b001000;
	parameter ADDIU= 6'b001001;
	parameter ANDI = 6'b001100;
	parameter ORI  = 6'b001101;
	parameter LUI  = 6'b001111;
	parameter SLTIU= 6'b001011;
	parameter SLTI = 6'b001010;
	parameter BEQ  = 6'b000100;
	parameter BNE  = 6'b000101;
	parameter LW   = 6'b100011;
	parameter SW   = 6'b101011;
	//jump opcode
	parameter JUMP = 6'b000010;
	
	//toplam 21 tane ins. olugu icin minimum 5bit kullandim
	assign AluCtr=
		(OPCode==R_TYPE && FCode == ADD) ? 5'b00000:
		(OPCode==R_TYPE && FCode == SUB) ? 5'b00001:
		(OPCode==R_TYPE && FCode == AND) ? 5'b00010:
		(OPCode==R_TYPE && FCode == OR)  ? 5'b00011:
		(OPCode==R_TYPE && FCode == SRA) ? 5'b00100:
		(OPCode==R_TYPE && FCode == SRL) ? 5'b00101:
		(OPCode==R_TYPE && FCode == SLL) ? 5'b00110:
		(OPCode==R_TYPE && FCode == SLLV)? 5'b00111:
		(OPCode==R_TYPE && FCode == SLT) ? 5'b01000:
		(OPCode==ADDI) ? 5'b01001:
		(OPCode==ADDIU)? 5'b01010:
		(OPCode==ANDI) ? 5'b01011:
		(OPCode==ORI) ?  5'b01100:
		(OPCode==LUI) ?  5'b01101:
		(OPCode==SLTIU)? 5'b01110:
		(OPCode==SLTI) ? 5'b01111:
		(OPCode==BEQ)  ? 5'b10000:
		(OPCode==BNE)  ? 5'b10001:
		(OPCode==LW)   ? 5'b10010:
		(OPCode==SW)   ? 5'b10011:	5'bx;//yoksa x doner

	assign AluMUX1=
		(OPCode==R_TYPE && FCode == ADD) ? 1'b0:
		(OPCode==R_TYPE && FCode == SUB) ? 1'b0:
		(OPCode==R_TYPE && FCode == AND) ? 1'b0:
		(OPCode==R_TYPE && FCode == OR)  ? 1'b0:
		(OPCode==R_TYPE && FCode == SRA) ? 1'b1:
		(OPCode==R_TYPE && FCode == SRL) ? 1'b1:
		(OPCode==R_TYPE && FCode == SLL) ? 1'b1:
		(OPCode==R_TYPE && FCode == SLLV)? 1'b0:
		(OPCode==R_TYPE && FCode == SLT) ? 1'b0:
		(OPCode==ADDI) ? 1'b0:
		(OPCode==ADDIU)? 1'b0:
		(OPCode==ANDI) ? 1'b0:
		(OPCode==ORI) ?  1'b0:
		(OPCode==LUI) ?  1'bx:///
		(OPCode==SLTIU)? 1'b0:
		(OPCode==SLTI) ? 1'b0:
		(OPCode==BEQ)  ? 1'b0:
		(OPCode==BNE)  ? 1'b0:
		(OPCode==LW)   ? 1'b0:
		(OPCode==SW)   ? 1'b0:	1'bx;//yoksa x doner
		
	assign AluMUX2=
		(OPCode==R_TYPE && FCode == ADD) ? 1'b0:
		(OPCode==R_TYPE && FCode == SUB) ? 1'b0:
		(OPCode==R_TYPE && FCode == AND) ? 1'b0:
		(OPCode==R_TYPE && FCode == OR)  ? 1'b0:
		(OPCode==R_TYPE && FCode == SRA) ? 1'b0:
		(OPCode==R_TYPE && FCode == SRL) ? 1'b0:
		(OPCode==R_TYPE && FCode == SLL) ? 1'b0:
		(OPCode==R_TYPE && FCode == SLLV)? 1'b0:
		(OPCode==R_TYPE && FCode == SLT) ? 1'b0:
		(OPCode==ADDI) ? 1'b1:
		(OPCode==ADDIU)? 1'b1:
		(OPCode==ANDI) ? 1'b1:
		(OPCode==ORI) ?  1'b1:
		(OPCode==LUI) ?  1'b1:///
		(OPCode==SLTIU)? 1'b1:
		(OPCode==SLTI) ? 1'b1:
		(OPCode==BEQ)  ? 1'b0:
		(OPCode==BNE)  ? 1'b0:
		(OPCode==LW)   ? 1'b1:
		(OPCode==SW)   ? 1'b1:	1'bx;//yoksa x doner
	
	assign RegWrite=(OPCode != BEQ && OPCode != BNE && OPCode != SW && OPCode != JUMP) ? 1'b1: 1'b0;
	
	assign MemWrite=(OPCode == SW)? 1'b1: 1'b0;
	
	assign selectReg=(OPCode == R_TYPE) ? 1'b1: 1'b0;
	
	assign Branch=
		(OPCode == BEQ) ? 2'b00:
		(OPCode == BNE) ? 2'b01:
		(OPCode == JUMP) ? 2'b10: 2'b11;
	
	assign MemtoReg= (OPCode == LW) ? 1'b1: 1'b0;
	
endmodule
