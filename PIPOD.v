module PIPOD(dout,din,ld,clk);
    input [31:0] din;
    input ld,clk;
    output reg [31:0] dout;

    always @(posedge clk)
        if (ld) 
            dout <= din;

endmodule