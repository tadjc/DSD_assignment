`timescale 1ns/1ns
`include "control_states.v"
`include "data_path.v"
`include "MUX.v"
`include "PIPO.v"
`include "decoder.v"
`include "BUFFER.v"
`include "PIPOD.v"
`include "MUXD.v"




module test1_tb;

reg [15:0] data_in1,data_in2;
reg [31:0] data_in3,data_in4;

reg clk,rst;
wire [15:0] address;


                
//data_path dpt1 (hsel_0,hsel_1,hsel_2,address,Aout,sel1,sel2,mux1,rst,data_in1,data_in2,clk);

data_path dpt1 (slave_0,slave_1,slave_2,address,Aout,sel1,sel2,mux1,rst,data_in1,data_in2,clk,
                                sel3,sel4,mux2,data_in3,data_in4);

control_states cpt1(sel1,sel2,sel3,sel4,mux2,clk,mux1,rst,Aout);

initial
    begin
        clk = 1'b0;
        #1000 $finish;
    end

always #5 clk = ~clk;

initial
    begin

    
        rst = 1'b1; #1;

       

        data_in1 = 16'b0010000000001000; #1;
        data_in2 = 16'b0100000000001000; #1;

        data_in3 = 567; #1;
        data_in4 = 434; #1;



       // data_in1 = 16'b0110000000001000; #1;

        rst = 1'b0; #500;

        rst = 1'b1;

       // #200;
        //rst = 1'b1;
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