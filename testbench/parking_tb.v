`include "fsm_gateLevel.v"

module parking_tb;
    reg clk;
    reg reset;
    reg entry_sensor;
    reg exit_sensor;
    reg [1:0] switch;
    wire [2:0] c;
    wire [1:0] L;
    wire door_open;
    wire full;
    wire [3:0] current_state;

    parking_fsm uut (
        .clk(clk),
        .reset(reset),
        .entry_sensor(entry_sensor),
        .exit_sensor(exit_sensor),
        .switch(switch),
        .c(c),
        .L(L),
        .door_open(door_open),
        .full(full),
        .current_state(current_state)
    );

    initial begin
        $dumpfile ("parking_tb.vcd");
        $dumpvars (0, parking_tb);
        clk = 1;
        forever #5 clk = ~clk;
    end

    integer file, r;
    reg [3:0] temp;

    initial begin
        reset = 0;
        entry_sensor = 0;
        exit_sensor = 0;
        switch = 2'b00;
        #10;

        file = $fopen("input.txt", "r");
        if (file == 0) begin
            $display("Error: Could not open file.");
            $finish;
        end

        reset = 1;
        #10;

        while (!$feof(file)) begin
            r = $fscanf(file, "%b\n", temp);
            if (r != 1) begin
                $display("Error reading line.");
                $fclose(file);
                $finish;
            end
            entry_sensor = temp[3];
            exit_sensor = temp[2];
            switch = temp[1:0];
            #10;
            // $display ("inputs: %b%b%b %t", entry_sensor, exit_sensor, switch, $time);
            $write ("%04b [%d,%d] ", current_state, c, L);
            if (entry_sensor & full)
                    $write ("Full\n");
            else if (door_open)
                $write ("door\n");
            else
                $write ("\n");
        end

        $fclose(file);
        #10;
        $finish;
    end
endmodule
