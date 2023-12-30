module control_states(sel1,sel2,sel3,sel4,mux2,clk,mux1,rst,Aout,Dout,
                            busreq_1,busreq_2,grant_1,grant_2,split,response,ready,read_write,error);

input clk,rst,busreq_1,busreq_2,split,ready,read_write;
input [1:0] response;
output reg sel1,sel2,mux1,sel3,sel4,mux2,Aout,Dout,grant_1,grant_2,error;


parameter M1 = 2'bx1, M2 = 2'b1x, MB = 2'b11, MX1 = 2'b0x, MX2 = 2'bx0, M11 = 2'b01, M22 = 2'b10 ;
parameter OKAY = 2'b00, ERROR = 2'b01, RETRY = 2'b10, SPLIT = 2'b11;

reg [2:0] state;
parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100;

always @(posedge clk or posedge rst)
    begin
    if(rst)
        state <= s0;
    end

always @(posedge clk)
    begin
        case (state)
            s0: if(~rst)
                    begin
                        case ({busreq_2,busreq_1})
                            M1: begin
                                    if(ready==1 && split ==0 && response == 2'b00 && read_write == 1) //1 - write / 0 - read
                                        begin
                                            grant_1 <= 1;
                                            grant_2 <= 0;
                                            error <= 0;
                                            state <= s1; 
                                        end

                                    else if (ready==1 && split ==0 && response == 2'b00 && read_write == 0)
                                        begin
                                            grant_1 <= 1;
                                            grant_2 <= 0;
                                            state <= s2;
                                        end
                                    else
                                        state <= s0;
                                end

                            M11: begin
                                    if(ready==1 && split ==0 && response == 2'b00 && read_write == 1) //1 - write / 0 - read
                                        begin
                                            grant_1 <= 1;
                                            grant_2 <= 0;
                                            error <= 0;
                                            state <= s1; 
                                        end

                                    else if (ready==1 && split ==0 && response == 2'b00 && read_write == 0)
                                        begin
                                            grant_1 <= 1;
                                            grant_2 <= 0;
                                            state <= s2;
                                        end
                                    else
                                        state <= s0;
                                end

                            M2: begin
                                    if(ready==1 && split ==0 && response == 2'b00 && read_write == 1) //1 - write / 0 - read
                                        begin
                                            grant_1 <= 0;
                                            grant_2 <= 1;
                                            
                                            state <= s3; 
                                        end

                                    else if (ready==1 && split ==0 && response == 2'b00 && read_write == 0)
                                        begin
                                           
                                            grant_1 <= 0;
                                            grant_2 <= 1;
                                            state <= s4;
                                        end
                                    else
                                        state <= s0;
                                end

                            M22: begin
                                    if(ready==1 && split ==0 && response == 2'b00 && read_write == 1) //1 - write / 0 - read
                                        begin
                                            grant_1 <= 0;
                                            grant_2 <= 1;
                                            
                                            state <= s3; 
                                        end

                                    else if (ready==1 && split ==0 && response == 2'b00 && read_write == 0)
                                        begin
                                           
                                            grant_1 <= 0;
                                            grant_2 <= 1;
                                            state <= s4;
                                        end
                                    else
                                        state <= s0;
                                end
                            

                            MB: begin
                                    if(ready==1 && split ==0 && response == 2'b00 && read_write == 1) //1 - write / 0 - read
                                        begin
                                            grant_1 <= 1;
                                            grant_2 <= 0;
                                           
                                            state <= s1; 
                                        end

                                    else if (ready==1 && split ==0 && response == 2'b00 && read_write == 0)
                                        begin
                                            grant_1 <= 1;
                                            grant_2 <= 0;
                                            state <= s2;
                                        end
                                    else
                                        state <= s0;
                                end
                           
                         

                            default: state <= s0;
                        endcase
                    end
                    //state <= s1;
                   
            
             
            s1: if(~rst)
                     begin
                        case(response)
                            OKAY: 
                                if(ready)
                                    begin
                                        state <= 0;
                                    end
                                else 
                                    state <= s1;
                                    
                            ERROR: 
                                begin
                                    error <= 1;
                                    state <= s0;
                                end

                            RETRY: 
                                begin
                                    state <= s1;
                                    
                                end
                            SPLIT:
                                state <= s1;
                            
                            default: begin 
                                       state <= s0;
                                     
                                     end
                        endcase
                    end
            
            s2: if(~rst)
                    begin
                        case(response)
                            OKAY: 
                                if(ready)
                                    begin
                                        state <= 0;
                                    end
                                else 
                                    state <= s2;
                                    
                            ERROR: 
                                begin
                                    error <= 1;
                                    state <= s0;
                                end

                            RETRY: 
                                state <= s2;

                            SPLIT:
                                state <= s2;
                            
                            default: begin 
                                       state <= s0;
                                     
                                     end
                        endcase
                    end
            
      
            s3: if(~rst)
                    begin
                        case(response)
                            OKAY: 
                                if(ready)
                                    begin
                                        state <= 0;
                                    end
                                else 
                                    state <= s3;
                                    
                            ERROR: 
                                begin
                                    error <= 1;
                                    state <= s0;
                                end

                            RETRY: 
                                state <= s3;

                            SPLIT:
                                state <= s3;
                            
                            default: begin 
                                       state <= s0;
                                     
                                     end
                        endcase
                    end
            
            
            s4: if(~rst)
                    begin
                        case(response)
                            OKAY: 
                                if(ready)
                                    begin
                                        state <= 0;
                                    end
                                else 
                                    state <= s4;
                                    
                            ERROR: 
                                begin
                                    error <= 1;
                                    state <= s0;
                                end

                            RETRY: 
                                state <= s4;

                            SPLIT:
                                state <= s4;
                            
                            default: begin 
                                       state <= s0;
                                     
                                     end
                        endcase
                    end
            
            
            
           default: begin state <= s0; end

        endcase
    end

always @(state)
    begin
        case (state)
            s0: begin  sel1=0; sel2 = 0; mux1 = 0; Aout = 0; sel3=0; sel4 = 0; mux2 = 0; Dout = 0; ; grant_1 = 0; grant_2 = 0;end
            s1: begin  sel1=1; sel2 = 0; mux1 = 0; Aout = 1; sel3=1; sel4 = 0; mux2 = 0; Dout = 1; ; end //data write to slave1
            s2: begin  sel1=1; sel2 = 0; mux1 = 0; Aout = 1; sel3=0; sel4 = 0; mux2 = 0; Dout = 0; ;  end //data read from slave 1
            s3: begin  mux1=1; sel2 = 1; sel1 = 0; Aout = 0; sel3=0; sel4 = 0; mux2 = 1; Dout = 1; ;  end//data write to slave2
            s4: begin  sel1 = 0; sel2 = 1; mux1=1; Aout = 0; sel3=0; sel4 = 0; mux2 = 0; Dout = 0; ;  end //data read from slave 1
            default: begin sel1=0; sel2 = 0; mux1 = 0; Aout = 0; sel3=0; sel4 = 0; mux2 = 0; Dout = 0;grant_1=0;grant_2=0;error =0;  #20;end
        
        endcase

    end

endmodule


