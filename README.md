Introduction

This project provides a complete project outline for designing, implementing, and testing a 4-way traffic light controller. This classic digital design project is an excellent way to apply and understand the principles of Finite State Machines (FSMs), sequential and combinational logic, and the Verilog Hardware Description Language (HDL).
The goal is to manage traffic at a four-way intersection by controlling the sequence of green, yellow, and red lights. For this project, we'll consider two main directions: a North-South (NS) thoroughfare and an East-West (EW) thoroughfare. The controller will ensure that conflicting traffic (e.g., NS and EW) never has a green light simultaneously and that a yellow "warning" light is used between green and red transitions.


Finite State Machine Design

A Moore FSM is a suitable choice here, where the outputs are determined solely by the current state. We have defined  six primary states to manage the traffic flow by controlling the four traffic lights, denoted by M1 to M4 (or outputs). 

This picture shows the different states in a concise manner: https://github.com/baibhav-kumar/Traffic-Signal/blob/main/Pathdiagram.png

1. State S1:  M1 is green, M2 is red, M3 is green, M4 is red. S1 goes to S2 after T1 time.
2. State S2:  M3 becomes yellow, rest is the same. S2 goes to S3 after Ty time.
3. State S3:  M1 stays green, M2 becomes green, M3 goes to red, and M4 remains red. S3 goes to S4 after T2 delay.
4. State S4:  M1 and M2 simultaneously become yellow, others stay red. S4 goes to S5 after Ty delay.
5. State S5:  Only M4 is green, others are red. S5 goes to state S6 after T3 delay.
6. State S6:  M1, M2 and M3 are red while M4 becomes yellow. S6 goes back to S0 after Ty delay.

The state table is represnted in https://github.com/baibhav-kumar/Traffic-Signal/blob/main/stateTable.png









This simulation waveform successfully verifies the correct operation of the 4-way traffic light controller's Finite State Machine (FSM).

The sequence begins as designed in State S1, where the main traffic lanes (lightM1 and lightM3) are green (001) and the crossing lanes (lightM2 and lightM4) are held at red (100).
After the green light duration, the FSM correctly transitions to State S2. In this state, the main lanes switch to a yellow warning light (010) for a brief period, while the crossing lanes remain red, ensuring a safe transition.

Next, the system moves to State S3, where the right-of-way is transferred. The main lanes (lightM1 and lightM3) turn red (100), and the crossing lanes (lightM2 and lightM4) are now given a green light (001).

The rest of the waveform demonstrates the continuation of this cycle for the other direction (States S4 through S6), showing the crossing lanes proceeding through their own yellow and red phases before the system loops back to State S1. The timing and sequence of light changes observed in the waveform perfectly match the intended logic of the state machine shown at the beginning 



