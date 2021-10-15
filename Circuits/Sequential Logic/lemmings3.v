module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    parameter [2:0] left = 0, right = 1, left_dig = 2, right_dig = 3, left_fall = 4, right_fall = 5;
    reg [2:0] state, next_state;

    always @(*) begin
        case(state)
            left : begin
                if (!ground) next_state = left_fall;
                else if (dig) next_state = left_dig;
                else if (bump_left) next_state = right;
                else next_state = left;
            end
            right : begin
                if (!ground) next_state = right_fall;
                else if (dig) next_state = right_dig;
                else if (bump_right) next_state = left;
                else next_state = right;
            end
            left_dig : begin
                if (!ground) next_state = left_fall;
                else next_state = left_dig;
            end
            right_dig : begin
                if (!ground) next_state = right_fall;
                else next_state = right_dig;
            end
            left_fall : next_state = ground ? left : left_fall;
            right_fall : next_state = ground ? right : right_fall;
            default : next_state = 3'bx;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        if (areset) state <= left;
        else state <= next_state;
    end

    assign walk_left = (state == left);
    assign walk_right = (state == right);
    assign aaah = (state == left_fall) | (state == right_fall);
    assign digging = (state == left_dig) | (state == right_dig);
endmodule