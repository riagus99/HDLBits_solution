module top_module (
    input [7:0] in,
    output parity); 
	assign parity = ^in; // very useful when dealing with vectors!
endmodule