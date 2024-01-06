`timescale 1ns/1ns
`include "control_states.v"
`include "data_path.v"
`include "MUX.v"
`include "PIPO.v"
`include "decoder.v"
`include "BUFFER.v"
`include "PIPOD.v"
`include "MUXD.v"
`include "MUXR.v"
`include "TRI_BUFF.v"
`include "TRI_BUFF_D.v"
`include "regbank_32_in.v"
`include "regbank_32_out.v"
`include "regbank_A_16.v"
`include "data_path_master.v"
`include "control_path_master.v"
`include "twoK_RAM.v"
`include "data_path_slave.v"
`include "control_path_slave.v"




module test1_tb;

//reg [15:0] data_in1,data_in2;

//reg [15:0] Abus;


//reg [31:0] data_in3,data_in4;

reg clk,rst;
wire [15:0] address; //for address out

//for data put register from slaves
wire [31:0] rdin2,rdin3;
reg [1:0] resp2,resp3;
reg rdy2,rdy3;

//output data from slaves
//wire [31:0] dout;
//wire [1:0] respout;

//output data from master to slave through the output data bus
wire [31:0] dataout;

//for the arbiter part

wire [1:0] respout; // response fromk the slave
//reg split,ready,busreq_1,busreq_2,read_write;
reg start; //split request from the slave

wire rdyout;

   // reg ready,grant_1,grant_2;

//for register bank
wire [1:0] sr,dr,srA;
wire [31:0] bus_din;
wire [31:0] bus_dout;
wire [15:0] Abus;
//wire rw,rwA;
//wire read_write,busreq_1,busreq_2;


// slave RAM tsest
wire rws;
wire [31:0] rdin1;
wire [1:0] resp1;
wire rdy1;

//select which slave to send data (user defined)

reg [2:0] slave_select; //select the slaves for master 1

                
/*data_path dpt(slave_0,slave_1,slave_2,address,Aout,sel1,sel2,mux1,rst,data_in1,data_in2,clk,
                                sel3,sel4,mux2,data_in3,data_in4,
                                rdin1,rdin2,rdin3,resp1,resp2,resp3,rdy1,rdy2,rdy3,dout,rdyout,respout,
                                dataout, Dout); */

data_path dpt(slave_0,slave_1,slave_2,address,Aout,sel1,sel2,mux1,rst,Abus,clk,
                                sel3,sel4,mux2,bus_dout,
                                rdin1,rdin2,rdin3,resp1,resp2,resp3,rdy1,rdy2,rdy3,bus_din,rdyout,respout,
                                dataout, Dout);
                            

/*control_states cpt1(sel1,sel2,sel3,sel4,mux2,clk,mux1,rst,Aout,Dout,
                            busreq_1,busreq_2,grant_1,grant_2,split,response,ready,read_write,error); */


control_states cpt1(sel1,sel2,sel3,sel4,mux2,clk,mux1,rst,Aout,Dout,
                            busreq_1,busreq_2,grant_1,grant_2,split,rdyout,respout,read_write,error);


data_path_master master_1(bus_dout,Abus,bus_din,clk,sr,dr,rw,srA,rwA,reset);

control_path_master master_1_control(sr,dr,srA,rw,rwA,read_write,busreq_1,busreq_2,grant_1,grant_2,clk,rst,start,slave_select);

data_path_slave ram_test(dataout,address,rdin1,clk,rws,rst);

control_path_slave slave_controller(split,rdy1,resp1,rws,rst,clk,start);


initial
    begin
        clk = 1'b0;
        #1000 $finish;
    end

always #5 clk = ~clk;

initial
    begin


  #10 rst = 0;
 
  #10 start = 1;
  #10 slave_select = 001;
 
    end

initial
    begin
    
        $dumpfile("test1_tb.vcd");
        $dumpvars(0,test1_tb);
        $display("End of test!!!");

    end

endmodule