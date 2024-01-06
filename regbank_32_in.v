module regbank_32_in(hrdatax1,dr1,read_write,clk);
input clk,read_write;
input [1:0] sr1,dr1;
input [31:0] hrdatax1; // output from the slave or input to the master1 or write data
reg [31:0] R0, R1, R2, R3;


always @(posedge clk)
    begin
        if(~read_write)
            case (dr1)
                0: R0 <= hrdatax1;
                1: R1 <= hrdatax1;
                2: R2 <= hrdatax1;
                3: R3 <= hrdatax1;
            endcase
   end

endmodule