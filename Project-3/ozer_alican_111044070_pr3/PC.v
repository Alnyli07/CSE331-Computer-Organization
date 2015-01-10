module PC(input [31:0] PC_in,output reg [31:0] PC_out);
	
	initial PC_out = 32'b0;
	
	always @ (PC_in) 
	begin
	#50;
		PC_out = PC_in;			
	end

endmodule
