`default_nettype none
`timescale 1ns/1ns
module channel #(parameter WIDTH=8) (
        // Common params
        input clk,
        input reset,
        // Params from debouncers
        input button1,
        input button2,
        // Output from pwm
        output wire pwm_out,
        // Used by tests
        output reg [WIDTH -1:0] enc_out
    );

    reg [WIDTH - 1:0] debounced1;
    reg [WIDTH - 1:0] debounced2;
    //reg [WIDTH - 1:0] enc_out;

    debounce db1(clk, reset, button1, debounced1);
    debounce db2(clk, reset, button2, debounced2);
    encoder enc0(clk, reset, debounced1, debounced2, enc_out);
    pwm pwm1(clk, reset, pwm_out, enc_out);
endmodule

module rgb_mixer (
    input clk,
    input reset,
    input enc0_a,
    input enc0_b,
    input enc1_a,
    input enc1_b,
    input enc2_a,
    input enc2_b,
    output pwm0_out,
    output pwm1_out,
    output pwm2_out
);

// Instantiate 2 debouncers, an encoder and a pwm module for each of the 3 channels.
// Name the 8 bit bus wires that connect the encoder to the pwm modules enc0, enc1
// and enc2 to make sure the test can pass.
reg [7:0] enc0;
reg [7:0] enc1;
reg [7:0] enc2;

channel c0(clk, reset, enc0_a, enc0_b, pwm0_out, enc0);
channel c1(clk, reset, enc1_a, enc1_b, pwm1_out, enc1);
channel c2(clk, reset, enc2_a, enc2_b, pwm2_out, enc2);

endmodule
