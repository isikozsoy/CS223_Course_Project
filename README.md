# CS223_Course_Project
The aim of this project is to learn how to use the 7 segment module,    how to give input via switches on Basys 3 FPGA Board, how to use the buttons and design cellular automata for a 8x8 matrix on the BetiBoard by creating a game. There is more detailed explanation in the project report.

<h2>Datapath Design</h2>

<h3>fourBitRegisterModule</h3>

This module is for holding the user input for each digit of the seven segment. It takes clk, enable, load and 4 bit value which are
provided from user. Enable comes from the controller and it determines the digit of the seven segment display to change. According
to the load, the value is saved or not. 

<h3>SevenSegment Module</h3>
Seven segment module is provided by the teacher. In order to make it appropriate for our project some changes are made. One of them
is instead of decimal, it is programmed to be able to display digits in hexadecimal. 
            'hA : sseg_LEDs = 7'b0001000; 
            'hB : sseg_LEDs = 7'b0000011; 
            'hC : sseg_LEDs = 7'b1000110; 
            'hD : sseg_LEDs = 7'b0100001; 
            'hE : sseg_LEDs = 7'b0000110; 
            'hF : sseg_LEDs = 7'b0001110; 
It takes clk, four 4 bit value for each digit, isStarted signal to start showing score when the game starts. Furthermore, it takes
gameOver signal which shows whether the game is over or not. If the game is over, the seven segment display starts blinking (open
for 0.25 second and close for 0.25 second). 

<h3>sevSegReg Module</h3>
This module holds the last  4 values of the seven segment (16 * 4 = 64 bits). It takes clk, clr, load as inputs. In reset state,
the reset signal used as clr and 64 bit value is set to zero. Load signal is for adding the current value of the seven segment
display is assigned to last 16 bits of 64 bit register. 

<h3>game Module</h3>
The game module determines the 8 x 8 RGB LEDs’ outputs. In this module, the specified rule is applied to each cell of the
8 x 8 RGB LEDs. It takes clk, b1, b2, b3, b4 and [7:0][7:0] data_in as inputs. On each button push, the rule applied to input
data_in and some leds become on and some becomes off. After those changes the new logic is outputted as data_out which will be
shown in 8 x 8 LEDs. gameOver signal is for understanding whether the game is over or not. If all the leds are off, this
signal becomes 1 and game finished. 

<h3>bPushedCounter Module</h3>
This is a module for counting the button push. During the game its value is shown in the seven segment display. This module
takes clk, clrButton, gameOver, b1, b2, b3, b4 as inputs. gameOver signal can be considered as enable signal, when the game is
over this module no longer count. On the restart and reset state,  

<h3>converter Module</h3>
This module is to assign the data_in logic to 8 x 8 RGB LEDs. However, it displays each row in reversed order.
