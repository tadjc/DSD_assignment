`timescale 1ns/1ns
`include "control_states.v"
`include "data_path.v"
`include "MUX.v"
`include "PIPO.v"
`include "decoder.v"

module test1_tb;

reg [15:0] data_in1,data_in2;
reg clk,rst;



data_path dpt1 (hsel_0,hsel_1,hsel_2,sel1,sel2,mux1,rst,data_in1,data_in2,clk);
control_states cpt1(sel1,sel2,clk,mux1,rst);

initial
    begin
        clk = 1'b0;
        #1000 $finish;
    end

always #5 clk = ~clk;

initial
    begin

        #1
        rst = 1'b0; #1;

        data_in1 = 16'b0010000000001000; #200;
        data_in2 = 16'b0100000000001000; #200;
        data_in1 = 16'b0110000000001000; #200;
        rst = 1'b0;
        #200;
        rst = 1'b1;
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