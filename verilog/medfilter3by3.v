`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:28:20 05/18/2016 
// Design Name: 
// Module Name:    medfilter3by3 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module medfilter3by3(
  CLK,
  RSTn,
  win_data_sig,  //input-from module of win3by3_gen; 
  medfilt_done_sig,   //output-to top;
  data_in0,        //input-from module of win3by3_gen;
  data_in1,
  data_in2,
  data_in3,
  data_in4,
  data_in5,
  data_in6,
  data_in7,
  data_in8,
  medfilt_data_out    //output-to top; 
    );

  input CLK;
  input RSTn;
  input win_data_sig;
  input [7:0] data_in0;           //output-to ;
  input [7:0] data_in1;
  input [7:0] data_in2;
  input [7:0] data_in3;
  input [7:0] data_in4;
  input [7:0] data_in5;
  input [7:0] data_in6;
  input [7:0] data_in7;
  input [7:0] data_in8;

  output medfilt_done_sig;
  output [7:0] medfilt_data_out;

/******************************************************************************/ 
  reg [7:0] a11;
  reg [7:0] a12;
  reg [7:0] a13;
  reg [7:0] a21;
  reg [7:0] a22;
  reg [7:0] a23;
  reg [7:0] a31;
  reg [7:0] a32;
  reg [7:0] a33;
  
  reg [7:0] b11;
  reg [7:0] b12;
  reg [7:0] b13;
  reg [7:0] b21;
  reg [7:0] b22;
  reg [7:0] b23;
  reg [7:0] b31;
  reg [7:0] b32;
  reg [7:0] b33;
  
  reg [7:0] c11;
  reg [7:0] c12;
  reg [7:0] c13;
  reg [7:0] c21;
  reg [7:0] c22;
  reg [7:0] c23;
  reg [7:0] c31;
  reg [7:0] c32;
  reg [7:0] c33;
  
  reg [2:0] i;
  reg [7:0] medfilt_data;
  reg filt_done;
  
  reg cal_vld;

 
always @ ( posedge CLK or negedge RSTn )
    if (!RSTn)
      begin
            a11 <= 0;
            a12 <= 0;
            a13 <= 0;
            a21 <= 0;
            a22 <= 0;
            a23 <= 0;
            a31 <= 0;
            a32 <= 0;
            a33 <= 0;
        end
     else if (win_data_sig)
       begin
            a11 <= data_in0;
            a12 <= data_in1;
            a13 <= data_in2;
            a21 <= data_in3;
            a22 <= data_in4;
            a23 <= data_in5;
            a31 <= data_in6;
            a32 <= data_in7;
            a33 <= data_in8;
        end
  
  always @ ( posedge CLK or negedge RSTn )
    if (!RSTn)
            i <= 3'd0;
     else if( cal_vld & ( i!=3 ) )
            i <= i + 1;
     else 
            i <= 0;
            
  always @ ( posedge CLK or negedge RSTn )
    if (!RSTn)
            cal_vld <= 1'b0;
     else if( win_data_sig )
            cal_vld <= 1'b1;
     else if( i==3'd3 )
            cal_vld <= 0;            


  always @ ( posedge CLK or negedge RSTn )
    if (!RSTn)
       begin
        filt_done <= 1'b0;
        b11 <= 0;
        b12 <= 0;
        b13 <= 0;
        b21 <= 0;
        b22 <= 0;
        b23 <= 0;
        b31 <= 0;
        b32 <= 0;
        b33 <= 0;
        c11 <= 0;
        c12 <= 0;
        c13 <= 0;
        c21 <= 0;
        c22 <= 0;
        c23 <= 0;
        c31 <= 0;
        c32 <= 0;
        c33 <= 0;
        medfilt_data <= 0;
        end
     else if( cal_vld )
       case(i)
          3'd0:
            begin
             b11 <= max(a11, a21, a31); 
             b12 <= max(a12, a22, a32); 
             b13 <= max(a13, a23, a33);
             b21 <= med(a11, a21, a31); 
             b22 <= med(a12, a22, a32); 
             b23 <= med(a13, a23, a33);
             b31 <= min(a11, a21, a31); 
             b32 <= min(a12, a22, a32); 
             b33 <= min(a13, a23, a33);
            end
             
          3'd1:
            begin
             c31 <= max(b31, b32, b33);
             c22 <= med(b21, b22, b23);
             c13 <= min(b11, b12, b13); 
             end
          
          3'd2:
             begin
             medfilt_data <= med(c13, c22, c31);
             filt_done<=1'b1;
             end
 
          3'd3:
             filt_done <= 1'b0; 

            default:;

        endcase
        
/************************************************************************************/ 

function [7:0] max;//if the data is signed number, please add the char signed behind key function; 
  input [7:0] a, b, c;
  begin
    max = (((a >= b) ? a : b) >= c ) ?  ((a >= b) ? a : b) : c;
  end
endfunction

function [7:0] med;
  input [7:0] a, b, c;
  begin
     med = a < b ? (b < c ? b : a < c ? c : a) : (b > c ? b : a > c ? c : a);
  end
endfunction

function [7:0] min;
  input [7:0] a, b, c;
  begin
     min= (((a <= b) ? a : b) <= c ) ?  ((a <= b) ? a : b) : c;
  end
endfunction
          
/************************************************************************************/ 
 
  assign medfilt_data_out = medfilt_data;
  assign medfilt_done_sig = filt_done;

/**********************************************************************************/ 
 
endmodule