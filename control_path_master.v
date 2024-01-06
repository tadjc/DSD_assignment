
module control_path_master(sr,dr,srA,rw,rwA,read_write,busreq_1,busreq_2,grant_1,grant_2,clk,rst,start,slave_select);

input grant_1,grant_2,clk,rst,start;
output reg  busreq_1,busreq_2,read_write,rw,rwA;
output reg [1:0] sr,dr,srA;
input [2:0] slave_select;

reg [2:0] state;
parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100;

//parameter ss0W=3'b001, ss0R=3'b010, ss1W=3'b011, ss1R=3'b100, ss00 = 3'111;

always @(posedge rst)
    if(rst)
        state <= s0;
    

always @(posedge clk && start)
    begin
        case (state) 
            s0: begin
                    case (slave_select)
                        001:  begin // write to slave 1
                                    busreq_1 <= 1;
                                    read_write <= 1'b1;
                                    srA <= 2'b01;
                                    rwA <= 1;
                                  //  state <= s1;
                                    if(grant_1)
                                        state <= s1;
                                    else    
                                        state <= s0;
                                    
                        
                                end
                            default: state <= s0;
                    endcase
                    
                            
                end
                   
            
          //  state <= s2;
        //    s2: state <= s3;
         //   s3: state <= s4;
        //    s4: state <= s0;
            default: state <= s0;
        endcase
    end

always @(state)
    begin
        case (state)
            s0:begin  busreq_1=0; busreq_2 = 0; rw=1; rwA = 1;sr =2'b11;dr=2'bzz;srA = 2'b11; end
            s1:begin  busreq_1=1; busreq_2 = 0; rw=1; rwA = 1;sr =2'b01;dr=2'bzz;srA = 2'b01;end //dta write to the slave
     //       s2: begin #1 busreq_1=1; busreq_2 = 0; read_write = 0; rw=0; rwA = 1;sr = z;dr=0;srA = 1;end
     //       s3: begin #1 busreq_1=0; busreq_2 = 0; read_write = z; rw=z; rwA = z;sr = 3;dr=z;srA = 3; end
     //       s4: begin #1 busreq_1=0; busreq_2 = 0; read_write = z; rw=z; rwA = z;sr = 3;dr=z;srA = 3; end
            default: begin busreq_1=0; busreq_2 = 0; rw=1; rwA = 1;sr =2'b11;dr=2'bzz;srA = 2'b11;  end
        
        endcase

    end


endmodule