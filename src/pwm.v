`default_nettype none
`timescale 1ns/1ns
module pwm #(parameter WIDTH = 8,
             parameter INVERT = 0) (
    input wire clk,
    input wire reset,
    output wire out,
    input wire [WIDTH - 1:0] level
    );

reg [WIDTH - 1:0] counter;

always @(posedge clk)
    begin
        if (reset)
            counter <= 0;
        else
            counter <= counter + 1;
    end

assign out = (counter < level) ^ INVERT;

endmodule
