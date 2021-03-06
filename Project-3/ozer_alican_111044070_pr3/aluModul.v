module aluModul(
	input [5:0] OPCode,
	input [31:0] Rs,Rt,Immediate,
	output [31:0] Result,
	output carryOut,Zero,overFlow);
	//sonucu seçmek için
	wire [31:0] Addi,Addiu,Andi,Ori,Lui,Slti,Sltiu,Beq,Bne,Sub,Subu;
	
	//ara işlemler için
	wire [31:0] immUnsigned,addi,addiu;
	wire overFlowI,overFlowIU,cout1,cout2,slt;
	wire overFlowSub,overFlowSubU,slti,sltiu;
	
	//immediate 32 bitin unsigned 32 bit sekildeki hali
	assign immUnsigned = {{16{1'b0}},Immediate[15:0]};

	//komutların opcodları
	parameter ADDI  = 6'b001000;
	parameter ADDIU = 6'b001001;
	parameter ANDI  = 6'b001100;
	parameter ORI   = 6'b001101;
	parameter LUI   = 6'b001111;
	parameter SLTIU = 6'b001011;
	parameter SLTI  = 6'b001010;
	parameter BEQ   = 6'b000100;
	parameter BNE   = 6'b000101;	

	assign {cout1,Addi} = Rs + Immediate;//cout ve toplam eğer signed sistem ise
	assign {cout2,Addiu} = Rs + Immediate;//cout ve toplam eğer unsigned sistem ise
	
	//elde çıkışını hangi toplama işlemine olduğunun seçimi
	assign carryOut = (OPCode == ADDI) ? cout1:
							(OPCode == ADDIU) ? cout2 :1'b0;
	//taşma bitinin hangi toplama sonucu oluştuğu						
	assign overFlowI = ((Rs[31] == Rt[31]) && (Addi[31] != Rs[31])) ? 1'b1 : 1'b0;
	assign overFlow = (OPCode == ADDI) ? overFlowI: 1'b0;
	//stli ve sltiu pozitif negatif karşılaştırırken karıştırıyordu
	assign Sub = Rs - Immediate;
	assign Subu = Rs - Immediate;
	//işaretler değiştimi diye kontrol
	assign overFlowSub = ((Rs[31] == Immediate[31]) && (Sub[31] != Rs[31])) ? 1'b1 : 1'b0;
	assign overFlowSubU = ((Rs[31] == immUnsigned[31]) && (Subu[31] != Rs[31])) ? 1'b1 : 1'b0;
	assign slti = overFlowSub ? ~(Rs[31]) : Rs[31];
	assign sltiu = overFlowSubU ? ~(Rs[31]) : Rs[31];
	
	//tüm işlemler yapılır
	assign Andi = Rs & Immediate;
	assign Ori  = Rs | Immediate;
	assign Lui = {Immediate[31:16],16'b0};
	assign Beq = Rs - Rt;
	assign Bne = Rs - Rt;
	
	//sonuçlardan istenilen seçilir
	assign Result =(OPCode == ADDI) ? Addi :
						(OPCode == ADDIU) ? Addiu :
						(OPCode == ANDI) ? Andi :
						(OPCode == ORI) ? Ori :
						(OPCode == LUI) ? Lui :
						(OPCode == SLTIU) ? {{31{1'b0}}, sltiu} :
						(OPCode == SLTI) ? {{31{1'b0}}, slti} :
						(OPCode == BEQ) ? Beq :
						(OPCode == BNE) ? Bne : 32'hx;	
	//sonuç sıfır ise zero çıkışı 1 olur
	assign Zero = (Result == 32'b0);
	
endmodule
