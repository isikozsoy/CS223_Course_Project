`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2019 09:42:42 PM
// Design Name: 
// Module Name: TopModule
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


module TopModule(input logic clk, loadDig, loadSS, start, restart, reset,
                 input logic [1:0] digit,
                 input logic [1:0] part,
                 input logic [3:0] value,
                 input logic b1, b2, b3, b4,
                 output logic a, b, c, d, e, f, g, dp,
                 output logic [3:0] an,
                 output logic [15:0] ssLED,
                 output logic shcp, stcp, mr, oe, ds,
                 output logic [7:0] rowsOut
    );
    logic [3:0] q0, q1, q2, q3;
    logic en0, en1, en2, en3;
    logic [63:0] Q;
    logic[3:0] i3;
    logic[3:0] i2;
    logic[3:0] i1;
    logic[3:0] i0;
    
    logic[3:0] o3;
    logic[3:0] o2;
    logic[3:0] o1;
    logic[3:0] o0;
    
    logic clrButton = 0;
    logic isStarted;
    logic [7:0][7:0] data_in;
    logic [7:0][7:0] data_inTemp;
    logic [7:0][7:0] data_out;
    logic gameOver;
    
    always_ff @ (posedge clk)
    case(digit)
    2'b00:
    begin
    en0 <= 1;
    en1 <= 0;
    en2 <= 0;
    en3 <= 0;
    end
    
    2'b01:
    begin
    en0 <= 0;
    en1 <= 1;
    en2 <= 0;
    en3 <= 0;
    end
    
    2'b10:
    begin
    en0 <= 0;
    en1 <= 0;
    en2 <= 1;
    en3 <= 0;
    end
    
    2'b11:
    begin
    en0 <= 0;
    en1 <= 0;
    en2 <= 0;
    en3 <= 1;
    end
    endcase
    
    always_ff @ (posedge clk)
    case(part)
    2'b00:
    begin
    ssLED <= Q[15:0];
    end
    
    2'b01:
    begin
    ssLED <= Q[31:16];
    end
    
    2'b10:
    begin
    ssLED <= Q[47:32];
    end
    
    2'b11:
    begin
    ssLED <= Q[63:48];
    end
    endcase
    
    always_ff @ (posedge clk)
        begin
        if(start)
           begin
           clrButton <= 0;
           isStarted = 1;
           data_inTemp[7] <= Q[63:56];
           data_inTemp[6] <= Q[55:48];
           data_inTemp[5] <= Q[47:40];
           data_inTemp[4] <= Q[39:32];
           data_inTemp[3] <= Q[31:24];
           data_inTemp[2] <= Q[23:16];
           data_inTemp[1] <= Q[15:8];
           data_inTemp[0] <= Q[7:0];
           end
            
          if(~start & isStarted)
            begin
            clrButton <= 0;
            i3 <= o3;
            i2 <= o2;
            i1 <= o1;
            i0 <= o0;
            
            data_inTemp <= data_out;
            end
          
          if(~start & ~isStarted)
            begin
            clrButton <= 0;
            i3 <= q3;
            i2 <= q2;
            i1 <= q1;
            i0 <= q0;
            end
            
            if(reset)
              begin
              clrButton <= 1;
              i3 <= q3;
              i2 <= q2;
              i1 <= q1;
              i0 <= q0;
              data_inTemp[7] <= 8'b00000000;
              data_inTemp[6] <= 8'b00000000;
              data_inTemp[5] <= 8'b00000000;
              data_inTemp[4] <= 8'b00000000;
              data_inTemp[3] <= 8'b00000000;
              data_inTemp[2] <= 8'b00000000;
              data_inTemp[1] <= 8'b00000000;
              data_inTemp[0] <= 8'b00000000;
              isStarted = 0;
              end
              
            if(restart)
              begin
              clrButton <= 1;
              data_inTemp[7] <= Q[63:56];
              data_inTemp[6] <= Q[55:48];
              data_inTemp[5] <= Q[47:40];
              data_inTemp[4] <= Q[39:32];
              data_inTemp[3] <= Q[31:24];
              data_inTemp[2] <= Q[23:16];
              data_inTemp[1] <= Q[15:8];
              data_inTemp[0] <= Q[7:0];
              isStarted = 1;
              end
        end
        
        assign data_in[7] = data_inTemp[7];
        assign data_in[6] = data_inTemp[6];
        assign data_in[5] = data_inTemp[5];
        assign data_in[4] = data_inTemp[4];
        assign data_in[3] = data_inTemp[3];
        assign data_in[2] = data_inTemp[2];
        assign data_in[1] = data_inTemp[1];
        assign data_in[0] = data_inTemp[0];
                
    bPushedCounter bCounter(clk, clrButton, gameOver, b1, b2, b3, b4, o3, o2, o1, o0);
    sevSegReg ssReg(clk, reset, loadSS, q3, q2, q1, q0, Q);
    SevenSegment ss(clk, gameOver, isStarted, i0, i1, i2, i3, a, b, c, d, e, f, g, dp, an);
    fourBitReg reg0(clk, en0, loadDig, reset, value, q0);
    fourBitReg reg1(clk, en1, loadDig, reset, value, q1);
    fourBitReg reg2(clk, en2, loadDig, reset, value, q2);
    fourBitReg reg3(clk, en3, loadDig, reset, value, q3);
    converter cnv(clk, data_in, rowsOut, shcp, stcp, mr, oe, ds);
    game myGame(clk, data_in, b1, b2, b3, b4, data_out, gameOver);
endmodule