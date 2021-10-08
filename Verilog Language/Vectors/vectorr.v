module top_module( 
    input [7:0] in,
    output [7:0] out
);
    assign out = {in[0],in[1],in[2],in[3],in[4],in[5],in[6],in[7]};
/*
// procedural for loop
// LHS should be variable
integer i;
always @* begin
    for (i=0; i<8; i=i+1) out[i] = in[7-i];
end

// generate for loop : replicate the code block
// use genvar to tell that this variable is to be specifically used in generating in elaboration time
// genvar is discarded after elaboration time

genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin : my_block_name
        assign out[i] = in[7-i];
    end
endgenerate
*/

endmodule