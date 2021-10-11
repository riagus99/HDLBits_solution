module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q ); 

    reg [511:0] q_next;
    
    always @(*) begin
        q_next = q[511:1]&(q^{q[510:0], 1'b0})|~q[511:1]&(q|{q[510:0], 1'b0});
    end
    
    always @(posedge clk) begin
        if (load) q <= data;
        else q <= q_next;
    end
endmodule