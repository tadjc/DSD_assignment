module COMPAR(
  input [15:0] A, B,
  output reg  A_eq_B);
  
  always@(*) 
    begin
        if(A==B)
            A_eq_B = 1'b1;
        else
            A_eq_B = 1'b0;

    end
endmodule