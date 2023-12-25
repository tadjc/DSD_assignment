module TRI_BUFF(out, en, in,rst);
input en,rst;
input [15:0] in;
output reg [15:0] out;

always @(*)
  if(rst)
    begin
        out = 16'b0;
    end
    else
    out = in;
endmodule