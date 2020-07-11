`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    09:27:48 05/18/2016
// Design Name:
// Module Name:    win3by3_gen
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
module win3by3_gen(
  CLK,
  RSTn,
  center_pix_sig,
  cols,   // the column numbers of the input image
  rows,
  rom_data_win,   //input-from U1;
  column_addr_sig,    //input-from U3; //output [9 : 0] addra;
  row_addr_sig,         //input-from U3; //output [9 : 0] addra;
  rom_addr_sig,            //output-to U1;
  data_out0,           //output-to U4;
  data_out1,
  data_out2,
  data_out3,
  data_out4,
  data_out5,
  data_out6,
  data_out7,
  data_out8,
  win_data_done_sig            //output-to U4/U3;complete the win data;
    );

  input CLK;
  input RSTn;
  input [7:0] rom_data_win;
  input [9:0] cols;
  input [9:0] rows;
  input center_pix_sig;  //
  input [9:0] column_addr_sig;
  input [9:0] row_addr_sig;

  output [7:0] data_out0;           //output-to U4;
  output [7:0] data_out1;
  output [7:0] data_out2;
  output [7:0] data_out3;
  output [7:0] data_out4;
  output [7:0] data_out5;
  output [7:0] data_out6;
  output [7:0] data_out7;
  output [7:0] data_out8;
  output [17:0] rom_addr_sig;
  output win_data_done_sig;

/******************************************************************************************************************************/

  reg [9:0] m;

  always @ ( posedge CLK or negedge RSTn )
    if ( !RSTn )
       m <= 10'd1;
     else if (  center_pix_sig )
       m <= row_addr_sig[9:0];

  /******************************************************************************************************************************/

  reg [9:0] n;

  always @ ( posedge CLK or negedge RSTn )
    if ( !RSTn )
       n <= 10'd1;
     else if (  center_pix_sig )
       n <= column_addr_sig[9:0];

  /*****************************************************************************************************************************/

  reg [3:0] i;
  reg isWinDone;
  reg [17:0] rom_addr;
  reg [7:0] a11;
  reg [7:0] a12;
  reg [7:0] a13;
  reg [7:0] a21;
  reg [7:0] a22;
  reg [7:0] a23;
  reg [7:0] a31;
  reg [7:0] a32;
  reg [7:0] a33;

/*****************************************************************************************************************************/

reg get_9point_vld;

always @ ( posedge CLK or negedge RSTn )
    if (!RSTn)
           get_9point_vld <= 1'b0;
     else if ( center_pix_sig )
            get_9point_vld <= 1'b1;
     else if ( i==4'd10 )
            get_9point_vld <= 1'b0;


always @ ( posedge CLK or negedge RSTn )
    if ( !RSTn )
           isWinDone <= 1'b0;
     else if ( i==4'd10 )
            isWinDone <= 1'b1;
     else
            isWinDone <= 1'b0;



always @ ( posedge CLK or negedge RSTn )
    if ( !RSTn )
           i <= 4'd0;
     else if (i == 4'd10)
            i <= 4'd0;
     else if ( get_9point_vld )
            i <= i + 1'b1;




always @ ( posedge CLK or negedge RSTn )
    if (!RSTn)
            rom_addr <= 0;
     else if ( get_9point_vld)
       case (i)
          4'd0:
            if(!(m==1 || n==1)) rom_addr <= (m-2)*cols + (n-1) -1;

          4'd1:
          if(!(m==1 )) rom_addr <= (m-2)*cols + n -1;

          4'd2:
            if(!(m==1 || n==cols)) rom_addr <= (m-2)*cols + (n+1) -1;

          4'd3:
            if(!(n==1)) rom_addr <= (m-1)*cols + (n-1) -1;

          4'd4:
            rom_addr <= (m-1)*cols + n -1;

          4'd5:
            if(!(n==cols)) rom_addr <= (m-1)*cols + (n+1) -1;

          4'd6:
            if(!(m==cols || n==1)) rom_addr <= m*cols + (n-1) -1;

          4'd7:
            if(!(m==cols)) rom_addr <= m*cols + n -1;

          4'd8:
            if(!(m==cols || n==cols)) rom_addr <= m*cols + (n+1) -1;

          default:;

        endcase

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
     else if ( get_9point_vld )

       case (i)

          4'd2:
          if ( m==1 || n==1 )
                a11 <= 0;
          else
                a11 <= rom_data_win;

          4'd3:
          if ( m==1 )  a12 <= 0;
          else a12 <= rom_data_win;

          4'd4:
          if ( m==1 || n==cols ) a13 <= 0;
          else a13 <= rom_data_win;

          4'd5:
          if ( n==1 ) a21 <= 0;
          else  a21 <= rom_data_win;

          4'd6:
          a22 <= rom_data_win;

          4'd7:
          if ( n==cols ) a23 <= 0;
          else a23 <= rom_data_win;

          4'd8:
          if ( m==cols || n==1 ) a31 <= 0;
          else a31 <= rom_data_win;

          4'd9:
          if ( m==cols ) a32 <= 0;
          else a32 <= rom_data_win;

          4'd10:
          if ( m==cols || n==cols ) a33 <= 0;
          else a33 <= rom_data_win;

          default:;

      endcase

/**********************************************************************************************/

  assign win_data_done_sig = isWinDone;
  assign rom_addr_sig = rom_addr;

  assign data_out0 = a11;
  assign data_out1 = a12;
  assign data_out2 = a13;
  assign data_out3 = a21;
  assign data_out4 = a22;
  assign data_out5 = a23;
  assign data_out6 = a31;
  assign data_out7 = a32;
  assign data_out8 = a33;

/**********************************************************************************************/

endmodule