module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);
    genvar i;
    reg [31:0] in_dly;
    always @(posedge clk) begin
    	in_dly <= in;
    end 
    generate
        for (i = 0; i < 32; i = i + 1) begin : latch_inst
            sr_latch latch(clk, in_dly[i] & ~in[i], reset, out[i]);
        end
    endgenerate
    
endmodule

module sr_latch (
    input clk,
    input in,
    input reset,
    output reg out
);
    always @(posedge clk) begin
        case ({in, reset})
        	2'b00 : out <= out;
            2'b01 : out <= 0;
            2'b10 : out <= 1;
            2'b11 : out <= 0;
        endcase
    end
endmodule