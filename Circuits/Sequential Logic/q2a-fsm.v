module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output reg [3:1] g   // grant
); 
    localparam A = 0,B=1,C=2,D=3;
    reg [1:0] state, next;

    always @(*) begin
        case(state)
            A : begin
                casez(r)
                    3'bzz1 : next = B;
                    3'bz10 : next = C;
                    3'b100 : next = D;
                    default : next = A;
                endcase
            end
            B : next = r[1] ? B : A;
            C : next = r[2] ? C : A;
            D : next = r[3] ? D : A;
        endcase
    end
    always @(posedge clk) begin
        if(!resetn)state<=A;
        else state<=next;
    end
    always @(*) begin
        case(state)
            A : g = 3'b000;
            B : g = 3'b001;
            C : g = 3'b010;
            D : g = 3'b100;
        endcase
    end
endmodule