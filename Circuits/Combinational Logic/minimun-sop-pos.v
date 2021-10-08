module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
); 
	assign out_sop = c&d | c&~a&~b;
    assign out_pos = (d|~b)&(c|a)&(c|~d)&(d|~a);
endmodule