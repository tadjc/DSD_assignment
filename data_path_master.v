
module data_path_master(bus_dout,Abus,bus_din,clk,sr,dr,rw,srA,rwA,rst);



input [31:0] bus_din; // data in from slave
output [31:0] bus_dout; //data out from master
output [15:0] Abus; //address out from master

input [1:0] sr,dr,srA;
input clk,rw,rwA,rst;




regbank_32_out out_data_master(bus_dout,sr,rw,clk);
regbank_32_in in_data_master(bus_din,dr,rw,clk);
regbank_A_16 out_address(Abus,srA,rwA,clk);




endmodule