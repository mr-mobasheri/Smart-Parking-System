module DFF (D, CLK, reset, Q);  
    output Q;  
    input D, CLK, reset;  

    reg Q;  
    always @(posedge CLK or negedge reset)  
        if (~reset)  
            Q <= 1'b0;  
        else Q <= D;  
endmodule