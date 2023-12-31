module data_path_master(bus_dout,Abus,bus_din,clk,sr,dr,rw,srA,rwA,reset);


input [31:0] bus_din;
output [31:0] bus_dout;
output [15:0] Abus;

input [1:0] sr,dr,srA;
input clk,rw,rwA,reset;

wire [31:0] x,y,p,q;
wire [15:0] r,s;



regbank_32_out out_data_master(bus_dout,sr,rw,clk);
regbank_32_in in_data_master(bus_din,dr,rw,clk);
regbank_A_16 out_address(Abus,srA,rwA,clk);




endmodule