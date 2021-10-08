module fulladd(
    input a, b, cin,
    output cout, sum
);
    assign cout = a&b|b&cin|a&cin;
    assign sum = a^b^cin;
endmodule

module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
	genvar i;
    fulladd fadd1(a[0], b[0], cin, cout[0], sum[0]);
    generate 
        for (i = 1; i < 100; i = i + 1) begin : fdd
            fulladd fadd(
                .a(a[i]),
                .b(b[i]),
                .cin(cout[i-1]),
                .cout(cout[i]),
                .sum(sum[i])
            );
        end
    endgenerate
endmodule
/*
// you can also use array of instances which might be synthesis tool dependant
module top_module(
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    fulladd fadd[99:0](a, b, {cout[98:0],cin}, cout, sum);
endmodule
*/