module data_path_test_1(sel1,sel2,mux1,data_in1,data_in2,clk,hesl_1,hsel_2,hsel_3);
    input sel1,sel2,mux1,clk;
    input [15:0] data_in1, data_in2;
    output hsel_1,hsel_2,hsel_3;
    wire [15:0] z,x,y

    PIPO HADDR1 (x,data_in1,sel1,clk);
    PIPO HADDR2 (y,data_in2,sel2,clk);
    MUX addressmux (z,x,y,mux1);
    decoder test1 (z,hsel_1,hsel_2,hsel_3);
    
endmodule