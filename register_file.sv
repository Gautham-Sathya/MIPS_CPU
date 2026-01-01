module register_file(input logic clk, rst,
input logic[4:0] A1, A2, A3, //address A1,A2,A3
input logic [31:0] WD3, //data from data memory
input logic WE3, // write reg file when 1

output logic[31:0]RD1, // output port one or reg file
output logic[31:0] RD2, //output port two for reg file
output logic[31:0] prode // prode to check result in reg file
);




logic [31:0] rf_regs [31:0]; //32 32-bit registers

assign prode = rf_regs[A3];

assign RD1 = rf_regs[A1];
assign RD2 = rf_regs[A2];

always_ff @(posedge clk or negedge rst) begin
	if(~rst) begin
		
		for(int i = 0; i<32; i=i+1)
		rf_regs[i] <= (2*i) + 1;
	end
	else if(WE3) begin
	rf_regs[A3] <= WD3;
	end
end

 



endmodule 