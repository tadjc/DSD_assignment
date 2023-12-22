module decoder(

hsel_0,// hSelect  slave0  
hsel_1,//hSelect  slave1  
hsel_2,//hSelect  slave2  
haddr,// Input address from the Address mux

//sel_slave//To read data response MUX

);

 input [15:0] haddr;
 output hsel_0;
 output hsel_1;
 output hsel_2;
 
 always @(*)
    case (haddr[15:14])
        2'b00:
            begin
              hsel_0 = 1'b1;
              hsel_1 = 1'b0;
              hsel_2 = 1'b0;
            end

        2'b01:
            begin
              hsel_0 = 1'b0;
              hsel_1 = 1'b1;
              hsel_2 = 1'b0;
            end

        2'b10:
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
    


endmodule