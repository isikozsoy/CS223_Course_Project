`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2019 12:08:49 AM
// Design Name: 
// Module Name: bPushedCounter
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


module bPushedCounter(input logic clk, clr, gameOver, bn, be, bs, bw,
                      output logic[3:0] o3, 
                      output logic[3:0] o2,
                      output logic[3:0] o1,
                      output logic[3:0] o0);
    int count = 0;
    logic isPushed;
    always_ff @ (posedge clk)
    begin
    if(gameOver)
      count <= count;
    if(clr)
      begin
      count <= 0;
      end
    if(bn | be | bs | bw && isPushed == 0 & ~gameOver)
        begin
        count <= count + 1;
        isPushed <= 1;
        end
    o3 <= count / 1000;
    o2 <= (count / 100) % 10;
    o1 <= (count / 10) % 10;
    o0 <= count % 10;
    if(~bn & ~be & ~bs & ~bw & isPushed)
        begin
        isPushed <= 0;
        end
    end
endmodule
