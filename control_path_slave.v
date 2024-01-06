module control_path_slave(split,rdy1,resp1,rws,rst,clk,start);
input clk,rst,start;
output reg split,rdy1,rws;
output reg  [1:0] resp1;




reg [2:0] state;
parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100;

always @(posedge rst)
    state <= s0;
   

always @(posedge clk)
    begin
        case (state)
            s0: if (start) state <= s1;
            s1: state <= s1; //  s2;
           // s2: state <= s3;
           // s3: state <= s4;
          //  s4: state <= s0;
            default: state <= s0;
        endcase
    end

always @(state)
    begin
        case (state)
            s0: begin #1 split=0; rdy1 = 0; resp1 = 2'b00; rws=0; end
            s1: begin #1 split=0; rdy1 = 1; resp1 = 2'b00; rws=1; end //store data from the master
            s2: begin #50 split=0; rdy1 = 0; resp1 = 2'b01; rws=0;end //retry state
            s3: begin split=0; rdy1 = 0; resp1 = 2'b00; rws=0;end
            s4: begin split=0; rdy1 = 0; resp1 = 2'b00; rws=0; end
            default: begin #1 split=0; rdy1 = 0; resp1 = 2'b00; rws=0; end
        
        endcase

    end

endmodule