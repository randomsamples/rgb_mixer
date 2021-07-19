`default_nettype none
`timescale 1ns/1ns
module pwm (
    input wire clk,
    input wire reset,
    output wire out,
    input wire [7:0] level
    );

reg [7:0] counter;

always @(posedge clk)
    begin
        if (reset)
            counter <= 0;
        else
            counter <= counter + 1;
    end

assign out = (counter < level);

endmodule
