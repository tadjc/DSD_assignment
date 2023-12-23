module slave_control(slrsp_1, sl_rdy_1,clk,rst,sw1,sa1);

//module control_test_1(sel1,sel2,sel3,sel4,start,done,clk,mux1,mux2);

input clk;
output reg slrsp_1,sl_rdy_1,rst,sw1,sa1;

reg [2:0] state;
parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100;

always @(posedge clk)
    begin
        case (state)
            s0: state <= s1;
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
            s0: begin #1 slrsp_1 = 0; sl_rdy_1 = 0; rst = 0; sw1 = 0; sa1 = 0; end
            s1: begin #1 slrsp_1 = 0; sl_rdy_1 = 1; rst = 0; sw1 = 0; sa1 = 0; end
            s2: begin #1 slrsp_1 = 0; sl_rdy_1 = 0; rst = 0; sw1 = 0; sa1 = 1; end
            s3: begin #1 slrsp_1 = 0; sl_rdy_1 = 0; rst = 0; sw1 = 1; sa1 = 0; end
            s4: begin #1 slrsp_1 = 0; sl_rdy_1 = 0; rst = 0; sw1 = 0; sa1 = 0;  end
            
            default: begin #1 slrsp_1 = 0; sl_rdy_1 = 0; rst = 0; sw1 = 0; sa1 = 0; end
        
        endcase

    end

endmodule


