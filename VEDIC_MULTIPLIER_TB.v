`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NATIONAL INSTITUTE OF TECHNOLOGY WARANGAL
// Engineer: NARENDRA KUMAR NEHRA 
//
// Create Date: 12.04.2023 12:13:39
// Design Name: 
// Module Name: 8_BIT_VEDIC_MULTIPLIER
//////////////////////////////////////////////////////////////////////////////////

module VEDIC_MULTIPLIER_TB();

wire [0:15]out;
reg [0:7]in1,in2;
VEDIC_MULTIPLIER_8_BIT  VM (out,in1,in2);
initial
begin
in1=8'b0001110; in2=8'b00001110;
#5 in1=8'b10001000; in2=8'b11000000;
#5 in1=8'b10001110; in2=8'b11000011;
end
initial $monitor($time,"in1= %d,in2= %d,out= %d", in1, in2, out);
initial #100 $stop;
endmodule
