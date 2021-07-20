`default_nettype none
`timescale 1ns/1ns
module encoder #(parameter WIDTH = 8,
                 parameter INC_VALUE = 1) (
    input clk,
    input reset,
    input a,
    input b,
    output reg [WIDTH - 1:0] value
);

reg old_a;
reg old_b;

always @(posedge clk) begin
    if (reset) begin
        old_a <= 0;
        old_b <= 0;
        value <= 0;
    end else begin
        case ({a, old_a, b, old_b})
            4'b1000: value <= value + INC_VALUE;
            4'b0111: value <= value + INC_VALUE;
            4'b0010: value <= value - INC_VALUE;
            4'b1101: value <= value - INC_VALUE;
            default:
                value <= value;
        endcase

        old_a <= a;
        old_b <= b;
    end
end

endmodule
