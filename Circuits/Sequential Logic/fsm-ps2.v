module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //
    localparam [1:0] idle = 0, second_state = 1, third_state = 2, done_state = 3;
    reg [1:0] state, next_state;
    // State transition logic (combinational)
    always @(*) begin
        case(state)
            idle : next_state = in[3] ? second_state : idle;
            second_state : next_state = third_state;
            third_state : next_state = done_state;
            done_state : next_state = in[3] ? second_state : idle;
        endcase
    end
    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset) state <= idle;
        else state <= next_state;
    end
    // Output logic
    assign done = (state==done_state);
endmodule