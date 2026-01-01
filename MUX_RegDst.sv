module MUX_RegDst(
input logic RegDst,
input logic [4:0] in2016,
input logic [4:0] in1511,
output logic [4:0] WriteReg
);

assign WriteReg = RegDst ? in1511 : in2016;

endmodule 