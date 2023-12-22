`timescale 1ns/1ns
`include "control_test_1.v"
`include "data_path_test_1.v"
`include "MUX.v"
`include "PIPO.v"
`include "decoder.v"

module test1_tb;

reg [15:0] data_in1,data_in2;
reg clk, start;
wire done;

data_path_test_1 dpt1 (sel1,sel2,mux1,data_in1,data_in2,clk,hsel_1,hsel_2,hsel_3);
control_test_1 cpt1(sel1,sel2,start,done,clk,mux1);

initial
    begin
        clk = 1'b0;
        #3 start = 1'b1;
        #500 $finish;
    end

always #5 clk = ~clk;

initial
    begin

        #1
        data_in1 = 16'b0000000000001000; #1;
        data_in2 = 16'b0100000000001000; #1;
        //data_in2 = 16'b1000000000001000; #50;
        //data_in1 = 16'b0000000000001000; #1;

       
    end

initial
    begin
    
        $dumpfile("test1_tb.vcd");
        $dumpvars(0,test1_tb);
        $display("End of test!!!");

    end

endmodule