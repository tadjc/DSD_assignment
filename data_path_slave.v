module data_path_slave(dataout,address,rdin1,clk,rws,rst);


output [31:0] rdin1; // input to the master or output from the slave
input [31:0] dataout; // data out from master
input [15:0] address; // address out from the master

input clk,rws,rst;

twoK_RAM ram_slave_1(rdin1, dataout,address[10:0],rws,clk);


endmodule