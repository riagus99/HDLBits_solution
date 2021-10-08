module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
    
    wire inter [0:1];
    
    assign inter[0] = a & b;
    assign inter[1] = c & d;
    assign out = inter[0] | inter[1];
    assign out_n = ~out;
    

endmodule