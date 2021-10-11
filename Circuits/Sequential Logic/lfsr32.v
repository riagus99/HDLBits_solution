module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output reg [31:0] q
); 
    //taps at bit positions 32, 22, 2, and 1.
    reg [31:0] q_next;
    always @(*) begin
        q_next = q[31:1];
        q_next[31] = q[0];
        q_next[21] = q[0]^q[22];
        q_next[1] = q[0]^q[2];
        q_next[0] = q[0]^q[1];
    end

    always @(posedge clk) begin
        if(reset) q <= 32'h1;
        else q<=q_next;
    end
endmodule