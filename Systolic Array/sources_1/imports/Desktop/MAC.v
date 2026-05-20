`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Created by Daniel Krueger and Ryan Arnold
//////////////////////////////////////////////////////////////////////////////////

`define Max 3'b011 //exponent calculation

module MAC(
    input [7:0] A
    ,input [7:0] B
    ,input [7:0] C
    ,input resetflag
    ,output [7:0] outputA
    );
    //Goal is A + B*C
    wire [4:0] exponentAdd;
    wire [9:0] mantissaMultiply; //must be ten bits - bit 9 or 8 or both must be one
    reg [7:0] finalBtimesC = 0;
    reg testflag = 0;
    
    assign signbit = (~C[7] && B[7])||(C[7] && ~B[7]);//sign bit
    
    //Exponent bits 6-4
    //Mantissa bits 3-0
    
    //step 1
    assign exponentAdd = C[6:4] + B[6:4] - `Max;
    //step 2
    //multiply mantissa bits result is 10 bits
    assign mantissaMultiply = {1'b1,C[3:0]} * {1'b1,B[3:0]};
    
    always @ (resetflag)
        begin
            //step 3 check for 0
            if(B == 0 || C == 0 )//check for 0
                begin
                    finalBtimesC = 0;
                end
            else
                begin
                //step 4a
                //Normalization
                    if(mantissaMultiply[9] == 1'b1) //Check for normalization
                    begin
                        finalBtimesC[7] = signbit;
                        finalBtimesC[6:4] = exponentAdd + 1;
                        finalBtimesC[3:0] = mantissaMultiply[8:5];
                    end
                    //No Normalization
                    else
                    begin
                        finalBtimesC[7] = signbit;
                        finalBtimesC[6:4] = exponentAdd[2:0];
                        finalBtimesC[3:0] = mantissaMultiply[7:4]; 
                    end
                end           
        end
    
    
    //A + (B X C)
    
    //Adder r
    //testcase 0.1*1 - .1
    reg [7:0] finalMac = 0;
    reg [4:0] addresult = 0;
    reg [4:0] alignment = 0;
    reg [10:0] addreg = 0;//max A or B is 10 bits and 2 10 bit numbers added together is an 11 bit number
    wire [9:0] Aext;
    wire [9:0] BCext;
    
    
    assign BCext = {1'b1,finalBtimesC[3:0],5'b00000};//can be shifted right a maximum of 5 bits
    assign Aext = {1'b1,A[3:0],5'b00000};//can be shifted right a maximum of 5 bits (6-1)
    
    always @(resetflag)
        begin
            //A and B have same sign
            if(A[7] == finalBtimesC[7])
                begin
                    //alignment
                       testflag = 1;
                       finalMac[7] = A[7];//same sign
                       alignment = finalBtimesC[6:4] - A[6:4];
      
                       //exponent bits
                       if(alignment < 0)//A is bigger
                            begin
                                addreg = Aext + (BCext>>(A[6:4]-finalBtimesC[6:4]));  //bitshift bxc to the left by Ea-Eb bits
                            //find first 1 from the left
                                if (addreg[10] == 1'b1)// furthest left is a 1
                                    begin
                                        finalMac[6:4] = A[6:4] + 1; // larger exponent + 1
                                        finalMac[3:0] = addreg[9:6];
                                    end
                                else if (addreg[9] == 1'b1)
                                    begin
                                        finalMac[6:4] = A[6:4] + 0;
                                        finalMac[3:0] = addreg[8:5];
                                        
                                    end
                               else if (addreg[8] == 1'b1)
                                    begin
                                        finalMac[6:4] = A[6:4] -1;
                                        finalMac[3:0] = addreg[7:4];
                                        
                                    end
                               else if (addreg[7] == 1'b1)
                                    begin
                                        finalMac[6:4] = A[6:4] -2;
                                        finalMac[3:0] = addreg[6:3];
                                    end
                               else if (addreg[6] == 1'b1)
                                    begin
                                        finalMac[6:4] = A[6:4] -3;
                                        finalMac[3:0] = addreg[5:2];
                                    end
                               else if (addreg[5] == 1'b1)
                                    begin
                                        finalMac[6:4] = A[6:4] -4;
                                        finalMac[3:0] = addreg[4:1];
                                    end
                               else if (addreg[4] == 1'b1)
                                    begin
                                        finalMac[6:4] = A[6:4] -5;
                                        finalMac[3:0] = addreg[3:0];
                                    end
                               else if (addreg[3] == 1'b1)//this case and the cases below may never happen
                                    begin
                                        finalMac[6:4] = A[6:4] -6;
                                        finalMac[3:0] = {addreg[2:0],1'b0};
                                    end
                            end
                       else //bxc is bigger
                            begin
                            addreg = 0;
                            addreg = BCext + (Aext>>(finalBtimesC[6:4]-A[6:4]));
                            
                            if (addreg[10] == 1'b1)// furthest left is a 1
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] + 1; // larger exponent + 1
                                        finalMac[3:0] = addreg[9:6];
                                    end
                                else if (addreg[9] == 1'b1)
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] + 0;
                                        finalMac[3:0] = addreg[8:5];
                                        
                                    end
                               else if (addreg[8] == 1'b1)
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] -1;
                                        finalMac[3:0] = addreg[7:4];
                                        
                                    end
                               else if (addreg[7] == 1'b1)
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] -2;
                                        finalMac[3:0] = addreg[6:3];
                                    end
                               else if (addreg[6] == 1'b1)
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] -3;
                                        finalMac[3:0] = addreg[5:2];
                                    end
                               else if (addreg[5] == 1'b1)
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] -4;
                                        finalMac[3:0] = addreg[4:1];
                                    end
                               else if (addreg[4] == 1'b1)
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] -5;
                                        finalMac[3:0] = addreg[3:0];
                                    end
                               else if (addreg[3] == 1'b1)//this case and the cases below may never happen
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] -6;
                                        finalMac[3:0] = {addreg[2:0],1'b1};
                                    end
                            
                            end
                       
                end
                
                
                //Opposite signs
            else
                testflag = 0;
                begin
                //big - small
                    if(A[6:4] > finalBtimesC[6:4])//A exponent is bigger so A is bigger
                        begin
                            addreg = Aext - (BCext>>(A[6:4]-finalBtimesC[6:4]));
                            finalMac[7] = A[7]; //same sign
                            if (addreg[10] == 1'b1)// furthest left is a 1 --may never happen 
                                    begin
                                        finalMac[6:4] = A[6:4] + 1; // larger exponent + 1
                                        finalMac[3:0] = addreg[9:6];
                                    end
                                else if (addreg[9] == 1'b1)
                                    begin
                                        finalMac[6:4] = A[6:4] + 0;
                                        finalMac[3:0] = addreg[8:5];
                                        
                                    end
                               else if (addreg[8] == 1'b1)
                                    begin
                                        finalMac[6:4] = A[6:4] -1;
                                        finalMac[3:0] = addreg[7:4];
                                        
                                    end
                               else if (addreg[7] == 1'b1)
                                    begin
                                        finalMac[6:4] = A[6:4] -2;
                                        finalMac[3:0] = addreg[6:3];
                                    end
                               else if (addreg[6] == 1'b1)
                                    begin
                                        finalMac[6:4] = A[6:4] -3;
                                        finalMac[3:0] = addreg[5:2];
                                    end
                               else if (addreg[5] == 1'b1)
                                    begin
                                        finalMac[6:4] = A[6:4] -4;
                                        finalMac[3:0] = addreg[4:1];
                                    end
                               else if (addreg[4] == 1'b1)
                                    begin
                                        finalMac[6:4] = A[6:4] -5;
                                        finalMac[3:0] = addreg[3:0];
                                    end
                            else if (addreg[3] == 1'b1) //this case and the cases below may never happen
                                    begin
                                        finalMac[6:4] = A[6:4] -6;
                                        finalMac[3:0] = {addreg[2:0],1'b1};
                                    end
                               else if (addreg[2] == 1'b1)
                                    begin
                                        finalMac[6:4] = A[6:4] - 7;
                                        finalMac[3:0] = {addreg[1:0],2'b00};
                                    end
                               else if (addreg[1] == 1'b1)
                                    begin
                                        finalMac[6:4] = A[6:4] - 8;
                                        finalMac[3:0] = {addreg[2:0],3'b000};
                                    end
                               else if (addreg[0] == 1'b1)
                                    begin
                                        finalMac[6:4] = A[6:4] - 9;
                                        finalMac[3:0] = {addreg[0],3'b000};
                                    end
                               else//everything is 0
                                    begin
                                        finalMac[6:4] = 0;
                                        finalMac[3:0] = 0;
                                    end
                            
                        end
                        
                    else if (A[6:4] < finalBtimesC[6:4])//BxC exponent is bigger
                        begin
                            addreg = BCext - (Aext>>(finalBtimesC[6:4]-A[6:4]));
                            finalMac[7] = finalBtimesC[7];
                            if (addreg[10] == 1'b1)// furthest left is a 1 --may never happen 
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] + 1; // larger exponent + 1
                                        finalMac[3:0] = addreg[9:6];
                                    end
                                else if (addreg[9] == 1'b1)
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] + 0;
                                        finalMac[3:0] = addreg[8:5];
                                        
                                    end
                               else if (addreg[8] == 1'b1)
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] -1;
                                        finalMac[3:0] = addreg[7:4];
                                        
                                    end
                               else if (addreg[7] == 1'b1)
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] -2;
                                        finalMac[3:0] = addreg[6:3];
                                    end
                               else if (addreg[6] == 1'b1)
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] -3;
                                        finalMac[3:0] = addreg[5:2];
                                    end
                               else if (addreg[5] == 1'b1)
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] -4;
                                        finalMac[3:0] = addreg[4:1];
                                    end
                               else if (addreg[4] == 1'b1)
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] -5;
                                        finalMac[3:0] = addreg[3:0];
                                    end
                               else if (addreg[3] == 1'b1)//this case and the cases below may never happen
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] -6;
                                        finalMac[3:0] = {addreg[2:0],1'b1};
                                    end
                               else if (addreg[2] == 1'b1)
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] - 7;
                                        finalMac[3:0] = {addreg[1:0],2'b00};
                                    end
                               else if (addreg[1] == 1'b1)
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] - 8;
                                        finalMac[3:0] = {addreg[2:0],3'b000};
                                    end
                               else if (addreg[0] == 1'b1)
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] - 9;
                                        finalMac[3:0] = {addreg[0],3'b000};
                                    end
                               else//everything is 0
                                    begin
                                        finalMac[6:4] = 0;
                                        finalMac[3:0] = 0;
                                    end       
                        end
                
                        else if((Aext-BCext)>0)//Exponents same A is bigger
                            begin
                                finalMac[7] = A[7];//same sign as larger number
                                addreg = Aext - BCext;
                                if (addreg[10] == 1'b1)// furthest left is a 1 --may never happen 
                                    begin
                                        finalMac[6:4] = A[6:4] + 1; // larger exponent + 1
                                        finalMac[3:0] = addreg[9:6];
                                    end
                                else if (addreg[9] == 1'b1)
                                    begin
                                        finalMac[6:4] = A[6:4] + 0;
                                        finalMac[3:0] = addreg[8:5];
                                        
                                    end
                               else if (addreg[8] == 1'b1)
                                    begin
                                        finalMac[6:4] = A[6:4] -1;
                                        finalMac[3:0] = addreg[7:4];
                                        
                                    end
                               else if (addreg[7] == 1'b1)
                                    begin
                                        finalMac[6:4] = A[6:4] -2;
                                        finalMac[3:0] = addreg[6:3];
                                    end
                               else if (addreg[6] == 1'b1)
                                    begin
                                        finalMac[6:4] = A[6:4] -3;
                                        finalMac[3:0] = addreg[5:2];
                                    end
                               else if (addreg[5] == 1'b1)
                                    begin
                                        finalMac[6:4] = A[6:4] -4;
                                        finalMac[3:0] = addreg[4:1];
                                    end
                               else if (addreg[4] == 1'b1)
                                    begin
                                        finalMac[6:4] = A[6:4] -5;
                                        finalMac[3:0] = addreg[3:0];
                                    end
                               else if (addreg[3] == 1'b1)//this case and the cases below may never happen
                                    begin
                                        finalMac[6:4] = A[6:4] -6;
                                        finalMac[3:0] = {addreg[2:0],1'b1};
                                    end
                               else if (addreg[2] == 1'b1)
                                    begin
                                        finalMac[6:4] = A[6:4] - 7;
                                        finalMac[3:0] = {addreg[1:0],2'b00};
                                    end
                               else if (addreg[1] == 1'b1)
                                    begin
                                        finalMac[6:4] = A[6:4] - 8;
                                        finalMac[3:0] = {addreg[2:0],3'b000};
                                    end
                               else if (addreg[0] == 1'b1)
                                    begin
                                        finalMac[6:4] = A[6:4] - 9;
                                        finalMac[3:0] = {addreg[0],3'b000};
                                    end
                               else//everything is 0
                                    begin
                                        finalMac[6:4] = 0;
                                        finalMac[3:0] = 0;
                                    end
                            end
                   else if((Aext-BCext)<0)//Exponents same BxC is bigger
                   begin 
                        addreg = BCext - Aext;
                        finalMac[7] = finalBtimesC[7];
                        //normalization
                        if (addreg[10] == 1'b1)// furthest left is a 1 --may never happen 
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] + 1; // larger exponent + 1
                                        finalMac[3:0] = addreg[9:6];
                                    end
                                else if (addreg[9] == 1'b1)
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] + 0;
                                        finalMac[3:0] = addreg[8:5];
                                        
                                    end
                               else if (addreg[8] == 1'b1)
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] -1;
                                        finalMac[3:0] = addreg[7:4];
                                        
                                    end
                               else if (addreg[7] == 1'b1)
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] -2;
                                        finalMac[3:0] = addreg[6:3];
                                    end
                               else if (addreg[6] == 1'b1)
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] -3;
                                        finalMac[3:0] = addreg[5:2];
                                    end
                               else if (addreg[5] == 1'b1)
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] -4;
                                        finalMac[3:0] = addreg[4:1];
                                    end
                               else if (addreg[4] == 1'b1)
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] -5;
                                        finalMac[3:0] = addreg[3:0];
                                    end
                               else if (addreg[3] == 1'b1)//this case and the cases below may never happen
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] -6;
                                        finalMac[3:0] = {addreg[2:0],1'b1};
                                    end
                               else if (addreg[2] == 1'b1)
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] - 7;
                                        finalMac[3:0] = {addreg[1:0],2'b00};
                                    end
                               else if (addreg[1] == 1'b1)
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] - 8;
                                        finalMac[3:0] = {addreg[2:0],3'b000};
                                    end
                               else if (addreg[0] == 1'b1)
                                    begin
                                        finalMac[6:4] = finalBtimesC[6:4] - 9;
                                        finalMac[3:0] = {addreg[0],3'b000};
                                    end
                               else//everything is 0
                                    begin
                                        finalMac[6:4] = 0;
                                        finalMac[3:0] = 0;
                                    end
                        end
                   
                   else // The exponents must be equal as well as the fractions. Therefore both numbers are equal and the result is 0
                    begin
                        finalMac = 0;
                    end
                   
                end
            
        end
        
    assign outputA = finalMac;//outputA is the final output
    
endmodule
