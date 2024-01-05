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



module test1_tb;

//reg [15:0] data_in1,data_in2;

//reg [15:0] Abus;


//reg [31:0] data_in3,data_in4;

reg clk,rst;
wire [15:0] address; //for address out

//for data put register from slaves
reg [31:0] rdin1,rdin2,rdin3;
reg [1:0] resp1,resp2,resp3;
reg rdy1,rdy2,rdy3;

//output data from slaves
//wire [31:0] dout;
wire [1:0] respout;

//output data from master to slave through the output data bus
wire [31:0] dataout;

//for the arbiter part

reg [1:0] response; // response fromk the slave
//reg split,ready,busreq_1,busreq_2,read_write;
reg split,ready,start; //split request from the slave
   // reg ready,grant_1,grant_2;

//for register bank
wire [1:0] sr,dr,srA;
wire [31:0] bus_din;
wire [31:0] bus_dout;
wire [15:0] Abus;
//wire rw,rwA;
//wire read_write,busreq_1,busreq_2;
                
/*data_path dpt(slave_0,slave_1,slave_2,address,Aout,sel1,sel2,mux1,rst,data_in1,data_in2,clk,
                                sel3,sel4,mux2,data_in3,data_in4,
                                rdin1,rdin2,rdin3,resp1,resp2,resp3,rdy1,rdy2,rdy3,dout,rdyout,respout,
                                dataout, Dout); */

data_path dpt(slave_0,slave_1,slave_2,address,Aout,sel1,sel2,mux1,rst,Abus,clk,
                                sel3,sel4,mux2,bus_dout,
                                rdin1,rdin2,rdin3,resp1,resp2,resp3,rdy1,rdy2,rdy3,bus_din,rdyout,respout,
                                dataout, Dout);
                            

control_states cpt1(sel1,sel2,sel3,sel4,mux2,clk,mux1,rst,Aout,Dout,
                            busreq_1,busreq_2,grant_1,grant_2,split,response,ready,read_write,error);

data_path_master master_1(bus_dout,Abus,bus_din,clk,sr,dr,rw,srA,rwA,reset);

control_path_master master_1_control(sr,dr,srA,rw,rwA,read_write,busreq_1,busreq_2,grant_1,grant_2,clk,rst,start);



initial
    begin
        clk = 1'b0;
        #1000 $finish;
    end

always #5 clk = ~clk;

initial
    begin
   
     //   rst = 1'b1; #1;

       // data_in1 = 16'b0010000000001000;  //slave one select h2008
//data_in2 = 16'b0100000000001000; //slave 2 select h4008

  //  Abus = 16'b0010000000001000;

       rdin1 = 50;
        rdin2 = 0;
        resp1 = 2'b01;
        resp2 = 2'b11;

      rdy1 = 1;
        rdy2 = 0;

      rst = 0;
       #10    split = 1'b0;
              ready = 1;
     
     #10  response = 2'b00;
  #10 start = 1;
    #25 ready = 0;
 

      //  read_write = 0;
        

     /*   data_in3 = 567; #20;
        data_in4 = 434; #20;

        rdin1 = 50;#1;
        rdin2 = 0;#1;
        rdin3 = 0;#1;

        resp1 = 2'b01;#1;
        resp2 = 2'b11;#1;
        resp1 = 2'b10;#1;

        rdy1 = 1;#1;
        rdy2 = 0;#1;
        rdy3 = 1;#1;

        */

        //for arbiter read_write: 1 - write / 0 - read

      //  #20 rst = 1;
        
    /*    #100 rst = 1;
        #100 rst = 0;

        
    // Testing the idle condition
   #10  busreq_1 = 1;
    #10    read_write =1'b1;
        //busreq_2= 0;
    #10    split = 1'b0;
      #10  ready = 1;
     
     #10  response = 2'b00;
       #10 ready = 0;

    #30 ready = 1;
        busreq_1 = 0;
    
    #30 busreq_1 = 1;
     #10   response = 2'b01;
     #30 response = 2'b00;
     #10 response = 2'b10;


     */
    
    #10 rst = 0;

 // test datapath_master
/*#10
    sr = 2'b01;
    srA= 2'b01;
    dr = 2'b01;

    rw = 1;
    rwA= 1;
#50

    rw = 0;


  #10  busreq_2 = 1;
    split = 1'b0;
    ready = 1;
    response = 2'b00;
    read_write =1'b1;
#10
    ready = 0;
#30
    ready = 1;
*/
//.....................................................................

/*    busreq_2 = 0;
    busreq_1 = 0;

#20
  //  busreq_2 = 0;
    busreq_1 = 1;
    read_write =1'b0;
#20

    busreq_1 = 0;
#20
    busreq_2 = 1;
    read_write = 1'b0; */

//...............................................................................................................
    //writing to slave1 by the master1 from idle state
      /*  rst = 0;#1;
        busreq_1 = 1;#1; // master 1 requesting the bus
        busreq_2 = 0;#1;
        ready = 1; #1;//slave ready
        split = 0;#1;  //no split transfers
        response = 2'b00;#1; //response is in complete state
        read_write = 1;#100;  // write request

        rst = 1; #20;
       
        rst = 0;#1;
        busreq_1 = 1;#1; // master 1 requesting the bus
        busreq_2 = 0;#1;
        ready = 1; #1;//slave ready
        split = 0;#1;  //no split transfers
        response = 2'b00;#1; //response is in complete state
        read_write = 1;#200;  // write request

        busreq_1 = 1;#1; // master 1 requesting the bus
        busreq_2 = 1;#1;
        ready = 1; #1;//slave ready
        split = 0;#1;  //no split transfers
        response = 2'b00;#1; //response is in complete state
        read_write = 1;#200;  // write request */



       //............................................................................................ 

       //reading from slave 1 by master1
    /*    rst = 0;#1;
        busreq_1 = 1;#1; // master 1 requesting the bus
        busreq_2 = 0;#1;
        ready = 1; #1;//slave ready
        split = 0;#1;  //no split transfers
        response = 2'b00;#1; //response is in complete state
        read_write = 0;#100;  // write request

        rst = 1; #20;
       
        rst = 0;#1;
        busreq_1 = 1;#1; // master 1 requesting the bus
        busreq_2 = 0;#1;
        ready = 1; #1;//slave ready
        split = 0;#1;  //no split transfers
        response = 2'b00;#1; //response is in complete state
        read_write = 0;#200;  // write request

        busreq_1 = 1;#1; // master 1 requesting the bus
        busreq_2 = 0;#1;
        ready = 1; #1;//slave ready
        split = 0;#1;  //no split transfers
        response = 2'b00;#1; //response is in complete state
        read_write = 0;#200;  //  */
//..........................................................................................................
    //when both masters got accessed

    /*    rst = 0;#1;
        busreq_1 = 1;#1; // master 1 requesting the bus
        busreq_2 = 1;#1;
        ready = 1; #1;//slave ready
        split = 0;#1;  //no split transfers
        response = 2'b00;#1; //response is in complete state
        read_write = 0;#100;  // write request

        rst = 1; #20;
       
        rst = 0;#1;
        busreq_1 = 1;#1; // master 1 requesting the bus
        busreq_2 = 1;#1;
        ready = 1; #1;//slave ready
        split = 0;#1;  //no split transfers
        response = 2'b00;#1; //response is in complete state
        read_write = 0;#200;  // write request

    */
    //...........................................................................................

     /*   rst = 1;#20;
        rst = 0;#20;
        rst = 1;#20;
        rst = 0;#20;

        busreq_1 = 1; // master 1 requesting the bus
        busreq_2 = 0;
        split = 0;  //no split transfers
     //   response = 2'b00;#100; //response is in complete state
        read_write = 0;#1;  // write request
        ready = 1; #1;//slave ready
        response = 2'b00; #200;

        ready = 0;

      */



      //  response = 2'b00;#800;
       //response = 2'b01;#1; */


       // rst = 1;#20;

       // response = 2'b01; #10;

     //   rst = 1'b0;



       /*   
        busreq_1 = 1;#1; // master 1 requesting the bus
        busreq_2 = 0;#1;
        ready = 1; #1;//slave ready
        split = 0;#1;  //no split transfers
        response = 2'b00;#1; //response is in complete state
        read_write = 0;#200;  // write request
        */



      //reading from slave1 by the master1 from idle state
    /*    busreq_1 = 1;#1;
        busreq_2 = 0;#1;
        ready = 1;#1;
        split = 0;#1;
        response = 2'b00;#1;
        read_write = 0; */

    //reading from slave1 by the master 2 from idle state
     /*   busreq_1 = 0;#1;
        busreq_2 = 1;#1;
        ready = 1;#1;
        split = 0;#1;
        response = 2'b00;#1;
        read_write = 0;*/

    //both masters are requesting the buss address from idle state. Master1 was assigned highest priority
   /*     busreq_1 = 1;#1;
        busreq_2 = 1;#1;
        ready = 1;#1;
        split = 0;#1;
        response = 2'b00;#1;
        read_write = 0;
*/
        

       // data_in1 = 16'b0110000000001000; #1;

       // rst = 1'b0; #500;

       // rst = 1'b1;

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