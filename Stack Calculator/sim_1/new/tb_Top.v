`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 10/18/2022 04:57:24 PM
// Module Name: tb_Top
//////////////////////////////////////////////////////////////////////////////////


module tb_Top();

reg CLK = 0;
reg ButtonUp_unfiltered = 0;
reg ButtonDown_unfiltered = 0;
reg ButtonLeft_unfiltered = 0;
reg ButtonRight_unfiltered = 0; 
reg [7:0] SWITCH = 0;

wire [7:0] LED;
wire mainAnode0;
wire mainAnode1;
wire mainAnode2;
wire mainAnode3;
wire [6:0] mainTOPsevenSeg; 

always #5 CLK = ~CLK; // 100MHz

Top uut (CLK,ButtonUp_unfiltered,ButtonDown_unfiltered,ButtonLeft_unfiltered,ButtonRight_unfiltered,SWITCH,LED,mainAnode0,mainAnode1,mainAnode2,mainAnode3,mainTOPsevenSeg);

initial begin
ButtonUp_unfiltered = 0;
ButtonDown_unfiltered = 0;
ButtonLeft_unfiltered = 0;
ButtonRight_unfiltered = 0;
SWITCH = 0;


#50000 // adds '69' to the stack
SWITCH = 69;
ButtonLeft_unfiltered = 0; // button3
ButtonRight_unfiltered = 0; // button2
ButtonDown_unfiltered = 0; //button1
ButtonUp_unfiltered = 1; // button0

#1000
ButtonLeft_unfiltered = 0; // button3
ButtonRight_unfiltered = 0; // button2
ButtonDown_unfiltered = 0; //button1
ButtonUp_unfiltered = 0; // button0


#1000 // adds '42' to the stack'
SWITCH = 42;
ButtonLeft_unfiltered = 0; // button3
ButtonRight_unfiltered = 0; // button2
ButtonDown_unfiltered = 0; //button1
ButtonUp_unfiltered = 1; // button0

#1000
ButtonLeft_unfiltered = 0; // button3
ButtonRight_unfiltered = 0; // button2
ButtonDown_unfiltered = 0; //button1
ButtonUp_unfiltered = 0; // button0


#1000 // adds '25' to the stack
SWITCH = 25;
ButtonLeft_unfiltered = 0; // button3
ButtonRight_unfiltered = 0; // button2
ButtonDown_unfiltered = 0; //button1
ButtonUp_unfiltered = 1; // button0

#1000
ButtonLeft_unfiltered = 0; // button3
ButtonRight_unfiltered = 0; // button2
ButtonDown_unfiltered = 0; //button1
ButtonUp_unfiltered = 0; // button0


#1000 // clears the SPR and DVR
SWITCH = 25;
ButtonLeft_unfiltered = 0; // button3
ButtonRight_unfiltered = 0; // button2
ButtonDown_unfiltered = 0; //button1
ButtonUp_unfiltered = 1; // button0

#1000
ButtonLeft_unfiltered = 0; // button3
ButtonRight_unfiltered = 0; // button2
ButtonDown_unfiltered = 0; //button1
ButtonUp_unfiltered = 0; // button0


//#35000  // subtracts two numbers above and stores one less stack size address
//ButtonLeft_unfiltered = 0; // button3
//ButtonRight_unfiltered = 1; // button2
//ButtonDown_unfiltered = 1; //button1
//ButtonUp_unfiltered = 0; // button0

//#3500
//ButtonLeft_unfiltered = 0; // button3
//ButtonRight_unfiltered = 0; // button2
//ButtonDown_unfiltered = 0; //button1
//ButtonUp_unfiltered = 0; // button0





//#7000  // subtracts two numbers above and stores one less stack size address
//ButtonLeft_unfiltered = 0; // button3
//ButtonRight_unfiltered = 1; // button2
//ButtonDown_unfiltered = 1; //button1
//ButtonUp_unfiltered = 0; // button0

//#3500
//ButtonLeft_unfiltered = 0; // button3
//ButtonRight_unfiltered = 0; // button2
//ButtonDown_unfiltered = 0; //button1
//ButtonUp_unfiltered = 0; // button0






//#3500 //adds two numbers above and stores on one less stack size address
//ButtonLeft_unfiltered = 0; // button3
//ButtonRight_unfiltered = 1; // button2
//ButtonDown_unfiltered = 0; //button1
//ButtonUp_unfiltered = 1; // button0

//#1000
//ButtonLeft_unfiltered = 0; // button3
//ButtonRight_unfiltered = 0; // button2
//ButtonDown_unfiltered = 0; //button1
//ButtonUp_unfiltered = 0; // button0




//#3500 //adds two numbers above and stores on one less stack size address
//ButtonLeft_unfiltered = 0; // button3
//ButtonRight_unfiltered = 1; // button2
//ButtonDown_unfiltered = 0; //button1
//ButtonUp_unfiltered = 1; // button0

//#1000
//ButtonLeft_unfiltered = 0; // button3
//ButtonRight_unfiltered = 0; // button2
//ButtonDown_unfiltered = 0; //button1
//ButtonUp_unfiltered = 0; // button0



//#1000 // decreases stack by one and inserts zeros into stack
//ButtonLeft_unfiltered = 0; // button3
//ButtonRight_unfiltered = 0; // button2
//ButtonDown_unfiltered = 1; //button1
//ButtonUp_unfiltered = 0; // button0

//#1000
//ButtonLeft_unfiltered = 0; // button3
//ButtonRight_unfiltered = 0; // button2
//ButtonDown_unfiltered = 0; //button1
//ButtonUp_unfiltered = 0; // button0




//#1000 // decreases stack by one and inserts zeros into stack
//ButtonLeft_unfiltered = 0; // button3
//ButtonRight_unfiltered = 0; // button2
//ButtonDown_unfiltered = 1; //button1
//ButtonUp_unfiltered = 0; // button0

//#1000
//ButtonLeft_unfiltered = 0; // button3
//ButtonRight_unfiltered = 0; // button2
//ButtonDown_unfiltered = 0; //button1
//ButtonUp_unfiltered = 0; // button0





//#1000 // increments DAR by 1
//ButtonLeft_unfiltered = 1; // button3
//ButtonRight_unfiltered = 1; // button2
//ButtonDown_unfiltered = 0; //button1
//ButtonUp_unfiltered = 1; // button0

//#1000
//ButtonLeft_unfiltered = 0; // button3
//ButtonRight_unfiltered = 0; // button2
//ButtonDown_unfiltered = 0; //button1
//ButtonUp_unfiltered = 0; // button0




//#1000 // increments DAR by 1
//ButtonLeft_unfiltered = 1; // button3
//ButtonRight_unfiltered = 1; // button2
//ButtonDown_unfiltered = 0; //button1
//ButtonUp_unfiltered = 1; // button0

//#1000
//ButtonLeft_unfiltered = 0; // button3
//ButtonRight_unfiltered = 0; // button2
//ButtonDown_unfiltered = 0; //button1
//ButtonUp_unfiltered = 0; // button0



//#10000 //resets the DAR to the top of the stack (=SPR +1)
//ButtonLeft_unfiltered = 1; // button3
//ButtonRight_unfiltered = 0; // button2
//ButtonDown_unfiltered = 0; //button1
//ButtonUp_unfiltered = 1; // button0

//#1000
//ButtonLeft_unfiltered = 0; // button3
//ButtonRight_unfiltered = 0; // button2
//ButtonDown_unfiltered = 0; //button1
//ButtonUp_unfiltered = 0; // button0




//#35000 // DEC ADDR - DAR down the stack 
//ButtonLeft_unfiltered = 1; // button3
//ButtonRight_unfiltered = 1; // button2
//ButtonDown_unfiltered = 1; //button1
//ButtonUp_unfiltered = 0; // button0

//#35000
//ButtonLeft_unfiltered = 0; // button3
//ButtonRight_unfiltered = 0; // button2
//ButtonDown_unfiltered = 0; //button1
//ButtonUp_unfiltered = 0; // button0




//#35000 // DEC ADDR - DAR down the stack
//ButtonLeft_unfiltered = 1; // button3
//ButtonRight_unfiltered = 1; // button2
//ButtonDown_unfiltered = 1; //button1
//ButtonUp_unfiltered = 0; // button0

//#3500
//ButtonUp_unfiltered = 0; // button0
//ButtonDown_unfiltered = 0; //button1
//ButtonLeft_unfiltered = 0; // button3
//ButtonRight_unfiltered = 0; // button2



/*
#350000000 //adds two numbers above and stores on one less stack size address
ButtonUp_unfiltered = 1; // button0
ButtonDown_unfiltered = 0; //button1
ButtonLeft_unfiltered = 0; // button3
ButtonRight_unfiltered = 1; // button2

#350000000 
ButtonUp_unfiltered = 0; // button0
ButtonDown_unfiltered = 0; //button1
ButtonLeft_unfiltered = 0; // button3
ButtonRight_unfiltered = 0; // button2

#350000000 //adds two numbers above and stores on one less stack size address
ButtonUp_unfiltered = 1; // button0
ButtonDown_unfiltered = 0; //button1
ButtonLeft_unfiltered = 0; // button3
ButtonRight_unfiltered = 1; // button2

#350000000 
ButtonUp_unfiltered = 0; // button0
ButtonDown_unfiltered = 0; //button1
ButtonLeft_unfiltered = 0; // button3
ButtonRight_unfiltered = 0; // button2
*/
/*
#250000000 // increments DAR by 1
ButtonUp_unfiltered = 1; // button0
ButtonDown_unfiltered = 0; //button1
ButtonLeft_unfiltered = 1; // button3
ButtonRight_unfiltered = 1; // button2

#250000000 
ButtonUp_unfiltered = 0; // button0
ButtonDown_unfiltered = 0; //button1
ButtonLeft_unfiltered = 1; // button3
ButtonRight_unfiltered = 1; // button2

#250000000 //increments DAR by 1
ButtonUp_unfiltered = 1; // button0
ButtonDown_unfiltered = 0; //button1
ButtonLeft_unfiltered = 1; // button3
ButtonRight_unfiltered = 1; // button2

#250000000 
ButtonUp_unfiltered = 0; // button0
ButtonDown_unfiltered = 0; //button1
ButtonLeft_unfiltered = 1; // button3
ButtonRight_unfiltered = 1; // button2


#250000000 //resets the DAR to the top of the stack (=SPR +1)
ButtonUp_unfiltered = 1; // button0
ButtonDown_unfiltered = 0; //button1
ButtonLeft_unfiltered = 1; // button3
ButtonRight_unfiltered = 0; // button2
*/

/*#250000000 // decrements DAR by 1
ButtonUp_unfiltered = 0; // button0
ButtonDown_unfiltered = 1; //button1
ButtonLeft_unfiltered = 1; // button3
ButtonRight_unfiltered = 1; // button2

#250000000 
ButtonUp_unfiltered = 0; // button0
ButtonDown_unfiltered = 0; //button1
ButtonLeft_unfiltered = 1; // button3
ButtonRight_unfiltered = 1; // button2

#250000000 // decrements DAR by 1
ButtonUp_unfiltered = 0; // button0
ButtonDown_unfiltered = 1; //button1
ButtonLeft_unfiltered = 1; // button3
ButtonRight_unfiltered = 1; // button2

#250000000 
ButtonUp_unfiltered = 0; // button0
ButtonDown_unfiltered = 0; //button1
ButtonLeft_unfiltered = 1; // button3
ButtonRight_unfiltered = 1; // button2
*/
/*#250000000 
ButtonUp_unfiltered = 0; // button0
ButtonDown_unfiltered = 0; //button1
ButtonLeft_unfiltered = 1; // button3
ButtonRight_unfiltered = 1; // button2
*/
/*
#350000000 // decreases stack by one and inserts zeros into stack
ButtonUp_unfiltered = 0; // button0
ButtonDown_unfiltered = 1; //button1
ButtonLeft_unfiltered = 0; // button3
ButtonRight_unfiltered = 0; // button2

#250000000
ButtonUp_unfiltered = 0; // button0
ButtonDown_unfiltered = 0; //button1
ButtonLeft_unfiltered = 0; // button3
ButtonRight_unfiltered = 0; // button2

#350000000// decreases stack by one and inserts zero 
ButtonUp_unfiltered = 0; // button0
ButtonDown_unfiltered = 1; //button1
ButtonLeft_unfiltered = 0; // button3
ButtonRight_unfiltered = 0; // button2

#250000000// should now be at stack = 0 size
//ButtonDown_unfiltered = 0; 
ButtonUp_unfiltered = 0; // button0
ButtonDown_unfiltered = 0; //button1
ButtonLeft_unfiltered = 0; // button3
ButtonRight_unfiltered = 0; // button2
*/

end






endmodule
