module data_memory(
input logic clk,rst,
input logic [31:0] A, //address
input logic [31:0] WD, //write data
input logic WE, //wren
output logic[31:0] RD, //read data
output logic[31:0] prode //check data
);

reg [31:0] mem [31:0];

assign RD = mem[A[7:0]];

assign prode = RD;


always_ff @(posedge clk or negedge rst) begin
	if(~rst) begin
		for(int i = 0; i<32; i=i+1)
			mem[i] <= 2*i;
			end
	else if(WE) begin
			mem[A[7:0]] <= WD;
	end
end
endmodule 