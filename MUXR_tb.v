`timescale 1ns/1ns
`include "MUXR.v"  //include other designe files here

module MUXR_tb; //change this 

//define variable
reg [31:0] hrdata_1,hrdata_2,hrdata_3;
reg hreadyout_1, hreadyout_2,hreadyout_3;
reg hresp_1,hresp_2,hresp_3;
reg [2:0] sel;

wire [31:0] hrdata;
wire hreadyout,hresponse;

MUXR uut(hrdata,hreadyout,hresponse,hrdata_1,hrdata_2,hrdata_3,hreadyout_1,hreadyout_2,hreadyout_3,hresp_1,hresp_2,hresp_3,sel);

initial begin

      $dumpfile("MUXR_tb.vcd");
      $dumpvars(0,MUXR_tb);

      //enter the test code here
      #20;
      hrdata_1 = 10;#1;
      hreadyout_1 = 1'b1;#1;
      hresp_1 = 1'b1;#1;
      

      hrdata_2 = 45;#1;
      hreadyout_2 = 1'b0;#1;
      hresp_2 = 1'b0;#1;
      

      hrdata_3 = 55;#1;
      hreadyout_3 = 1'b1;#1;
      hresp_3 = 1'b1;#1;
      

      #20
      sel = 3'b000; #50;
      sel = 3'b001; #50;
      sel = 3'b010; #50;


      $display("End of test!!!");

end

endmodule