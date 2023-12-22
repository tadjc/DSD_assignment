`timescale 1ns/1ns
`include "decoder.v"  //include other designe files here

module decoder_test_tb; //change this 

//define variable
reg [15:0] haddr;
wire hsel_0, hsel_1,hsel_2;

decoder uut(hsel_0, hsel_1, hsel_2, haddr);

initial begin

      $dumpfile("decoder_test_tb.vcd");
      $dumpvars(0,decoder_test_tb);

      //enter the test code here
      #20
      haddr = 16'b0000000000001000; #20;
      haddr = 16'b0100000001000000; #20;
      haddr = 16'b1000000010000000; #20;
      haddr = 16'b1100000000010000; #20;


      $display("End of test!!!");

end

endmodule