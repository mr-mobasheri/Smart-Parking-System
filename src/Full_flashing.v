module Full_flashing (  
    input wire clk,  
    input wire entry_sensor,  
    input wire next_full,  
    output reg full  
);  
    reg [25:0] timer = 0;  
    reg [4:0] counter = 0;  

    always @(posedge clk) begin  
        if (next_full & entry_sensor) begin  
            counter <= 7;  
            full <= next_full;  
        end else if (counter > 0)  
            if (timer == 15000000 - 1) begin  
                timer <= 0;  
                full <= ~full;  
                counter <= counter - 1;  
            end else timer <= timer + 1;  
        else full <= next_full;  
    end  
endmodule  