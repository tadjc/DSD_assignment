module control_states(sel1,sel2,sel3,sel4,mux2,clk,mux1,rst,Aout);
input clk,rst;
output reg sel1,sel2,mux1,sel3,sel4,mux2,Aout;

reg [2:0] state;
parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100;

always @(posedge clk)
    begin
        case (state)
            s0: if (~rst) state <= s1;
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
            s0: begin #10 sel1=0; sel2 = 0; mux1 = 0; Aout = 0; sel3=0; sel4 = 0; mux2 = 0; end
            s1: begin #10 sel1=1; sel2 = 0; mux1 = 0; Aout = 0; sel3=1; sel4 = 0; mux2 = 0; end
            s2: begin #10 sel1=0; sel2 = 1; mux1 = 0; Aout = 0; sel3=0; sel4 = 1; mux2 = 0;  end
            s3: begin #10 mux1=1; sel2 = 1; sel1 = 0; Aout = 0; sel3=0; sel4 = 1; mux2 = 1;  end
            s4: begin #10 sel1 = 0; sel2 = 0; mux1=0; Aout = 0; sel3=0; sel4 = 0; mux2 = 0;  end
            default: begin #10 sel1=0; sel2 = 0; mux1 = 0; Aout = 0; sel3=0; sel4 = 0; mux2 = 0;  end
        
        endcase

    end

endmodule


