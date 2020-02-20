`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2019 02:19:10 AM
// Design Name: 
// Module Name: game
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


module game(input logic clk, input logic [7:0][7:0] data_in,
            input logic b1, b2, b3, b4,
            output logic [7:0][7:0] data_out,
            output logic gameOver
            );

   int inN = 0;
   int inE = 0;
   int inS = 0;
   int inW = 0;
   int labelV = 0;

   int label[64] = {1, 4, 1, 4, 1, 2, 1, 2, 2, 3, 2, 3, 4, 3, 4, 3, 1, 4, 1, 4, 1, 2, 1, 2, 2, 3, 2, 3, 4, 3, 4, 3, 2, 3, 2, 3, 3, 4, 3, 4, 3, 4, 3, 4, 1, 2, 1, 2, 2, 1, 2, 1, 3, 4, 3, 4, 3, 4, 3, 4, 1, 2, 1, 2};
   logic [7:0][7:0] after;
   logic isPushed;
   logic notGameOver = 0;
   
   always @ (posedge clk)
     begin
     notGameOver = 0;
     after = data_in;
     if(b1 | b2 | b3 | b4)
         begin
         isPushed  = 1;
         
         if(b1)
            labelV = 1;
         if(b2)
            labelV = 2;
         if(b3)
            labelV = 3;
         if(b4)
            labelV = 4;
         end
        
     if(isPushed & (~b1 & ~b2 & ~b3 & ~b4))
         begin
         for(int i = 0; i < 8; i++)
         begin
         for(int k = 0; k < 8; k++)
             begin
             if(label[8 * i + k] == labelV)
                 begin
                 if(8 * i + k + 8 > 63)
                    inN = (8 * i + k + 8) % 8;
                 else
                    inN = 8 * i + k + 8;
                    
                 if(8 * i + k - 8 < 0)
                    inS = 64 + 8 * i + k - 8;
                 else
                    inS = 8 * i + k - 8;
                 
                 if((8 * i + k + 1) % 8 == 0)
                    inE = 8 * i + k - 7;
                 else
                    inE = 8 * i + k + 1;
                    
                 if((8 * i + k - 1) % 8 == 7 | (8 * i + k - 1) % 8 == -1)
                    inW = 8 * i + k + 7;
                 else
                    inW = 8 * i + k - 1;
                  
                 if(data_in[inW / 8][inW % 8] == 1 & data_in[inE / 8][inE % 8] == 1 & data_in[inN / 8][inN % 8] == 1 & data_in[inS / 8][inS % 8] == 0)
                    after[i][k] = 1;
                 else if(data_in[inW / 8][inW % 8] == 1 & data_in[inE / 8][inE % 8] == 0 & data_in[inN / 8][inN % 8] == 1 & data_in[inS / 8][inS % 8] == 0)
                    after[i][k] = 1;
                 else if(data_in[inW / 8][inW % 8] == 0 & data_in[inE / 8][inE % 8] == 0 & data_in[inN / 8][inN % 8] == 1 & data_in[inS / 8][inS % 8] == 1)
                    after[i][k] = 1;
                 else if(data_in[inW / 8][inW % 8] == 0 & data_in[inE / 8][inE % 8] == 0 & data_in[inN / 8][inN % 8] == 1 & data_in[inS / 8][inS % 8] == 0)
                    after[i][k] = 1;
                 else if(data_in[inW / 8][inW % 8] == 1 & data_in[inE / 8][inE % 8] == 1 & data_in[inN / 8][inN % 8] == 0 & data_in[inS / 8][inS % 8] == 1)
                    after[i][k] = 1;
                 else if(data_in[inW / 8][inW % 8] == 1 & data_in[inE / 8][inE % 8] == 1 & data_in[inN / 8][inN % 8] == 0 & data_in[inS / 8][inS % 8] == 0)
                    after[i][k] = 1;
                 else if(data_in[inW / 8][inW % 8] == 1 & data_in[inE / 8][inE % 8] == 0 & data_in[inN / 8][inN % 8] == 0 & data_in[inS / 8][inS % 8] == 1)
                    after[i][k] = 1;
                 else if(data_in[inW / 8][inW % 8] == 1 & data_in[inE / 8][inE % 8] == 0 & data_in[inN / 8][inN % 8] == 0 & data_in[inS / 8][inS % 8] == 0)
                     after[i][k] = 1;
                 else
                    after[i][k] = 0;
                 end
             end
             end
         isPushed = 0;
         end
     data_out = after;
     for(int j = 0; j < 8; j++)
       begin
       for(int d = 0; d < 8; d++)
       begin
        if(after[j][d] == 1)
            notGameOver = 1;
       end
       end
       
       if(notGameOver == 1)
         gameOver = 0;
       else
         gameOver = 1;
   end
endmodule
