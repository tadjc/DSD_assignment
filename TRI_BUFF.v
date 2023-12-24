module TRI_BUFF(out, en, in);
input en;
input [15:0] in;
output [15:0] out;

assign out = en ? in : 16'b0;
endmodule