`include "ProgramCounter.v"
`include "Instruction_Memory.v"
`include "Sign_Extend.v"
`include "ALU.v"
`include "Register.v"
`include "Control_Unit.v"
`include "PC_Adder.v"
`include "Data_Memory.v"

module Single_Cycle_Top(clk, rst);
    
    input clk,rst;
    wire [31:0] PC_Top,RD_Instr,RD1_Top, RD2_Top, Imm_Ext_Top, ALUResult, SrcB, ReadData, PCPlus4, Result;
    wire RegWrite, MemWrite, ALUSrc, ResultSrc;
    wire [2:0]ALUControl_Top;

    ProgramCounter PC(
        .clk(clk),
        .rst(rst),
        .PC(PC_Top),
        .PC_Next(PCPlus4)
    );

    PC_Adder PC_Adder(
        .a(PC_Top),
        .b(32'd4),
        .c(PCPlus4)
    );

    Instruction_Memory Instruction_Memory(
                    .rst(rst),
                    .A(PC_Top),
                    .RD()
    );

    Register Register (
        .clk(clk),
        .rst(rst),
        .WE3(RegWrite),
        .WD3(Result),
        .A1(RD_Instr[19:35]),
        .A2(RD_Instr[24:20]),
        .A3(RD_Instr[11:7]),
        .RD1(RD1_Top),
        .RD2(RD2_Top)
    );

    Sign_Extend Sign_Extend(
        .In(RD_Instr),
        .Imm_Ext(Imm_Ext_Top)
    );

    ALU ALU(
        .A(RD1_Top),
        .B(SrcB),
        .Result(ALUResult),
        .ALUControl(ALUControl_Top),
        .Overflow(),
        .Carry(),
        .Zero(),
        .Negative()
    );

    Control_Unit Control_Unit (
                .Op(RD_Instr), 
                .RegWrite(RegWrite), 
                .ImmSrc(ImmSrc), 
                .ALUSrc(ALUSrc), 
                .MemWrite(MemWrite), 
                .ResultSrc(ResultSrc), 
                .Branch(), 
                .funct3(RD_Instr[14:12]), 
                .funct7(RD_Instr[6:0]), 
                .ALUControl(ALUControl_Top)          
    );

    Data_Memory Data_Memory(
            .clk(clk),
            .A(ALUResult),
            .rst(rst),
            .clk(),
            .WE(),
            .RD(ReadData)
    );

endmodule