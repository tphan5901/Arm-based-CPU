module Single_Cycle_Top_Tb();

    reg clk = 1'b1,rst;

    Single_Cycle_Top_Tb(
        .clk(clk),
        .rst(rst)
    );
    
    initial begin 
        $dumpfile("Single Cycle.vsd");
        $dumpvars(0);
    end
    
    always
    begin
        clk = ~ clk;
        #50;
    end

    initial
    begin
        rst = 1'b0;
        #100;
        
        rst = 1'b1;
        #500;
        $finish;
    end

endmodule