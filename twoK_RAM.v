module twoK_RAM(data_out, data_in,addr,wr,clk);

parameter addr_size = 11, word_size = 32, memory_size = 2048;

input [addr_size-1 : 0] addr;
input [word_size-1 : 0] data_in;
input wr,clk;
output reg [word_size-1:0] data_out;

reg [word_size-1 : 0]  mem [memory_size-1:0];

always @(posedge clk)
        if (wr)  
            mem[addr] <= data_in;
     

always @(posedge clk)
        if (~wr)  
            data_out <= mem [addr]; 

endmodule