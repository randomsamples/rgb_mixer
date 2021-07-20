/*
Q: At a clock frequency of 10MHz how many stages in the shift register do we need to deal with 1ms of bounce? At 50kHz?
A: 10000 and 50
*/

`default_nettype none
`timescale 1ns/1ns
module debounce #(parameter DEBOUNCE_CYCLES = 8) (
    input wire clk,
    input wire reset,
    input wire button,
    output reg debounced
);

    reg [DEBOUNCE_CYCLES - 1:0] shift_reg;

    always @(posedge clk) begin
         if (reset) begin
             shift_reg <= 0;
             debounced <= 0;
         end else begin
             shift_reg <= shift_reg << 1;
             shift_reg[0] <= button;

             if (shift_reg == (2 ** DEBOUNCE_CYCLES) - 1)
                 debounced <= 1;
             else if (shift_reg == 0)
                 debounced <= 0;
         end
    end
endmodule
