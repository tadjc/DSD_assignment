module control_path_master(sr,dr,srA,rw,rwA,read_write,busreq_1,busreq_2,grant_1,grant_2,clk,rst,start);

input grant_1,grant_2,clk,rst,start;
output reg  busreq_1,busreq_2,read_write,rw,rwA;
output reg [1:0] sr,dr,srA;

reg [2:0] state;
parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100;


always @(posedge clk or posedge rst)
    begin
    if(rst)
        state <= s0;
    end

always @(posedge clk)
    begin
        case (state)
            s0: if (start) 
                    begin
                         busreq_1 <= 1;
                    if (grant_1)
                         state <= s1;
                    end
            s1: state <= s2;
            s2: state <= s3;
            s3: state <= s4;
            s4: state <= s0;
            default: state <= s0;
        endcase
    end

always @(state)
    begin
        case (state)
            s0:begin #10 busreq_1=0; busreq_2 = 0; read_write = 0; rw=0; rwA = 0;sr =2'bzz;dr=2'bzz;srA = 2'bzz; end
            s1:begin #10 read_write = 1; rw=1; rwA = 1;sr =2'b01;dr=2'bzz;srA = 2'b01; end 
     //       s2: begin #1 busreq_1=1; busreq_2 = 0; read_write = 0; rw=0; rwA = 1;sr = z;dr=0;srA = 1;end
     //       s3: begin #1 busreq_1=0; busreq_2 = 0; read_write = z; rw=z; rwA = z;sr = 3;dr=z;srA = 3; end
     //       s4: begin #1 busreq_1=0; busreq_2 = 0; read_write = z; rw=z; rwA = z;sr = 3;dr=z;srA = 3; end
            default: begin #100 busreq_1=0; busreq_2 = 0; read_write = 0; rw=0; rwA = 0;sr =2'bzz;dr=2'bzz;srA = 2'bzz; end
        
        endcase

    end


endmodule