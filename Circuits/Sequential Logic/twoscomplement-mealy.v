module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    reg [1:0] state, next;
    always @(posedge clk, posedge areset) begin
        if(areset) state <= 2'b01;
        else state <= next;
    end
    always @(*) begin
        next = {state[1]|state[0]&x, state[0]&(~x)};
    end
    assign z = state[0]&x | state[1]&(~x);
endmodule
