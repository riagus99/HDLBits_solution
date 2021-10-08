module top_module( 
    input [254:0] in,
    output [7:0] out );
integer i, sum;
    always @* begin
        sum = 0;
        for (i = 0; i < 255; i = i + 1) begin
            if (in[i] == 1'b1) sum = sum + 1;
        end
    end
    assign out = sum;
endmodule