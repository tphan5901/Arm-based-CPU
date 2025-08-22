module Data_Memory(clk,rst,WE,WD,A,RD);

        input[31:0] A,WD;
        input clk,rst,WE;

        output[31:0] RD;
        reg [31:0] mem[1023:0];


        //write
        always @(posedge clk) 
        begin
            if(WE)
                mem[A] <= WD;
        end

        assign RD = (~rst) ? 32'd0 : mem[A];

        initial begin
            mem[28] = 32'h00000020
        //    mem[40] = 32'h00000002        
        end

endmodule