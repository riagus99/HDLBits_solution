module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    localparam idle = 0, s1 = 1, s2 = 2, s3 = 3;
    reg [1:0] state, next;
    always @(posedge clk, posedge areset) begin
        if (areset) state <= idle;
        else state <= next;
    end
    always @(*) begin
        case(state)
            idle : next = x ? s2 : s1;
            s1 : next = x ? s2 : s1;
            s2 : next = x ? s3 : s2;
            s3 : next = x ? s3 : s2;
        endcase
    end
    assign z = (state==s2);
endmodule
