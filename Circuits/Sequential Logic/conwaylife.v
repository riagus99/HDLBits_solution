module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q ); 

    wire [255:0] qnext;

    reg [3:0] i,j,imodn,jmodn,imodp,jmodp;
    reg [7:0] neighbors [7:0];

    function automatic cell_next_state(input integer coord);
        integer sum, i;
        begin
            sum = 0;
            i = coord / 16;
            j = coord % 16;
            imodn = i - 1;
            jmodn = j - 1;
            imodp = i + 1;
            jmodp = j + 1;
            neighbors[0] = imodn * 16 + jmodn;
            neighbors[1] = imodn * 16 + j;
            neighbors[2] = imodn * 16 + jmodp;
            neighbors[3] = i * 16 + jmodn;
            neighbors[4] = i * 16 + jmodp;
            neighbors[5] = imodp * 16 + jmodn;
            neighbors[6] = imodp * 16 + j;
            neighbors[7] = imodp * 16 + jmodp;
            for (i = 0; i < 8; i = i + 1) begin
                sum = sum + q[neighbors[i]];
            end
            case(sum)
                3'h2 : cell_next_state = q[coord];
                3'h3 : cell_next_state = 1;
                default : cell_next_state = 0;
            endcase
        end
    endfunction

    genvar x;
    generate
        for (x = 0; x < 256; x = x+1) begin : gen_inst
            assign qnext[x] = cell_next_state(x);
        end
    endgenerate
    
    always @(posedge clk) begin
        if (load) q <= data;
        else q <= qnext;
    end
endmodule