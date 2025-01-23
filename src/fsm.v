module parking_fsm (
    input wire clk,
    input wire reset,
    input wire entry_sensor,
    input wire exit_sensor,
    input wire [1:0] switch,
    output reg [2:0] c,
    output reg [1:0] L,
    output reg door_open,
    output reg full,
    output reg [3:0] current_state
);

    parameter S_0000 = 4'b0000, S_0001 = 4'b0001, S_0010 = 4'b0010, S_0011 = 4'b0011,
        S_0100 = 4'b0100, S_0101 = 4'b0101, S_0110 = 4'b0110, S_0111 = 4'b0111,
        S_1000 = 4'b1000, S_1001 = 4'b1001, S_1010 = 4'b1010, S_1011 = 4'b1011,
        S_1100 = 4'b1100, S_1101 = 4'b1101, S_1110 = 4'b1110, S_1111 = 4'b1111;

    
    always @(posedge clk or negedge reset) begin
        full <= current_state[0] & current_state[1] & current_state[2] & current_state[3];
        if (~reset) begin
            current_state <= 4'b000;
            door_open <= 0;
            c <= 3'b100;
            L <= 2'b00;
        end else begin
            case (current_state)
                S_0000: begin
                    if (entry_sensor) begin
                        current_state = S_0001;
                        door_open <= 1'b1;
                        L <= 3'b01;
                        c <= 3'b011;
                    end else
                        door_open <= 1'b0;
                end
                S_0001: begin
                    if (entry_sensor) begin
                        current_state = S_0011;
                        door_open <= 1'b1;
                        L <= 3'b10;
                        c <= 3'b010;
                    end else if (exit_sensor) begin
                        door_open <= 1'b0;
                        if (switch == 2'b00) begin
                            current_state = S_0000;
                            door_open <= 1'b1;
                            L <= 3'b00;
                            c <= 3'b100;
                        end
                    end else 
                        door_open <= 1'b0;
                end
                S_0010: begin
                    if (entry_sensor) begin
                        current_state = S_0011;
                        door_open <= 1'b1;
                        L <= 3'b10;
                        c <= 3'b010;
                    end else if (exit_sensor) begin
                        door_open <= 1'b0;
                        if (switch == 2'b01) begin
                            current_state = S_0000;
                            door_open <= 1'b1;
                            L <= 3'b00;
                            c <= 3'b100;
                        end
                    end else 
                        door_open <= 1'b0;
                end
                S_0011: begin
                    if (entry_sensor) begin
                        current_state = S_0111;
                        door_open <= 1'b1;
                        L <= 3'b11;
                        c <= 3'b001;
                    end else if (exit_sensor) begin
                        door_open <= 1'b0;
                        if (switch == 2'b00) begin
                            current_state = S_0010;
                            door_open <= 1'b1;
                            L <= 3'b00;
                            c <= 3'b011;
                        end
                        else if (switch == 2'b01) begin
                            current_state = S_0010;
                            door_open <= 1'b1;
                            L <= 3'b00;
                            c <= 3'b011;
                        end
                    end else 
                        door_open <= 1'b0;
                end
                S_0100: begin
                    if (entry_sensor) begin
                        current_state = S_0101;
                        door_open <= 1'b1;
                        L <= 3'b10;
                        c <= 3'b010;
                    end else if (exit_sensor) begin
                        door_open <= 1'b0;
                        if (switch == 2'b10) begin  
                            current_state = S_0000;
                            door_open <= 1'b1;
                            L <= 3'b00;
                            c <= 3'b100;
                        end
                    end else 
                        door_open <= 1'b0;
                end
                S_0101: begin
                    if (entry_sensor) begin
                        current_state = S_0111;
                        door_open <= 1'b1;
                        L <= 3'b11;
                        c <= 3'b001;
                    end else if (exit_sensor) begin
                        door_open <= 1'b0;
                        if (switch == 2'b00) begin
                            current_state = S_0100;
                            door_open <= 1'b1;
                            L <= 3'b00;
                            c <= 3'b011;
                        end
                        else if (switch == 2'b10) begin
                            current_state = S_0001;
                            door_open <= 1'b1;
                            L <= 3'b01;
                            c <= 3'b011;
                        end
                    end else 
                        door_open <= 1'b0;
                end
                S_0110: begin
                    if (entry_sensor) begin
                        current_state = S_0111;
                        door_open <= 1'b1;
                        L <= 3'b11;
                        c <= 3'b001;
                    end else if (exit_sensor) begin
                        door_open <= 1'b0;
                        if (switch == 2'b01) begin
                            current_state = S_0100;
                            door_open <= 1'b1;
                            L <= 3'b00;
                            c <= 3'b011;
                        end
                        else if (switch == 2'b10) begin
                            current_state = S_0100;
                            door_open <= 1'b1;
                            L <= 3'b00;
                            c <= 3'b011;
                        end
                    end else 
                        door_open <= 1'b0;
                end
                S_0111: begin
                    if (entry_sensor) begin
                        current_state = S_1111;
                        door_open <= 1'b1;
                        L <= 3'bxx;
                        c <= 3'b000;
                    end else if (exit_sensor) begin
                        door_open <= 1'b0;
                        if (switch == 2'b00) begin
                            current_state = S_0110;
                            door_open <= 1'b1;
                            L <= 3'b00;
                            c <= 3'b010;
                        end
                        else if (switch == 2'b01) begin
                            current_state = S_0101;
                            door_open <= 1'b1;
                            L <= 3'b01;
                            c <= 3'b010;
                        end
                        else if (switch == 2'b10) begin
                            current_state = S_0011;
                            door_open <= 1'b1;
                            L <= 3'b10;
                            c <= 3'b010;
                        end
                    end else 
                        door_open <= 1'b0;
                end
                S_1000: begin
                    if (entry_sensor) begin
                        current_state = S_1001;
                        door_open <= 1'b1;
                        L <= 3'b01;
                        c <= 3'b010;
                    end else if (exit_sensor) begin
                        door_open <= 1'b0;
                        if (switch == 2'b11) begin
                            current_state = S_0000;
                            door_open <= 1'b1;
                            L <= 3'b00;
                            c <= 3'b100;
                        end
                    end else 
                        door_open <= 1'b0;
                end
                S_1001: begin
                    if (entry_sensor) begin
                        current_state = S_1011;
                        door_open <= 1'b1;
                        L <= 3'b10;
                        c <= 3'b001;
                    end else if (exit_sensor) begin
                        door_open <= 1'b0;
                        if (switch == 2'b00) begin
                            current_state = S_1000;
                            door_open <= 1'b1;
                            L <= 3'b01;
                            c <= 3'b011;
                        end
                        else if (switch == 2'b11) begin
                            current_state = S_0001;
                            door_open <= 1'b1;
                            L <= 3'b00;
                            c <= 3'b011;
                        end
                    end else 
                        door_open <= 1'b0;
                end
                S_1010: begin
                    if (entry_sensor) begin
                        current_state = S_1011;
                        door_open <= 1'b1;
                        L <= 3'b10;
                        c <= 3'b001;
                    end else if (exit_sensor) begin
                        door_open <= 1'b0;
                        if (switch == 2'b01) begin
                            current_state = S_1000;
                            door_open <= 1'b1;
                            L <= 3'b00;
                            c <= 3'b011;
                        end
                        else if (switch == 2'b11) begin
                            current_state = S_0010;
                            door_open <= 1'b1;
                            L <= 3'b00;
                            c <= 3'b011;
                        end
                    end else 
                        door_open <= 1'b0;
                end
                S_1011: begin
                    if (entry_sensor) begin
                        current_state = S_1111;
                        door_open <= 1'b1;
                        L <= 3'bxx;
                        c <= 3'b000;
                    end else if (exit_sensor) begin
                        door_open <= 1'b0;
                        if (switch == 2'b00) begin
                            current_state = S_1010;
                            door_open <= 1'b1;
                            L <= 3'b00;
                            c <= 3'b010;
                        end
                        else if (switch == 2'b01) begin
                            current_state = S_1001;
                            door_open <= 1'b1;
                            L <= 3'b01;
                            c <= 3'b010;
                        end
                        else if (switch == 2'b11) begin
                            current_state = S_0011;
                            door_open <= 1'b1;
                            L <= 3'b10;
                            c <= 3'b010;
                        end
                    end else 
                        door_open <= 1'b0;
                end
                S_1100: begin
                    if (entry_sensor) begin
                        current_state = S_1101;
                        door_open <= 1'b1;
                        L <= 3'b10;
                        c <= 3'b001;
                    end else if (exit_sensor) begin
                        door_open <= 1'b0;
                        if (switch == 2'b10) begin
                            current_state = S_1000;
                            door_open <= 1'b1;
                            L <= 3'b00;
                            c <= 3'b011;
                        end
                        else if (switch == 2'b11) begin
                            current_state = S_0100;
                            door_open <= 1'b1;
                            L <= 3'b00;
                            c <= 3'b011;
                        end
                    end else 
                        door_open <= 1'b0;
                end
                S_1101: begin
                    if (entry_sensor) begin
                        current_state = S_1111;
                        door_open <= 1'b1;
                        L <= 3'bxx;
                        c <= 3'b000;
                    end else if (exit_sensor) begin
                        door_open <= 1'b0;
                        if (switch == 2'b00) begin
                            current_state = S_1100;
                            door_open <= 1'b1;
                            L <= 3'b00;
                            c <= 3'b010;
                        end
                        else if (switch == 2'b10) begin
                            current_state = S_1001;
                            door_open <= 1'b1;
                            L <= 3'b01;
                            c <= 3'b010;
                        end
                        else if (switch == 2'b11) begin
                            current_state = S_0101;
                            door_open <= 1'b1;
                            L <= 3'b01;
                            c <= 3'b010;
                        end
                    end else 
                        door_open <= 1'b0;
                end
                S_1110: begin
                    if (entry_sensor) begin
                        current_state = S_1111;
                        door_open <= 1'b1;
                        L <= 3'bxx;
                        c <= 3'b000;
                    end else if (exit_sensor) begin
                        door_open <= 1'b0;
                        if (switch == 2'b01) begin
                            current_state = S_1100;
                            door_open <= 1'b1;
                            L <= 3'b00;
                            c <= 3'b010;
                        end
                        else if (switch == 2'b10) begin
                            current_state = S_1010;
                            door_open <= 1'b1;
                            L <= 3'b00;
                            c <= 3'b010;
                        end
                        else if (switch == 2'b11) begin
                            current_state = S_0110;
                            door_open <= 1'b1;
                            L <= 3'b00;
                            c <= 3'b010;
                        end
                    end else 
                        door_open <= 1'b0;
                end
                S_1111: begin
                    if (exit_sensor) begin
                        door_open <= 1'b0;
                        if (switch == 2'b00) begin
                            current_state = S_1110;
                            door_open <= 1'b1;
                            L <= 3'b00;
                            c <= 3'b001;
                        end
                        else if (switch == 2'b10) begin
                            current_state = S_1101;
                            door_open <= 1'b1;
                            L <= 3'b01;
                            c <= 3'b001;
                        end
                        else if (switch == 2'b10) begin
                            current_state = S_1011;
                            door_open <= 1'b1;
                            L <= 3'b00;
                            c <= 3'b001;
                        end
                        else if (switch == 2'b11) begin
                            current_state = S_0111;
                            door_open <= 1'b1;
                            L <= 3'b00;
                            c <= 3'b001;
                        end
                    end else 
                        door_open <= 1'b0;
                end
            endcase
        end
    end

endmodule