module display(
input logic [31:0] data_in,
output logic [6:0] segments
);

always_comb begin
case (data_in)
	32'd0:segments = 7'b0100000;
	32'd1:segments = 7'b1111001;
	32'd2:segments = 7'b0100100;
	32'd3:segments = 7'b0110000;
	32'd4:segments = 7'b0011001;
	32'd5:segments = 7'b0010010;
	32'd6:segments = 7'b0000010;
	32'd7:segments = 7'b1111000;
	32'd8:segments = 7'b0000000;
	32'd9:segments = 7'b0011000;
	default:segments = 7'b1111111;
endcase
end




endmodule 