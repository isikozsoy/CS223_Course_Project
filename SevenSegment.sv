`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2019 09:09:01 PM
// Design Name: 
// Module Name: SevenSegment
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


module SevenSegment( input clk, gameOver, isStarted,
                      input [3:0] in0, in1, in2, in3, 
                      output a, b, c, d, e, f, g, dp, 
                      output [3:0] an);
    localparam N = 18;
    logic [N-1:0] count = {N{1'b0}};
    
    int timeCounter = 0;
    logic isOn;
    
    always_ff@( posedge clk)
        count <= count + 1;
    logic [3:0]digit_val;
    logic [3:0]digit_en;
    always_comb
    begin
        digit_en = 4'b1111;
        digit_val = in0;
        
        case(count[N-1:N-2]) 
        2'b00 :
        begin
            digit_val = in0;
            digit_en = 4'b1110;
        end
        2'b01:
        begin
            digit_val = in1;
            digit_en = 4'b1101;
        end
        2'b10:
        begin
            digit_val = in2;
            digit_en = 4'b1011;
        end
        2'b11:
        begin
            digit_val = in3;
            digit_en = 4'b0111;
        end
        endcase
    end
   
    logic [6:0] sseg_LEDs;
    always_comb
    begin
        if(gameOver && isStarted && isOn)
           sseg_LEDs = 7'b1111111;
        else
        begin
            sseg_LEDs = 7'b1111111; 
            case(digit_val)
            'h0 : sseg_LEDs = 7'b1000000; 
            'h1 : sseg_LEDs = 7'b1111001; 
            'h2 : sseg_LEDs = 7'b0100100; 
            'h3 : sseg_LEDs = 7'b0110000;
            'h4 : sseg_LEDs = 7'b0011001; 
            'h5 : sseg_LEDs = 7'b0010010;
            'h6 : sseg_LEDs = 7'b0000010;
            'h7 : sseg_LEDs = 7'b1111000;
            'h8 : sseg_LEDs = 7'b0000000;
            'h9 : sseg_LEDs = 7'b0010000;
            'hA : sseg_LEDs = 7'b0001000;
            'hB : sseg_LEDs = 7'b0000011;
            'hC : sseg_LEDs = 7'b1000110;
            'hD : sseg_LEDs = 7'b0100001;
            'hE : sseg_LEDs = 7'b0000110;
            'hF : sseg_LEDs = 7'b0001110;
            
            
            default : sseg_LEDs = 7'b0111111;
            endcase
         end
    end
    
    always_ff @ (posedge clk)
    begin
    if(gameOver == 1 && isStarted == 1 && timeCounter < 25000000)
        begin
        timeCounter <= timeCounter + 1;
        isOn <= 1;
        end
    else
        begin
        if(timeCounter == 49999999)
            timeCounter <= 0;
        else
            begin
            timeCounter <= timeCounter + 1;
            isOn <= 0;
            end
        end
    end
    assign an = digit_en;
    assign {g, f, e, d, c, b, a} = sseg_LEDs;
    assign dp = 1'b1;
endmodule