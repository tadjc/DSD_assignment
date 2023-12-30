module PIPO(dout,din,ld,clk);
    input [15:0] din;
    input ld,clk;
    output reg [15:0] dout;

    always @(posedge clk)
        begin
            if (ld) 
                dout <= din;
            else
                dout <= 16'b0; 
        end
endmodule