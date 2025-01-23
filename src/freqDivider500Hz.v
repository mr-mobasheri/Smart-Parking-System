module freqDivider500(input wire clk_in, output reg clk_out);  
    reg [25:0] counter = 0;  
    always @(posedge clk_in)  
        if (counter == 40000 - 1) begin  
            counter <= 0;  
            clk_out <= ~clk_out;  
        end else counter <= counter + 1;  
endmodule  