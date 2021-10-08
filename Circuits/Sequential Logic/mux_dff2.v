module top_module (
    input clk,
    input w, R, E, L,
    output reg Q
);
    always @(posedge clk) begin
        if (!L) begin
            if (E) Q <= w;
        end
        else Q <= R;
    end
endmodule