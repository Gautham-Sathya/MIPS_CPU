module top(
input logic clk, rst,
input logic[1:0] sw, //address for instruction memory
output logic[31:0] Result, //output for pre-lab simulation
output logic[31:0] prode_data_mem, //output for pre-lab simulation
output logic[31:0] prode_register_file, //output for pre-lab simulation
output logic[6:0] display_led //output for in-lab
);

logic[31:0] inst_0 = 32'b0;
logic[31:0] inst_1 = 32'b010101_00000_01000_0000_0000_0000_0110; 
//load data[6] to reg[8]; base address 0 and imm 6;
//gic[31:0] inst_2 = 32'b010100_00000_00110_0000_0000_0000_0010; 
logic[31:0] inst_2 =  32'b010101_00000_01000_0000_0000_0000_0110; 
//store reg[6] to mem[2]; base address 0 and imm 2;
logic[31:0] inst_ex;
assign inst_ex = (sw==1)? inst_1:(sw==2)? inst_2: inst_0;


logic [31:0] ALUResult, RD1, RD2, ALUSrcOut, RD, si;
logic [4:0]  WriteReg; 

register_file r_f(.clk(clk),.rst(rst),
.A1(inst_ex[25:21]),.A2(inst_ex[20:16]),.A3(WriteReg),
.WD3(Result),
.WE3(inst_ex[26]),//temporary since theres no control unit yet
.RD1(RD1),
.RD2(RD2),
.prode(prode_register_file)
);


ALU t1(
.SrcA(RD1),
.SrcB(ALUSrcOut),
.ALUControl(inst_ex[29:27]),
.ALUResult(ALUResult)
);

data_memory data(.clk(clk),.rst(rst),
.A(ALUResult),
.WD(RD2),
.WE(~inst_ex[26]),//temporary for no control unit
.RD(RD),
.prode(prode_data_mem)
);

MUX_MemtoReg mx1(
.MemtoReg(inst_ex[26]),
.ALUResult(ALUResult),
.RD(RD),
.MemtoReg_Out(Result)
);

MUX_ALUSrc mx2(
.ALUSrc(inst_ex[30]),
.SignImm(si),
.RD2(RD2),
.ALUSrc_Out(ALUSrcOut)
);

MUX_RegDst mx3(
.RegDst(inst_ex[31]),
.in2016(inst_ex[20:16]),
.in1511(inst_ex[15:11]),
.WriteReg(WriteReg)
);

sign_extend se(
.Imm(inst_ex[15:0]),
.SignImm(si)
);

display t2(.data_in({28'd0,prode_register_file[3:0]}), 
.segments(display_led));

endmodule



