module MUXR(hrdata,hreadyout,hresponse, hrdata_1, hrdata_2,hrdata_3,hreadyout_1,hreadyout_2,hreadyout_3,
                hresp_1,hresp_2,hresp_3,sel);


input [31:0] hrdata_1;
input [31:0] hrdata_2;
input [31:0] hrdata_3;

input hreadyout_1;
input hreadyout_2;
input hreadyout_3;

input [1:0] hresp_1;
input [1:0] hresp_2;
input [1:0] hresp_3;

input [2:0] sel;

output reg [31:0] hrdata;
output reg hreadyout;
output reg [1:0] hresponse;


always @(*)
    case (sel)

        3'b000:
            begin

                hrdata = 32'bz;
                hreadyout = hreadyout;
                hresponse = 2'bz;
                  
            end

        3'b001:
            begin

                hrdata = hrdata_1;
                hreadyout = hreadyout_1;
                hresponse = hresp_1;
                  
            end


        3'b010:
            begin

                hrdata = hrdata_2;
                hreadyout = hreadyout_2;
                hresponse = hresp_2;

            end

        3'b011:
            begin

                hrdata = hrdata_3;
                hreadyout = hreadyout_3;
                hresponse = hresp_3;

            end

       default:
            begin

                hrdata = 32'bz;
                hreadyout = hreadyout;
                hresponse = 2'bz;

            end


    endcase


endmodule