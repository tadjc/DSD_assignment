module control_states(sel1,sel2,sel3,sel4,mux2,clk,mux1,rst,Aout,Dout,
                            busreq_1,busreq_2,grant_1,grant_2,split,response,ready,read_write,error);

input clk,rst,busreq_1,busreq_2,split,ready,read_write;
input [1:0] response;
output reg sel1,sel2,mux1,sel3,sel4,mux2,Aout,Dout,grant_1,grant_2,error;



wire [1:0] REQ;
assign REQ[0] = busreq_1;
assign REQ[1] = busreq_2;

parameter M1 = 2'b01, M2 = 2'b10, MB = 2'b11;

reg [2:0] state;
parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100;

always @(posedge clk)
     begin
        case (state)
            s0: if (~rst) begin
                    case (REQ)
                        M1: begin
                                if(ready==1 && split ==0 && response == 2'b00 && read_write == 1) //1 - write / 0 - read
                                    begin
                                        grant_1 = 1;
                                        grant_2 = 0;
                                        state <= s1;
                                    end

                                else if (ready==1 && split ==0 && response == 2'b00 && read_write == 0)
                                    begin
                                        grant_1 = 1;
                                        grant_2 = 0;
                                        state <= s2;
                                    end
                                else
                                    state <= s0;
                            end

                        M2: begin
                            if(ready==1 && split ==0 && response == 2'b00 && read_write == 1) //1 - write / 0 - read
                                    begin
                                        grant_1 = 0;
                                        grant_2 = 1;
                                        state <= s3;
                                    end

                                else if (ready==1 && split ==0 && response == 2'b00 && read_write == 0)
                                    begin
                                        grant_1 = 0;
                                        grant_2 = 1;
                                        state <= s4;
                                    end
                                else
                                    state <= s0;
                            end
                        MB: begin
                            if(ready==1 && split ==0 && response == 2'b00 && read_write == 1) //1 - write / 0 - read
                                    begin
                                        grant_1 = 1;
                                        grant_2 = 0;
                                        state <= s1;
                                    end

                                else if (ready==1 && split ==0 && response == 2'b00 && read_write == 0)
                                    begin
                                        grant_1 = 1;
                                        grant_2 = 0;
                                        state <= s2;
                                    end
                                else
                                    state <= s0;
                            end
                        default: state <= s0;
                       endcase
                    end

                        else begin
                    grant_1 = 0;
                    grant_2 = 0;
                    end       

            s1: if (~rst) 
                    begin
                        case(response)
                            00: 
                                if(ready)
                                    begin
                                        state <= s0;
                                    end
                            01: 
                                begin
                                    error = 1;
                                    state <= s0;
                                end

                            10: 
                                state <= s1;

                            11:
                                state <= s1;
                            
                            default: state <= s0;
                        endcase
                    end
                
               else begin
                    grant_1 = 0;
                    grant_2 = 0;
                    end
           // s1: state <= s2; //slave 1 write state

            s2:  //slave 1 read state
                if (~rst) begin
                    case(response)
                        00: 
                            if(ready)
                                begin
                                    state <= s0;
                                end
                        01: 
                            begin
                                error = 1;
                                state <= s0;
                            end

                        10: 
                            state <= s2;

                        11:
                            state <= s2;
                          
                        default: state <= s0;
                    endcase
                end
                else begin
                    grant_1 = 0;
                    grant_2 = 0;
                    end
                
            s3: //slave 2 write state
                if (~rst) 
                    begin
                        case(response)
                            00: 
                                if(ready)
                                    begin
                                        state <= s0;
                                    end
                            01: 
                                begin
                                    error = 1;
                                    state <= s0;
                                end

                            10: 
                                state <= s3;

                            11:
                                state <= s3;
                            
                            default: state <= s0;
                        endcase
                end
                
               else begin
                    grant_1 = 0;
                    grant_2 = 0;
                    end


            s4:  //slave 2 read state
                        if (~rst) begin
                            case(response)
                                00: 
                                    if(ready)
                                        begin
                                            state <= s0;
                                        end
                                01: 
                                    begin
                                        error = 1;
                                        state <= s0;
                                    end

                                10: 
                                    state <= s4;

                                11:
                                    state <= s4;
                                
                                default: state <= s0;
                            endcase
                        end
                        
                     else begin
                    grant_1 = 0;
                    grant_2 = 0;
                    end   

                    default: state <= s0;
                endcase
            end

always @(state)
    begin
        case (state)
            s0: begin  sel1=0; sel2 = 0; mux1 = 0; Aout = 0; sel3=0; sel4 = 0; mux2 = 0; Dout = 0;grant_1=0;grant_2=0;error =0; #20; end
            s1: begin  sel1=1; sel2 = 0; mux1 = 0; Aout = 1; sel3=1; sel4 = 0; mux2 = 0; Dout = 1; #20; end //data write to slave1
            s2: begin  sel1=1; sel2 = 0; mux1 = 0; Aout = 1; sel3=0; sel4 = 0; mux2 = 0; Dout = 0; #20;  end //data read from slave 1
            s3: begin  mux1=1; sel2 = 1; sel1 = 0; Aout = 0; sel3=0; sel4 = 0; mux2 = 1; Dout = 1; #20;  end//data write to slave2
            s4: begin  sel1 = 0; sel2 = 1; mux1=1; Aout = 0; sel3=0; sel4 = 0; mux2 = 0; Dout = 0; #20;  end //data read from slave 1
            default: begin sel1=0; sel2 = 0; mux1 = 0; Aout = 0; sel3=0; sel4 = 0; mux2 = 0; Dout = 0;grant_1=0;grant_2=0;error =0; #20;end
        
        endcase

    end

endmodule


