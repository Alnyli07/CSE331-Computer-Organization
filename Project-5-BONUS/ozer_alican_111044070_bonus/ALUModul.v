module ALUModul(input [4:0] control,
	input [31:0] inner1,inner2,
	output [31:0] Result,
	output Zero,Carry,OverFlow);
	//sonucu seçmek için
	wire [31:0] Add,Sub,And,Or,Sra,Srl,Sll,Sllv,Slt;
	wire [31:0] Addi,Addiu,Andi,Ori,Lui,Slti,Sltiu,Beq,Bne,Lw,Sw;
	wire OFAdd,OFSub,OFAddi,OFAddiu;
	//ara işlemler için
	wire [31:0] UnsignedImm;
	wire cout1,cout2,cout3;
	wire [4:0]Shamt;
	assign Shamt=inner1[4:0];
	
	//R-TYPE ların kodları
	parameter ADD = 5'b00000;
	parameter SUB = 5'b00001;
	parameter AND = 5'b00010;
	parameter OR  = 5'b00011;
	parameter SRA = 5'b00100;
	parameter SRL = 5'b00101;
	parameter SLL = 5'b00110;
	parameter SLLV= 5'b00111;
	parameter SLT = 5'b01000;
	
	//I-TYPE ların kodları
	parameter ADDI = 5'b01001;
	parameter ADDIU= 5'b01010;
	parameter ANDI = 5'b01011;
	parameter ORI  = 5'b01100;
	parameter LUI  = 5'b01101;
	parameter SLTIU= 5'b01110;
	parameter SLTI = 5'b01111;
	parameter BEQ  = 5'b10000;
	parameter BNE  = 5'b10001;
	parameter LW   = 5'b10010;
	parameter SW   = 5'b10011;
	
	//immediate 32 bitin unsigned 32 bit sekildeki hali
	assign UnsignedImm = {{16{1'b0}},inner2[15:0]};
	//cout ve toplam eğer signed sistem ise
	assign {cout1,Addi} = inner1 + inner2;
	//cout ve toplam eğer unsigned sistem ise
	assign {cout2,Addiu} = inner1 + inner2;
	//cout ve toplam eğer unsigned sistem ise
	assign {cout3,Add} = inner1 + inner2;
	
	//elde çıkışını hangi toplama işlemine olduğunun seçimi
	assign Carry = (control == ADDI) ? cout1:
						(control == ADDIU) ? cout2 :
						(control == ADD) ? cout3:1'b0;
		
	//tüm işlemler yapılır
	assign Sub = inner1 - inner2;
	assign And = inner1 & inner2;
	assign Or  = inner1 | inner2;
	shiftRA _SRA(inner2,Shamt,Sra);//sra negatif
	assign Srl = inner2 >> Shamt;
	assign Sll = inner2 << Shamt;
	assign Sllv= inner2 << inner1;
	setOnLessThan _SLT(inner1,inner2,Slt);
	assign Andi = inner1 & inner2;
	assign Ori  = inner1 | inner2;
	assign Lui = {inner2[15:0],16'b0};	
	setOnLessThan _SLTI(inner1,inner2,Slti);
	setOnLessThan _SLTIU(inner1,UnsignedImm,Sltiu);	
	assign Beq = inner1 - inner2;
	assign Bne = inner1 - inner2;
	assign Lw  = inner1 + inner2;
	assign Sw  = inner1 + inner2;
	//overflow controlleri
	assign OFAdd = ((inner1[31] == inner2[31]) && (Add[31] != inner1[31])) ? 1'b1 : 1'b0;
	assign OFSub = ((inner1[31] == inner2[31]) && (Sub[31] != inner1[31])) ? 1'b1 : 1'b0;
	assign OFAddi = ((inner1[31] == inner2[31]) && (Addi[31] != inner1[31])) ? 1'b1 : 1'b0;
	assign OFAddiu = ((inner1[31] == inner2[31]) && (Addiu[31] != inner1[31])) ? 1'b1 : 1'b0;
	assign OverFlow =
		(control == ADD) ? OFAdd:
		(control == SUB) ? OFSub:
		(control==ADDI) ? OFAddi:
		(control==ADDIU) ? OFAddiu: 1'b0;
	//istenilen degeri cıkısa ver
	assign Result=
		(control == ADD) ? Add:
		(control == SUB) ? Sub:
		(control == AND) ? And:
		(control == OR) ? Or:
		(control == SRA) ? Sra:
		(control == SRL) ? Srl:
		(control == SLL) ? Sll:
		(control == SLLV) ? Sllv:
		(control == SLT) ? Slt:
		(control==ADDI) ? Addi:
		(control==ADDIU) ? Addiu:
		(control==ANDI) ? Andi:
		(control==ORI) ? Ori:
		(control==LUI) ? Lui:
		(control==SLTIU) ? Sltiu:
		(control==SLTI) ? Slti:
		(control==BEQ) ? Beq:
		(control==BNE) ? Bne:
		(control==LW) ? Lw:
		(control==SW) ? Sw:	inner1;//yoksa inner1 doner
		
	assign Zero = (Result == 32'b0) ? 1'b1: 1'b0;
endmodule

module shiftRA(input [31:0] inner, input [4:0] shamt, output [31:0] result);

	wire [31:0] s0, s1, s2, s3, inverseA;
	assign inverseA = ~inner;
	assign s0 = (shamt[0] ? {inner[31], inner} >> 1 : inner);
	assign s1 = ~(shamt[1] ? {{2{inner[31]}}, s0} >> 2 : s0);
	assign s2 = ~(shamt[2] ? {{4{inverseA[31]}}, s1} >> 4 : s1);
	assign s3 = ~(shamt[3] ? {{8{inner[31]}}, s2} >> 8 : s2);
	assign result = ~(shamt[4] ? {{16{inverseA[31]}}, s3} >> 16 : s3);
endmodule

module setOnLessThan(input [31:0] inner1,inner2,output [31:0]out);
	wire [31:0] overFlow,Sub;
	wire sout;
	assign Sub = inner1 - inner2;
	assign overFlow = ((inner1[31] == inner2[31]) && (Sub[31] != inner1[31])) ? 1'b1 : 1'b0;
	assign sout = overFlow ? ~(inner1[31]) : inner1[31];
	assign out = {31'd0,sout};

endmodule
