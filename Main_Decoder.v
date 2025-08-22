module Main_Decoder(Op,RegWrite,MemWrite,ResultSrc,ALUSrc,Branch,ImmSrc,ALUOp);

    input [6:0] Op;
    output RegWrite, MemWrite, ResultSrc, ALUSrc, Branch;
    output [1:0] ImmSrc, ALUOp;

    assign RegWrite = ((Op == 7'b0000011) | (Op == 7'b0110011)) ? 1'b1 : 1'b0;
    assign MemWrite = (Op == 7'b0100011) ? 1'b1 : 1'b0;
    assign ResultSrc = (Op == 7'b0000011) ? 1'b1 : 1'b0;
    assign ALUSrc = ((Op == 7'b0000011) | (Op == 7'b0100011)) ? 1'b1 : 1'b0;
    assign Branch = (Op == 7'b1100011) ? 1'b1 : 1'b0;
    assign ImmSrc = (Op == 7'b0100011) ? 2'b10 : (Op == 7'b1100011) ? 2'b10 : 2'b00;
    assign ALUOp = (Op == 7'b0110011) ? 2'b10 : (Op == 7'b1100011) ? 2'b01 : 2'b00;

endmodule
