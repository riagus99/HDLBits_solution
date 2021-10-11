module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
); 
// seems like i have 1 more state than the solution provided from the website, 
// but this is due to my misunderstanding of the intention of the problem
// i think some other people would have experienced fail even though they were confident of their code
    parameter s0 = 0, s1 = 1,s2=2,s3=3,s4=4,s5=5,s6=6;
    reg [2:0] state, next;

    always @(*) begin
        case(state)
            s0 : next = s[1] ? s1 : s0;
            s1 : next = s[2] ? s2 : (s[1] ? s1 : s6);
            s2 : next = s[3] ? s3 : (s[2] ? s2 : s5);
            s3 : next = s[3] ? s3 : s4;
            s4 : next = s[3] ? s3 : (s[2] ? s4 : s5);
            s5 : next = s[2] ? s2 : (s[1] ? s5 : s6);
            default : next = s[1] ? s1 : s6;
        endcase
    end
    always @(posedge clk) begin
        if (reset) state <= s6;
        else state <= next;
    end
    always @(*) begin
        case(state)
            s0 : {fr3, fr2, fr1, dfr} = 4'b1110;
            s1 : {fr3, fr2, fr1, dfr} = 4'b0110;
            s2 : {fr3, fr2, fr1, dfr} = 4'b0010;
            s3 : {fr3, fr2, fr1, dfr} = 4'b0000;
            s4 : {fr3, fr2, fr1, dfr} = 4'b0011;
            s5 : {fr3, fr2, fr1, dfr} = 4'b0111;
            default : {fr3, fr2, fr1, dfr} = 4'b1111;
        endcase
    end
endmodule