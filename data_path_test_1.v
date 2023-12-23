module data_path_test_1(sel1,sel2,sel3,sel4,mux1,mux2,data_in1,data_in2,data_in3,data_in4,clk,hsel_1,hsel_2,hsel_3,
                                hrdata,hreadyout,hresponse,hrdata_1,hrdata_2,hrdata_3,hreadyout_1,hreadyout_2,hreadyout_3,hresp_1,hresp_2,hresp_3,sel);

    input sel1,sel2,sel3,sel4,mux1,mux2,clk;
    input [15:0] data_in1, data_in2;
    input [31:0] data_in3, data_in4;


    input [31:0] hrdata_1,hrdata_2,hrdata_3;
    input hreadyout_1,hreadyout_2,hreadyout_3,hresp_1,hresp_2,hresp_3;
    input [2:0] sel;

    output [31:0] hrdata;
    output hreadyout,hresponse;


    output hsel_1,hsel_2,hsel_3;
    
    

    wire [15:0] z,x,y;
    wire [31:0] p,q,r;
    
//This part has some errors
    assign sel[0] = test1_dec(hsel_1);
    assign sel[1] = hsel_2;
    assign sel[2] = hsel_3;
   

    PIPO HADDR1 (x,data_in1,sel1,clk);
    PIPO HADDR2 (y,data_in2,sel2,clk);

    PIPOD HWDATA1 (p,data_in3,sel3,clk);
    PIPOD HWDATA2 (q,data_in4,sel4,clk);

    MUX addressmux (z,x,y,mux1);
    MUXD datamux (r,p,q,mux2);
    decoder test1_dec (hsel_1,hsel_2,hsel_3,z);

    MUXR readmux (hrdata,hreadyout,hresponse,hrdata_1,hrdata_2,hrdata_3,hreadyout_1,hreadyout_2,hreadyout_3,hresp_1,hresp_2,hresp_3,sel);

    
endmodule