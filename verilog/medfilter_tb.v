`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:57:14 05/24/2016
// Design Name:   medfilter2
// Module Name:   E:/stereo_match_pro/stereo_match_FPGA0518/medfilter_tb.v
// Project Name:  stereo_match_FPGA0518
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: medfilter2
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module medfilter_tb;

    // Inputs
    reg CLK;
    reg RSTn;
    reg Start_sig;
    reg [18:0] pix_cnt;   //512*512=262144=100,0000,0000,0000,0000
    

    // Outputs
    wire Done_sig;
    wire [7:0] Data_out;
    integer fouti;
        

    // Instantiate the Unit Under Test (UUT)
    medfilter2 uut (
        .CLK(CLK), 
        .RSTn(RSTn), 
        .Start_sig(Start_sig), 
        .Done_sig(Done_sig), 
        .Data_out(Data_out)
    );
    
    //assign Data_out = 0;
   //assign Done_sig = 0;

    initial begin
        // Initialize Inputs
        CLK = 0;
        RSTn = 1;
        Start_sig = 0;
        
        fouti = $fopen("imgdata.txt");

        // Wait 100 ns for global reset to finish
        #100;   // To reset the system
        // Add stimulus here
        RSTn = 0;
        Start_sig = 1;
        pix_cnt = 0;
        
        #100;   // To start the system
        // Add stimulus here
        RSTn = 1;
        pix_cnt = 1;
    
    end
    
    always #10 CLK = ~CLK;
    
    always@(posedge CLK)
    begin
        if(Done_sig)
           pix_cnt <= pix_cnt + 1;
    end
    
    always@(posedge CLK)
    begin
        if(pix_cnt == 19'd262145)
           begin 
              Start_sig <= 0; 
              $display("Image Medfilter Completed!\n");
              $display("The all time is %d \n",$time);
              $stop;
            end
    end

    

    always@(posedge CLK)
    begin
        if(Done_sig)
            begin
              $fwrite(fouti, "%d", Data_out, "\n");
              $display("%d",pix_cnt);
            end
    end
     
endmodule