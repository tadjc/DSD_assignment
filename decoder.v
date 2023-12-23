module decoder( hsel_0, hsel_1, hsel_2, haddr,rst);

 input [15:0] haddr;  // Input address from the Address mux
 input rst;
 output reg hsel_0; // hSelect  slave0
 output reg hsel_1; //hSelect  slave1 
 output reg hsel_2; //hSelect  slave2 
 
  
 always @(*)
  if(rst)
    begin
        hsel_0 = 1'b0;
        hsel_1 = 1'b0;
        hsel_2 = 1'b0;
    end
  else
    begin
    case (haddr[15:13])
        3'b001:
            begin
              hsel_0 = 1'b1;
              hsel_1 = 1'b0;
              hsel_2 = 1'b0;
            end

        3'b010:
            begin
              hsel_0 = 1'b0;
              hsel_1 = 1'b1;
              hsel_2 = 1'b0;
            end

        3'b011:
            begin
              hsel_0 = 1'b0;
              hsel_1 = 1'b0;
              hsel_2 = 1'b1;
            end
        default:
            begin
              hsel_0 = 1'b0;
              hsel_1 = 1'b0;
              hsel_2 = 1'b0;
            end

    endcase
    end


endmodule