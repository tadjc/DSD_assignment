module TRI_BUFF_D(out, en, in,rst);
input en,rst;
input [31:0] in;
output reg [31:0] out;

always @(*)
  if(rst)
    begin
        out = 32'b0;
    end
    else
    out = in;
endmodule