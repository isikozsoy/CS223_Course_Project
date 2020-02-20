`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2019 10:02:29 PM
// Design Name: 
// Module Name: fourBitReg
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


module fourBitReg( input logic clk, enable, load, clr,
                   input logic [3:0] loadVal,
                   output logic [3:0] Q
                   );
    always_ff @ (posedge clk)
    begin
        if(clr)
            Q <= 4'b0000;
        else if(load & enable)
            Q <= loadVal;
        else
            Q <= Q;
    end
endmodule
