module control_test_1(sel1,sel2,start,done,clk,mux1);
input clk,start;
output reg sel1,sel2,mux1,done;

reg [2:0] state;
parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100;

always @(posedge clk)
    begin
        case (state)
            s0: if (start) state <= s1;
            s1: state <= s2;
            s2: state <=s3;
            s3: state <= s4;
            s4: state <= s4;
            default: state <= s0;
        endcase
    end

always @(state)
    begin
        case (state)
            s0: begin #1 sel1=0; sel2 = 0; mux1 = 0; end
            s1: begin #1 sel1=1; sel2 = 0; mux1 = 0; end
            s2: begin #1 sel2=1; sel1 = 0; mux1 = 0; end
            s3: begin #1 mux1=1; sel2 = 0; sel1 = 0; end
            s4: begin #1 done=1; sel1 = 0; sel2 = 0; mux1=0; end
            default: begin #1 sel1=0; sel2 = 0; mux1 = 0; end
        
        endcase

    end

endmodule


