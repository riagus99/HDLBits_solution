module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    localparam [1:0] idle = 0, one = 1, zero = 2;
    reg [1:0] state, next_state;
    always @(posedge clk, negedge aresetn) begin
        if (!aresetn) state <= idle;
        else state <= next_state;
    end

    always @(*) begin
        case(state)
            idle : next_state = x ? one : idle;
            one : next_state = x ? one : zero;
            zero : next_state = x ? one : idle;
            default : next_state = 2'bx; 
        endcase
    end

    assign z = (state==zero) & x;
endmodule
