module TRI_BUFF_D(out, en, in);
input en;
input [31:0] in;
output [31:0] out;

assign out = en ? in : 32'b0;
endmodule