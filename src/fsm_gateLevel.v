module parking_fsm_gate (  
    input wire clk,  
    input wire reset,  
    input wire entry_sensor,  
    input wire exit_sensor,  
    input wire [1:0] switch,  
    output wire [2:0] c,  
    output wire [1:0] L,  
    output wire door_open,  
    output wire full,  
    output wire [3:0] current_state  
);  
    wire [3:0] next_state;  
    wire [2:0] next_c;  
    wire [1:0] next_L;  
    wire next_full;  

    assign next_state[0] = (entry_sensor & ~current_state[0]) ? 1'b1 :  
                           (exit_sensor & (switch == 2'b00)) ? 1'b0 : current_state[0];  

    assign next_state[1] = entry_sensor & current_state[0] & ~current_state[1] ? 1'b1 :  
                           (exit_sensor & (switch == 2'b01)) ? 1'b0 : current_state[1];

    assign next_state[2] = entry_sensor & current_state[0] & current_state[1] & ~current_state[2] ? 1'b1 :  
                           (exit_sensor & (switch == 2'b10)) ? 1'b0 : current_state[2];  

    assign next_state[3] = entry_sensor & current_state[0] & current_state[1] & current_state[2] & ~current_state[3] ? 1'b1 :  
                           (exit_sensor & (switch == 2'b11)) ? 1'b0 : current_state[3];  

    DFF dff_state0 (.D(next_state[0]), .CLK(clk), .reset(reset), .Q(current_state[0]));  
    DFF dff_state1 (.D(next_state[1]), .CLK(clk), .reset(reset), .Q(current_state[1]));  
    DFF dff_state2 (.D(next_state[2]), .CLK(clk), .reset(reset), .Q(current_state[2]));  
    DFF dff_state3 (.D(next_state[3]), .CLK(clk), .reset(reset), .Q(current_state[3]));  

    assign next_c = ~reset ? 3'b100 : (entry_sensor * ~next_full) ? c - 1 :  
                    exit_sensor ? c + 1 : c;  

    DFF dff_c0 (.D(next_c[0]), .CLK(clk) , .reset(1'b1), .Q(c[0]));  
    DFF dff_c1 (.D(next_c[1]), .CLK(clk), .reset(1'b1), .Q(c[1]));  
    DFF dff_c2 (.D(next_c[2]), .CLK(clk), .reset(1'b1), .Q(c[2]));  

    assign next_L[0] =  ~current_state[0] ? 1'b0 :  
                        ~current_state[1] ? 1'b1 :  
                        ~current_state[2] ? 1'b0 : 
                        ~current_state[3] ? 1'b1 : 1'bx;

    assign next_L[1] =  ~current_state[0] ? 1'b0 :  
                        ~current_state[1] ? 1'b0 :  
                        ~current_state[2] ? 1'b1 : 
                        ~current_state[3] ? 1'b1 : 1'bx;  

    DFF dff_L0 (.D(next_L[0]), .CLK(clk) , .reset(reset), .Q(L[0]));  
    DFF dff_L1 (.D(next_L[1]), .CLK(clk), .reset(reset), .Q(L[1]));  

    assign next_full = current_state[0] & current_state[1] & current_state[2] & current_state[3];  

    Door_flashing door_flashing (.clk(clk), .reset(reset), .entry_sensor(entry_sensor), .exit_sensor(exit_sensor), .full(full), .door_open(door_open));  

    Full_flashing full_flashing (.clk(clk), .entry_sensor(entry_sensor), .next_full(next_full), .full(full));  
endmodule