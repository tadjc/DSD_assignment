
// data write to the bus
module regbank_32_out(data_in1x1,sr1,read_write,clk);
input clk,read_write;
input [1:0] sr1;
output reg [31:0] data_in1x1; //input to the bus or output from the master1 or read data
reg [31:0] R0, R1, R2, R3;

initial begin
    R0 <= 32'h1000000A;
    R1 <= 32'h2000000B;
    R2 <= 32'h30000013;
    R3 = 32'h00000000;
end

always @(posedge clk)
    begin
        if(read_write)
            case (sr1)
                0: data_in1x1 <= R0;
                1: data_in1x1 <= R1;
                2: data_in1x1 <= R2;
                3: data_in1x1 <= R3;
            endcase

    end


endmodule