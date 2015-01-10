module test_alu;
	// Inputs
	reg [5:0] opcode;
	reg [31:0] rs,rt,immediate;
	// Outputs
	wire carryout,zero,overflow;
	wire [31:0] result;

	aluModul tester(	.OPCode(opcode),.Rs(rs),.Rt(rt),.Immediate(immediate),
		.Result(result),.carryOut(carryout),.Zero(zero),.overFlow(overflow));

	initial begin
		opcode = 6'b001000;//ADDI
		rs = 0;
		rt = 0;
		immediate=32'd46313;
		#100
        
		opcode = 6'b001001;//ADDIU
		rs = 32'hffffffff;
		rt = 32'h0000000f;
		immediate=32'd45463;
		#100;
		
		opcode = 6'b001100;//ANDI
		rs = 11068;
		rt = 15786;
		immediate=32'd5313;
		#100;
		
		opcode = 6'b001101;//ORI
		rs = 110234;
		rt = 104567;
		immediate=32'd76313;
		#100;
		
		opcode = 6'b001111;//LUI
		rs = 11024;
		rt = 10234;
		immediate=32'd46354;
		#100;				
		
		opcode = 6'b001011;//SLTIU
		rs = 32'b10000000000000000000000000000000;
		rt = 1023;
		immediate=32'd4653;
		#100;		
			
		opcode = 6'b001010;//SLTI
		rs = -32'd6;
		rt = -32'd6;
		immediate=32'd468453;
		#100;
		
		opcode = 6'b000100;//BEQ
		rs = 1104345;
		rt = 106756;
		immediate=32'd4684;
		#100;

		opcode = 6'b000101;//BNE
		rs = 32'b001110;
		rt = 1045747;
		immediate=32'd4431;
		#100;
		
	end
      
endmodule
