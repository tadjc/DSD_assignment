module regbank_A_16(data_in1x1,sr1,read_write,clk);
input clk,read_write;
input [1:0] sr1,dr1;
output reg [15:0] data_in1x1; //input to the bus or output from the master1 or read data
reg [15:0] R0, R1, R2, R3;

initial begin

R0 = 16'h100A; //send data to slave 1
R1 = 16'h2001; //send data to slave 2
R2 = 16'h300C; //send data to slave 3
R3 = 16'h0000; 
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