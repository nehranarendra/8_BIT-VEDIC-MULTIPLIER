`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NATIONAL INSTITUTE OF TECHNOLOGY WARANGAL
// Engineer: NARENDRA KUMAR NEHRA 
//
// Create Date: 12.04.2023 12:13:39
// Design Name: 
// Module Name: 8_BIT_VEDIC_MULTIPLIER
//////////////////////////////////////////////////////////////////////////////////


module VEDIC_MULTIPLIER_8_BIT(output [15:0] out,input [7:0] in1,in2);
  wire[7:0] w1,w2,w3,w4,s1,s2;
  wire c1,c2,c3;
  wire [7:0] W1,W2;
   
 VM4bit VM4BIT_1(w1,in1[3:0],in2[3:0]);
 VM4bit VM4BIT_2(w2,in1[3:0],in2[7:4]);
 VM4bit VM4BIT_3(w3,in1[7:4],in2[3:0]);
 VM4bit VM4BIT_4(w4,in1[7:4],in2[7:4]);
 
  buf(s1[0],w1[4]);
  buf(s1[1],w1[5]);
  buf(s1[2],w1[6]);
  buf(s1[3],w1[7]);
  buf(s1[4],0);
  buf(s1[5],0);
  buf(s1[6],0);
  buf(s1[7],0);
 
 
   ADDER8bit A8_1( c1,W1, w2,w3);
   ADDER8bit A8_2( c2,W2,W1,s1);
   
   or o_1(c3,c1,c2);
   
  buf(s2[0],W2[4]);
  buf(s2[1],W2[5]);
  buf(s2[2],W2[6]);
  buf(s2[3],W2[7]);
  buf(s2[4],c3);
  buf(s2[5],0);
  buf(s2[6],0);
  buf(s2[7],0);
   
   
   
   
   assign out[0] = w1[0];
   assign out[1] = w1[1];
   assign out[2] = w1[2];
   assign out[3] = w1[3];
   assign out[4] = W2[0];
   assign out[5] = W2[1];
   assign out[6] = W2[2];
   assign out[7] = W2[3];
   
   
   ADDER8bit A8_3(extra,out [15:8], w4,s2);
   
 
 endmodule


module VM4bit(output [7:0] out,input [3:0] in1,in2);
  wire[3:0] w1,w2,w3,w4,s1,s2;
  wire c1,c2,c3;
  wire [3:0] W1,W2;
   
 VM2bit VM2BIT_1(w1,in1[1:0],in2[1:0]);
 VM2bit VM2BIT_2(w2,in1[1:0],in2[3:2]);
 VM2bit VM2BIT_3(w3,in1[3:2],in2[1:0]);
 VM2bit VM2BIT_4(w4,in1[3:2],in2[3:2]);
 
  buf(s1[0],w1[2]);
  buf(s1[1],w1[3]);
  buf(s1[2],0);
  buf(s1[3],0);
 
 
   ADDER4bit A4_1( c1,W1, w2,w3);
   ADDER4bit A4_2( c2,W2,W1,s1);
   
   or o_1(c3,c1,c2);
   
  buf(s2[0],W2[2]);
  buf(s2[1],W2[3]);
  buf(s2[2],c3);
  buf(s2[3],0);
   
   
   
   
   assign out[0] = w1[0];
   assign out[1] = w1[1];
   assign out[2] = W2[0];
   assign out[3] = W2[1];
   
   ADDER4bit A4_3(extra,out [7:4], w4,s2);
   
 
 endmodule

module VM2bit(output [3:0] out, input [1:0] A,B);

wire [3:0] s;

and a1(s[0],A[0],B[0]);
and a2(s[1],A[0],B[1]);
and a3(s[2],A[1],B[0]);
and a4(s[3],A[1],B[1]);

assign out[0] = s[0];
halfadder H_1(out[1],C,s[1],s[2]);
halfadder H_2(out[2],out[3],s[3],C);

endmodule

module ADDER8bit(C,out,A,B );
output [7:0] out;
output C;



input [7:0] A,B;
  halfadder H_1(out[0],c1,A[0],B[0]);
  fulladder F_1(out[1],c2,A[1],B[1],c1);
  fulladder F_2(out[2],c3,A[2],B[2],c2);
  fulladder F_3(out[3],c4,A[3],B[3],c3);
  fulladder F_4(out[4],c5,A[4],B[4],c4);
  fulladder F_5(out[5],c6,A[5],B[5],c5);
  fulladder F_6(out[6],c7,A[6],B[6],c6);
  fulladder F_7(out[7],C,A[7],B[7],c7);
  
endmodule


module ADDER4bit(C,out,A,B );
output [3:0] out;
output C;


input [3:0] A,B;
  halfadder H_1(out[0],c1,A[0],B[0]);
  fulladder F_1(out[1],c2,A[1],B[1],c1);
  fulladder F_2(out[2],c3,A[2],B[2],c2);
  fulladder F_3(out[3],C,A[3],B[3],c3);
endmodule


module halfadder(sum, carry ,A,B);
output  sum,carry;
input A,B;

 assign sum = A^B;
 assign carry = A&B;
endmodule

module fulladder(sum, carry ,A,B, cin );
output  sum,carry;
input A,B,cin;


  assign sum  = A^B^cin;
  assign carry = A&B|B&cin|A&cin;
  
endmodule