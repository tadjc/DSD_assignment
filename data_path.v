module data_path(slave_0,slave_1,slave_2,address,Aout,sel1,sel2,mux1,rst,data_in1,data_in2,clk,
                                sel3,sel4,mux2,data_in3,data_in4);

    input sel1,sel2,mux1,sel3,sel4,mux2,clk,rst,Aout;
    input [15:0] data_in1, data_in2;
    input [31:0] data_in3,data_in4;

//.......................
    output [15:0] address;
//.........................


    wire hsel_0,hsel_1,hsel_2;

    wire [15:0] x,y,z; //for address values passing
    wire [31:0] p,q,r; // for data values

    output slave_0,slave_1,slave_2; //buffer outputs

   
 //address muxes   
    PIPO HADDR1 (x,data_in1,sel1,clk);
    PIPO HADDR2 (y,data_in2,sel2,clk);
    MUX addressmux (z,x,y,mux1);

//data muxes
    PIPOD HWDATA1 (p,data_in3,sel3,clk);
    PIPOD HWDATA2 (q,data_in4,sel4,clk);
    MUXD datamux (r,p,q,mux2);

   
    PIPO AOUT (address,z,Aout,clk);

    decoder dec1 (hsel_0,hsel_1,hsel_2,z,rst);

    BUFFER out1(slave_0,hsel_0);
    BUFFER out2(slave_1,hsel_1);
    BUFFER out3(slave_2,hsel_2);

// read data mux

    MUXR 





    
endmodule