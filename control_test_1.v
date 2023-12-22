module control_test_1(sel1,sel2,sel3,sel4,start,done,clk,mux1,mux2);
input clk,start;
output reg sel1,sel2,sel3,sel4,mux1,mux2,done;

reg [2:0] state;
parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100, s5 = 3'b101;

always @(posedge clk)
    begin
        case (state)
            s0: if (start) state <= s1;
            s1: state <= s2;
            s2: state <= s3;
            s3: state <= s4;
            s4: state <= s5;
            s5: state <= s0;
            default: state <= s0;
        endcase
    end

always @(state)
    begin
        case (state)
            s0: begin #1 sel1=0; sel2 = 0; mux1 = 0; sel3=0; sel4 = 0; mux2 = 0; done=0; end
            s1: begin #1 sel1=1; sel2 = 0; mux1 = 0; sel3=0; sel4 = 0; mux2 = 0; done=0; end
            s2: begin #1 sel1=0; sel2 = 1; mux1 = 1; sel3=0; sel4 = 0; mux2 = 0; done=0; end
            s3: begin #1 sel1=0; sel2 = 0; mux1 = 0; sel3=1; sel4 = 0; mux2 = 0; done=0; end
            s4: begin #1 sel1=0; sel2 = 0; mux1 = 0; sel3=0; sel4 = 1; mux2 = 1; done=0; end
            s5: begin #1 sel1=0; sel2 = 0; mux1 = 0; sel3=0; sel4 = 0; mux2 = 0; done=1; end
            default: begin #1 sel1=0; sel2 = 0; mux1 = 0;sel3=0; sel4 = 0; mux2 = 0; done=0; end
        
        endcase

    end

endmodule


