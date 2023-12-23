`timescale 1ns/1ns
`include "control_test_1.v"
`include "data_path_test_1.v"
`include "MUX.v"
`include "MUXD.v"
`include "MUXR.v"
`include "PIPO.v"
`include "PIPOD.v"
`include "decoder.v"

module test1_tb;

reg [15:0] data_in1,data_in2;
reg [31:0] data_in3,data_in4;


reg [31:0] hrdata_1,hrdata_2,hrdata_3;
reg hreadyout_1,hreadyout_2,hreadyout_3,hresp_1,hresp_2,hresp_3;

reg clk, start;
wire done;

wire [31:0] hrdata;
wire hreadyout,hresponse;

data_path_test_1 dpt1 (sel1,sel2,sel3,sel4,mux1,mux2,data_in1,data_in2,data_in3,data_in4,clk,hsel_1,hsel_2,hsel_3,
                        hrdata,hreadyout,hresponse,hrdata_1,hrdata_2,hrdata_3,hreadyout_1,hreadyout_2,hreadyout_3,hresp_1,hresp_2,hresp_3,sel);
control_test_1 cpt1(sel1,sel2,sel3,sel4,start,done,clk,mux1,mux2);

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
        data_in2 = 16'b0010000000001000; #1;
        data_in3 = 10; #1;
        data_in4 = 20; #1;

        hrdata_1  = 30;#1;
        hrdata_2  = 40;#1;
        hrdata_3  = 50;#1;

        hreadyout_1 = 1'b1;#1;
        hreadyout_2 = 1'b0;#1;
        hreadyout_3 = 1'b0;#1;

        hresp_1 = 1'b1;#1;
        hresp_2 = 1'b0;#1;
        hresp_3 = 1'b0;#1;

       
    end

initial
    begin
    
        $dumpfile("test1_tb.vcd");
        $dumpvars(0,test1_tb);
        $display("End of test!!!");

    end

endmodule