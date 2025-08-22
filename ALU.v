module ALU(A, B, Result, ALUControl, Overflow, Carry, Zero, Negative);

    input[1:0] A,B
    input ALUControl;
    input[2:0] ALUControl

    //Output Declaration
    output[31:0] Result

    //Interim wires
    wire[31:0] a_and_b;
    wire[31:0] a_or_b;
    wire[31:0] not_b;

    wire[31:0] mux_1;
    wire[31:0] sum;
    wire[31:0] mux_2;
    wire[31:0] slt;
    wire cout;
    wire[31:0]Sum;

    assign Sum = (ALUControl[0] == 1'b0) ? A + B :
    assign {Cout,Result} = (ALUControl == 3'b000) ? Sum :
                            (ALUControl == 3'b001) ? Sum :
                            (ALUControl == 3'b010) ? A & B :
                            (ALUControl == 3'b011) ? A | B :
                            (ALUControl == 3'b101) ? {{32{1'b0}}, (Sum[31])} :
                            {33{1'b0}};
    
    assign Overflow = ((Sum[31] ^ A[31]) &
    (~(ALUControl[0] ^ B[31] ^ A[31])) & 
    (~ALUControl[1]));

    assign Carry = ((~ALUControl[1]) & Cout);
    assign Zero = &(~Result);
    assign Negative = Result[31];

endmodule