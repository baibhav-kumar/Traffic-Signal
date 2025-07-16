`timescale 1ns/1ps
`include "traffic_light_controller.v"

module traffic_light_controller_TB;

    // Testbench signals
    reg clk;
    reg rst;
    wire [2:0] lightM1;
    wire [2:0] lightM2;
    wire [2:0] lightM3;
    wire [2:0] lightM4;

    // Instantiate the DUT (Design Under Test) - Corrected and Completed
    traffic_light_controller dut (
        .clk(clk),
        .rst(rst),
        .lightM1(lightM1),
        .lightM2(lightM2),
        .lightM3(lightM3),
        .lightM4(lightM4)
    );

    // Clock generation (e.g., 50MHz clock with a 20ns period)
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // A 10ns half-period creates a 20ns full period
    end

    // Test sequence
    initial begin
        // Apply reset at the beginning
        rst = 1;
        #50; // Hold reset for 50ns
        rst = 0;

        // Let the simulation run for enough time to see several full cycles
        #1000;

        // Stop the simulation
        $finish;
    end

    // Monitor to display output changes
    initial begin
        // Display a header for the output
        $display("Time(ns)\t rst\t lightM1\t lightM2\t lightM3\t lightM4");
        // Monitor signals and print when any of them change
        $monitor("%0t\t %b\t %b\t %b\t %b\t %b",
                 $time, rst, lightM1, lightM2, lightM3, lightM4);
    end


initial begin 
$dumpfile("traffic_light_controller.vcd");
$dumpvars(0,traffic_light_controller_TB);
end
endmodule
