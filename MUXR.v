module MUXR( hrdata_1, hrdata_2,hrdata_3,hreadyout_1,hreadyout_2,hreadyout_3,hresp_1,hresp_2,hresp_3,sel,
                    hrdata,hreadyout,hresponse);


input [31:0] hrdata_1;
input [31:0] hrdata_2;
input [31:0] hrdata_3;

input hreadyout_1;
input hreadyout_2;
input hreadyout_3;

input hresp_1;
input hresp_2;
input hresp_3;

input [1:0] sel

output reg [31:0] hrdata;
output reg hrdata;
output reg hresponse;


always @(*)
    case (sel)
        2'b00:
            begin

                hrdata = hrdata_1;
                hreadyout = hreadyout_1;
                hresponse = hresp_1;
                  
            end


        2'b01:
            begin

                hrdata = hrdata_2;
                hreadyout = hreadyout_2;
                hresponse = hresp_2;

            end

        2'b10:
            begin

                hrdata = hrdata_3;
                hreadyout = hreadyout_3;
                hresponse = hresp_3;

            end

       default:
            begin

                hrdata = hrdata_2;
                hreadyout = hreadyout_2;
                hresponse = hresp_2;

            end


    endcase


endmodule