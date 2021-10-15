module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    parameter [1:0] left = 0, right = 1, fall_l = 2, fall_r = 3;
    reg [1:0] state, next_state;

    always @(*) begin
        case(state)
            left : begin
                if (!ground) next_state = fall_l;
                else if (bump_left) next_state = right;
                else next_state = left;
            end
            right : begin
                if (!ground) next_state = fall_r;
                else if (bump_right) next_state = left;
                else next_state = right;
            end
            fall_l : next_state = ground ? left : fall_l;
            fall_r : next_state = ground ? right : fall_r;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        if (areset) state <= left;
        else state <= next_state;
    end

    assign walk_left = (state == left);
    assign walk_right = (state == right);
    assign aaah = (state == fall_l) | (state == fall_r);
endmodule