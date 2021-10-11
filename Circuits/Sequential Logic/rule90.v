module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q ); 
    reg [511:0] q_next;
    integer i;
    always @(*) begin
        for (i = 0; i<512; i = i+1)begin
            if (i==0) q_next[i] = q[i+1];
            else if (i==511) q_next[i] = q[i-1];
            else q_next[i] = q[i-1]^q[i+1];
        end
    end
    always @(posedge clk) begin
        if (load) q <= data;
        else q <= q_next;
    end
endmodule