`include "ProgramCounter.v"
`include "Instruction_Memory.v"
`include "Sign_Extend.v"
`include "ALU.v"
`include "Register.v"
`include "Control_Unit.v"
`include "PC_Adder.v"
`include "Data_Memory.v"

module Single_Cycle(clk, rst);
    
    input clk,rst;
    wire [31:0] PC_Top,RD_Instr,RD1_Top, Imm_Ext_Top, ALUResult, ReadData, PCPlus4;
    wire RegWrite;
    wire [2:0]ALUControl_Top;

    PC_Module PC(
        .clk(clk),
        .rst(rst),
        .PC(PC_Top),
        .PC_NEXT(PCPlus4)
    );

    PC_Adder PC_Adder(
        .a(PC_Top),
        .b(32'd4),
        .c(PCPlus4)
    );

    Instruction_memory Instruction_memory(
                    .rst(rst),
                    .A(PC_Top),
                    .RD()
    );

    Register Register (
        .clk(clk),
        .rst(rst),
        .WE3(RegWrite),
        .WD3(ReadData),
        .A1(RD_Instr[19:35]),
        .A2(),
        .A3(RD_Instr[11:7]),
        .RD1(RD1_Top),
        .RD2()
    );

    Sign_Extend Sign_Extend(
        .In(RD_Instr),
        .Imm_Ext(Imm_Ext_Top)
    );

    ALU ALU(
        .A(RD1_Top),
        .B(Imm_Ext_Top),
        .Result(ALUResult),
        .ALUControl(ALUControl_Top),
        .Overflow(),
        .Carry(),
        .Zero(),
        .Negative()
    );

    Control_Unit Control_Unit (
                .Op(), 
                .RegWrite(RegWrite), 
                .ImmSrc(), 
                .ALUSrc(), 
                .MemWrite(), 
                .ResultSrc(), 
                .Branch(), 
                .funct3(), 
                .funct7(), 
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