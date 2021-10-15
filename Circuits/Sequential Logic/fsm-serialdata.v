module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output reg [7:0] out_byte,
    output done
); //

    // Use FSM from Fsm_serial
    localparam idle = 0, start = 1, done_state = 10, stuckat0 = 11, stuckat1 = 12;
    localparam ending = start + 8;
    reg [3:0] state, next_state;
    always @(*) begin
        if(state == idle) next_state = in ? idle : start;
        else if(state==ending) next_state = in ? done_state : stuckat0;
        else if(state==done_state) next_state = in ? stuckat1 : start;
        else if(state==stuckat0) next_state = in ? idle : stuckat0;
        else if(state==stuckat1) next_state = in ? stuckat1 : start;
        else next_state = state + 1;
    end
    always @(posedge clk) begin
        if(reset) state <= 0;
        else state <= next_state;
    end
    assign done = (state == done_state);
    // New: Datapath to latch input bits.
    always @(posedge clk) begin
        if (state >= start & state < ending) out_byte <= {in, out_byte[7:1]};
    end
endmodule