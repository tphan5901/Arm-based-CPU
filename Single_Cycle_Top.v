module Single_Cycle_Top(clk, rst);

    input clk, rst;

    // 32-bit wires
    wire [31:0] PC_Top, RD_Instr, RD1_Top, RD2_Top;
    wire [31:0] Imm_Ext_Top, ALUResult, SrcB, ReadData, PCPlus4, Result;

    // 1-bit wires
    wire RegWrite, MemWrite, ALUSrc, ResultSrc, Branch;

    // multi-bit wires
    wire [2:0] ALUControl_Top;
    wire [1:0] ImmSrc;  // <-- declare ImmSrc

    // Program Counter
    ProgramCounter PC(
        .clk(clk),
        .rst(rst),
        .PC(PC_Top),
        .PC_NEXT(PCPlus4)
    );

    // PC Adder
    PC_Adder PC_Adder(
        .a(PC_Top),
        .b(32'd4),
        .c(PCPlus4)
    );

    // Instruction Memory
    Instruction_Memory instr_mem(
        .A(PC_Top),
        .rst(rst),
        .RD(RD_Instr)
    );

    // Register File
    Register Register(
        .clk(clk),
        .rst(rst),
        .WE3(RegWrite),
        .WD3(Result),
        .A1(RD_Instr[19:15]),
        .A2(RD_Instr[24:20]),
        .A3(RD_Instr[11:7]),
        .RD1(RD1_Top),
        .RD2(RD2_Top)
    );

    // ALU
    ALU ALU(
        .A(RD1_Top),
        .B(SrcB),
        .Result(ALUResult),
        .ALUControl(ALUControl_Top),
        .OverFlow(),
        .Carry(),
        .Zero(),
        .Negative()
    );

    // Control Unit
    Control_Unit CU(
        .Op(RD_Instr[6:0]),
        .funct3(RD_Instr[14:12]),
        .funct7(RD_Instr[31:25]),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(Branch),
        .ALUControl(ALUControl_Top)
    );

    // Immediate Mux
    assign SrcB = (ALUSrc) ? Imm_Ext_Top : RD2_Top;

    // Data Memory
    Data_Memory Data_Memory(
        .clk(clk),
        .A(ALUResult),
        .rst(rst),
        .WE(MemWrite),
        .WD(RD2_Top),
        .RD(ReadData)
    );

endmodule
