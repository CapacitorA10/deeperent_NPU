module ACTI(
    input wire signed  [31:0] x, // 글 읽는 방향으로 p0 to p8, and p4 is not needed
    output wire signed [31:0] out                            //out=p4가 될 것
    );

    assign out = x[31]? 0:x;

endmodule