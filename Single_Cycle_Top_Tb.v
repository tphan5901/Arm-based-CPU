module Single_Cycle_Top_Tb();

    reg clk = 1'b1, rst;
    
    // Instantiate DUT
    Single_Cycle_Top uut (
        .clk(clk),
        .rst(rst)
    );
    
    initial begin
        $dumpfile("Single_Cycle.vcd");
        $dumpvars(0, uut);
    end
    
    always #50 clk = ~clk;

    initial begin
        rst = 1'b0;
        #100;
        rst = 1'b1;
        #500;
        $finish;
    end

endmodule
