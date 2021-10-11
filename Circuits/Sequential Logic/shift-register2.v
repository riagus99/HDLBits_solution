module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //
    localparam N = 4;

    wire clk,E,L,w;
    assign {w,L,E,clk} = KEY;
    genvar i;
    generate
        for (i =0; i < N; i = i + 1) begin : block_name
            if (i==N-1) MUXDFF mod(clk, w, SW[3], E, L, LEDR[3]);
            else MUXDFF mod(clk, LEDR[i+1], SW[i], E, L, LEDR[i]);
        end
    endgenerate
endmodule

module MUXDFF ( 
    input clk,
    input w, R, E, L,
    output reg Q
);
    always @(posedge clk) begin
        Q <= L ? R : (E ? w : Q);
    end
endmodule