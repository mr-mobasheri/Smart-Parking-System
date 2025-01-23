module main(  
    input clk,  
    input reset,  
    input entry_sensor,  
    input exit_sensor,  
    input [1:0] switch, 
    input beep_in, 
    output beep,  
    output door_open,  
    output full,  
    output [2:0] c,  
    output [1:0] L,  
    output [3:0] state,  
    output [4:0] seg_sel,  
    output [7:0] seg_data  
);  
    wire entry_sensor_dbc;  
    wire exit_sensor_dbc;  
    wire clk_500HZ;  
   
    assign beep = beep_in; 

    debouncer dbc1 (.clk(clk), .reset_n(reset), .button(~entry_sensor), .debounce(entry_sensor_dbc));  
    debouncer dbc2 (.clk(clk), .reset_n(reset), .button(~exit_sensor), .debounce(exit_sensor_dbc));  

    freqDivider500 fd500 (.clk_in(clk), .clk_out(clk_500HZ));

    parking_fsm_gate fsm (.clk(clk), .reset(reset), .entry_sensor(entry_sensor_dbc), .exit_sensor(exit_sensor_dbc), .switch(switch),  
        .c(c), .L(L), .door_open(door_open), .full(full), .current_state(state));  

    SevenSegment b (.clk(clk_500HZ), .full(full), .L(L), .c(c), .seg_sel(seg_sel), .seg_data(seg_data));  
endmodule