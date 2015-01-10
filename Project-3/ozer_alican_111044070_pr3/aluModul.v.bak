module aluModul(
	input [5:0] Funct,
	input [4:0] Shamt,
	input [31:0] Rs,Rt,
	output [31:0] Result,
	output carryOut,Zero,overFlow);

	wire [31:0] Add,Sub,And,Or,Sra,Srl,Sll,Sllv;
	wire overFlowAdd,overFlowSub,Slt;
	
	assign {carryOut,Add} = Rs + Rt;
	assign Sub = Rs - Rt;
	assign overFlowAdd = ((Rs[31] == Rt[31]) && (Add[31] != Rs[31])) ? 1 : 0;
	assign overFlowSub = ((Rs[31] == Rt[31]) && (Sub[31] != Rs[31])) ? 1 : 0;

	assign overFlow = (Funct == 6'b100000) ? overFlowAdd : overFlowSub;
	assign And = Rs & Rt;
	assign Or  = Rs | Rt;
	assign Srl = Rt >> Shamt;
	assign Sll = Rt << Shamt;
	assign Sllv= Rt << Rs;
	assign Slt = overFlowSub ? ~(Rs[31]) : Rs[31];
	//sra negatif sayilardada soldan 0 koyuyor bunu duzeltmek icin
	shiftRA SRA(Rt,Shamt,Sra);
	
	assign Result = (Funct == 6'b000000) ? Sll ://sll
	(Funct == 6'b000010) ? Srl ://srl
	(Funct == 6'b000011) ? Sra ://sra
	(Funct == 6'b000100) ? Sllv ://sllv
	(Funct == 6'b100000) ? Add ://add
	(Funct == 6'b100010) ? Sub ://sub
	(Funct == 6'b100100) ? And ://and
	(Funct == 6'b100101) ? Or ://or
	(Funct == 6'b101010) ? {{31{1'b0}}, Slt} : 32'hx;	
	
	assign Zero = (Result == 0);
	
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