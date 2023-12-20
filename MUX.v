module MUX(out, in0, in1, sel);

input sel;
input [15:0]in0, in1;
output reg [15:0]out;

assign out = sel ? in1 : in0;

endmodule