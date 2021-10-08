module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); //
    wire cout;
    assign {cout, s} = a + b;
    assign overflow = cout^a[7]^b[7]^s[7];  // a[7]^b[7]^s[7] = cout[7]
    // cout[8] ^ cout[7] : adding two positive numbers produces a negative result, or adding two negative numbers produces a positive result.
    // 위는 같은 의미 즉, ~s[7]&a[7]&b[7]|s[7]&~a[7]&~b[7]와 같은식
    // why? 1+1 should be 1, 0+0 should be 0!
endmodule