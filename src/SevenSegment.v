module SevenSegment(  
    input clk,  
    input full,  
    input [1:0] L,  
    input [2:0] c,  
    output reg [4:0] seg_sel,  
    output reg [7:0] seg_data  
);  
    function [7:0] bcd_to_7segment(input [2:0] bcd);  
        case (bcd)  
            3'b000: bcd_to_7segment = 8'b00111111;  
            3'b001: bcd_to_7segment = 8'b00000110;  
            3'b010: bcd_to_7segment = 8'b01011011;  
            3'b011: bcd_to_7segment = 8'b01001111;  
            3'b100: bcd_to_7segment = 8'b01100110;  
            3'b101: bcd_to_7segment = 8'b01101101;  
            3'b110: bcd_to_7segment = 8'b01110001; //F  
            3'b111: bcd_to_7segment = 8'b01000000; //-  
            default: bcd_to_7segment = 8'b01000000; //-  
        endcase  
    endfunction  

    reg [1:0] digit_select = 0;  
    reg [2:0] current_digit = 0;  

    always @(posedge clk) begin 
        if (digit_select == 2'b00) begin 
            current_digit <= c; 
            seg_sel <= 5'b01000; 
            digit_select <= digit_select + 1;
        end else if (digit_select == 2'b01) begin
            if (full)
                current_digit <= 3'b111;
            else
                current_digit <= {1'b0, L};
            seg_sel <= 5'b00010; 
            digit_select <= digit_select + 1;
        end else if (digit_select == 2'b10) begin
            if (full)
                current_digit <= 3'b110;
            else
                current_digit <= 3'b111; 
            seg_sel <= 5'b00001; 
            digit_select <= digit_select + 1;
        end else begin
            current_digit <= 3'b111; 
            seg_sel <= 5'b00100; 
            digit_select <= 2'b00;
        end  
        seg_data <= bcd_to_7segment(current_digit);  
    end  
endmodule