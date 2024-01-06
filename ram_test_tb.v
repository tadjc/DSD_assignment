`timescale 1ns/1ns
`include "twoK_RAM.v"


module ram_test_tb;

reg clk;

reg [31:0] data_in;
reg [10:0] addr;
wire [31:0] data_out;
reg wr;

twoK_RAM ram_test_1(data_out, data_in,addr,wr,clk);

initial
    begin
        clk = 1'b0;
        #1000 $finish;
    end

always #5 clk = ~clk;

initial
    begin

#10 data_in = 32'h2000000B;
#10 addr = 11'b00000000001;
#10 wr = 1;
#20 wr = 0;



end

initial
    begin
    
        $dumpfile("ram_test_tb.vcd");
        $dumpvars(0,ram_test_tb);
        $display("End of test!!!");

    end

endmodule