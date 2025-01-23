module Door_flashing (  
    input wire clk,  
    input wire reset,  
    input wire entry_sensor,  
    input wire exit_sensor,  
    input wire full,  
    output reg door_open  
);  
    reg [25:0] timer = 0;  
    reg [5:0] counter = 0; 

    always @(posedge clk or negedge reset) begin  
        if (~reset)  
            door_open <= 0;  
        else if ((entry_sensor & ~full) | exit_sensor) begin  
            counter <= 39;  
            door_open <= 1;  
        end else if (counter > 0)  
            if (timer == 10000000 - 1) begin  
                timer <= 0;  
                door_open <= ~door_open;  
                counter <= counter - 1;  
            end else timer <= timer + 1;  
    end  
endmodule  
