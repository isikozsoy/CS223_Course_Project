`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2019 01:07:51 AM
// Design Name: 
// Module Name: sevSegReg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sevSegReg(input logic clk, clr, load,
                 input logic [3:0] i3,
                 input logic [3:0] i2,
                 input logic [3:0] i1,
                 input logic [3:0] i0,
                 output logic [63:0] Q
    );
    logic isLoaded = 0;
    logic [15:0] i;
    always_ff @ (posedge clk)
    begin
    if(clr)
      begin
      Q <= 0;
      end
    else
    begin
    i[15:12] <= i3;
    i[11:8] <= i2;
    i[7:4] <= i1;
    i[3:0] <= i0;
    end
    
       if(load == 1 && isLoaded == 0)
       begin
       Q[63:16] <= Q[47:0];
       Q[15:0] <= i;
       isLoaded <= 1;
       end
    
       if(load == 0)
       begin
       isLoaded <= 0;
       end
       
    end
endmodule
