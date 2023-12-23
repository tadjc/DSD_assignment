`timescale 1ns/1ns
`include "slave_control.v"
`include "slave_data_path.v"
`include "COMPAR.v"
`include "PIPO.v"
`include "PIPOD.v"

module slave_test_tb;

reg [15:0] HADDR1,sadd;
reg [31:0] HWDATA1;

reg clk;

slave_data_path slve_dpt(slrsp_1, sl_rdy_1,HADDR1,clk,hsel_1,rst,HWDATA1,sadd,sw1,sa1);
slave_control slave_cpt(slrsp_1, sl_rdy_1,clk,rst,sw1,sa1);
initial
    begin
        clk = 1'b0;
        #500 $finish;
    end

always #5 clk = ~clk;

initial
    begin

        #1
        HADDR1 = 16'b0000000000001000; #1;
        sadd = 16'b0000000000001000; #1;
        HWDATA1 = 20; #1;

       
    end

initial
    begin
    
        $dumpfile("slave_test_tb.vcd");
        $dumpvars(0,slave_test_tb);
        $display("End of test!!!");

    end

endmodule