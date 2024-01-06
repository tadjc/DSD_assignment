/*module data_path(slave_0,slave_1,slave_2,address,Aout,sel1,sel2,mux1,rst,data_in1,data_in2,clk,
                                sel3,sel4,mux2,data_in3,data_in4,
                                rdin1,rdin2,rdin3,resp1,resp2,resp3,rdy1,rdy2,rdy3,dout,rdyout,respout,
                                dataout, Dout);
                                */
module data_path(slave_0,slave_1,slave_2,address,Aout,sel1,sel2,mux1,rst,Abus,clk,
                                sel3,sel4,mux2,bus_dout,
                                rdin1,rdin2,rdin3,resp1,resp2,resp3,rdy1,rdy2,rdy3,bus_din,rdyout,respout,
                                dataout, Dout);
                                
    


    input sel1,sel2,mux1,sel3,sel4,mux2,clk,rst,Aout,Dout;
 //   input [15:0] data_in1, data_in2;     This line was modified
     input [15:0] Abus;    


   // input [31:0] data_in3,data_in4;

    input [31:0] bus_dout;


    //read data mux
    input [31:0] rdin1,rdin2,rdin3;
    input [1:0] resp1,resp2,resp3;
    input rdy1,rdy2,rdy3;

    output [31:0] bus_din; //output data from the read mux to the master read data path
    wire [31:0] dout;
    assign bus_din = dout;


    output rdyout;
    output [1:0] respout;

//.......................
    output [15:0] address;
    output [31:0] dataout;
//.........................

// Abus definitions..............................................................
    wire [15:0] data_in1, data_in2;
    assign data_in1 = Abus;
    assign data_in2 = Abus;

    wire [31:0] data_in3, data_in4;
    assign data_in3 = bus_dout;
    assign data_in4 = bus_dout;
//...................................................................................
wire [31:0] slave1_in;
assign slave1_in = rdin1;









    wire hsel_0,hsel_1,hsel_2;

    wire [15:0] x,y,z; //for address values passing
    wire [31:0] p,q,r; // for data values

    output slave_0,slave_1,slave_2; //buffer outputs

//making control inputs for the data out register

    wire [2:0] seld;
    assign seld[0] = hsel_0;
    assign seld[1] = hsel_1;
    assign seld[2] = hsel_2;


   
 //address muxes   
    PIPO HADDR1 (x,data_in1,sel1,clk);
    PIPO HADDR2 (y,data_in2,sel2,clk);
    MUX addressmux (z,x,y,mux1);

//data muxes
    PIPOD HWDATA1 (p,data_in3,sel3,clk);
    PIPOD HWDATA2 (q,data_in4,sel4,clk);
    MUXD datamux (r,p,q,mux2);

   
    TRI_BUFF add_buff(address,Aout,z,rst); // pssing address from the master
    TRI_BUFF_D data_buff(dataout,Dout,r,rst); //passing data from the master

    decoder dec1 (hsel_0,hsel_1,hsel_2,z,rst);

    BUFFER out1(slave_0,hsel_0);
    BUFFER out2(slave_1,hsel_1);
    BUFFER out3(slave_2,hsel_2);

// read data mux

    MUXR readMUX(dout,rdyout,respout,slave1_in,rdin2,rdin3,rdy1,rdy2,rdy3,resp1,resp2,resp3,seld);





    
endmodule