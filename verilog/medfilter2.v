`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:29:33 05/18/2016 
// Design Name: 
// Module Name:    medfilter2 
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

module medfilter2  
(
  CLK, 
  RSTn,
  Start_sig,
  Done_sig,
  Data_out
);
     
  input CLK;
  input RSTn;
  input Start_sig;
  output Done_sig;
  output [7:0] Data_out;
  
  /********************************************************************/
  
  wire [17:0] rom_addr; //
  wire [7:0] rom_data;  // 


  /******************************************************************************/
  
  //wire [7:0] win_data[8:0];
  wire [7:0] data_out0;           //output-to ;
  wire [7:0] data_out1;
  wire [7:0] data_out2;
  wire [7:0] data_out3;
  wire [7:0] data_out4;
  wire [7:0] data_out5;
  wire [7:0] data_out6;
  wire [7:0] data_out7;
  wire [7:0] data_out8;
  wire win_done_sig;
  
 wire [9:0] column_addr_sig;
 wire [9:0] row_addr_sig;
 
  win3by3_gen win3by3_gen_inst (
  .CLK(CLK), 
  .RSTn(RSTn),
  .center_pix_sig(win_start_sig), //input-from ; 
  .cols(10'd512),   // the column numbers of the input image
  .rows(10'd512),   // the row numbers of the input image
  .rom_data_win(rom_data),    //input-from ; 
  .column_addr_sig(column_addr_sig),    //input-from ; //output [9 : 0] addra; 
  .row_addr_sig(row_addr_sig),         //input-from ; //output [9 : 0] addra;
  .rom_addr_sig(rom_addr),   //output-to ; 
  .data_out0(data_out0),           //output-to ;
  .data_out1(data_out1),
  .data_out2(data_out2),
  .data_out3(data_out3),
  .data_out4(data_out4),
  .data_out5(data_out5),
  .data_out6(data_out6),
  .data_out7(data_out7),
  .data_out8(data_out8),
  .win_data_done_sig(win_done_sig)  //output-to U4/U3; 
    );
  
  /******************************************************************************/ 
   
  counter_ctrl counter_ctrl_inst(
  .CLK(CLK),
  .RSTn(RSTn),
  .start_sig(Start_sig),  //input-from top 
  .nxt_pix_sig(win_done_sig),  //input-from 
  .cols(10'd512), 
  .column_addr_sig(column_addr_sig),  //output-to 
  .row_addr_sig(row_addr_sig),     //output-to 
  .pix_done_sig(win_start_sig)   //output-to    
  );
  
/*****************************************************************************/
 
 wire medfilt_done_sig;
 wire [7:0] medfilt_data_wire;
 
 medfilter3by3 medfilter3by3_inst
(
  .CLK(CLK),
  .RSTn(RSTn), 
  .win_data_sig(win_done_sig),  //input-from; 
  .medfilt_done_sig(medfilt_done_sig), //output-to;
  .data_in0(data_out0),        //input-from ;
  .data_in1(data_out1),
  .data_in2(data_out2),
  .data_in3(data_out3),
  .data_in4(data_out4),
  .data_in5(data_out5),
  .data_in6(data_out6),
  .data_in7(data_out7),
  .data_in8(data_out8),
  .medfilt_data_out(medfilt_data_wire)     //output-to top; 
); 

/*********************************************************************/
 wire Done_sig;
 wire [7:0] Data_out;
 assign Done_sig = medfilt_done_sig;
 assign Data_out = medfilt_data_wire;
 
/**********************************************************************/
endmodule