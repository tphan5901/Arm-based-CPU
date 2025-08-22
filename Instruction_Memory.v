module Instruction_Memory (A, rst, RD);

    input [31:0] A;
    input rst;

    output [31:0] RD;

    reg [31:0] Mem[1023:0];
    assign RD = (~rst) ? {32{1'b0}} : mem[A[31:2]];

    initial begin
        mem[0] = 32'hFFC4A303;
        mem[1] = 32'h00832383;
    end


endmodule