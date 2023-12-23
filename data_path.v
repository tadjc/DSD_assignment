module data_path(hsel_0,hsel_1,hsel_2,sel1,sel2,mux1,rst,data_in1,data_in2,clk);
    input sel1,sel2,mux1,clk,rst;
    input [15:0] data_in1, data_in2;

    output hsel_0,hsel_1,hsel_2;
    //output [15:0] z;
    wire [15:0] x,y,z;

    PIPO HADDR1 (x,data_in1,sel1,clk);
    PIPO HADDR2 (y,data_in2,sel2,clk);
    MUX addressmux (z,x,y,mux1);
    decoder dec1 (hsel_0,hsel_1,hsel_2,z,rst);
    
endmodule