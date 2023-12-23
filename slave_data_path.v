module slave_data_path(slrsp_1, sl_rdy_1,HADDR1,clk,hsel_1,rst,HWDATA1,sadd,sw1,sa1);

    input hsel_1,rst,sw1,sa1,clk;
    input [15:0] HADDR1,sadd;
    input [31:0] HWDATA1;

    output slrsp_1,sl_rdy_1;
    //output [31:0] hrdata_1;

    wire [15:0] SA;
    wire [31:0] SD,Q;
    wire COMP;

    PIPO SHADDR1 (SA,HADDR1,sa1,clk);
    PIPOD SHWDATA1 (SD,HWDATA1,sw1,clk);

    COMPAR add_compare(HADDR1,sadd,COMP);

    PIPOD SHADDR2 (Q,SD,COMP,clk);

   
    //PIPOD HWDATA2 (q,data_in4,sel4,clk);

endmodule