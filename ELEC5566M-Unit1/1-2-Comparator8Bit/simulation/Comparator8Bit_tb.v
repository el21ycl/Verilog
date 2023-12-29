//                                                             /*!\notex{
// 8-Bit Comparator Test Bench
// ---------------------------
// By: Thomas Carpenter
// For: University of Leeds
// Date: 29th December 2017 
//
// Short Description
// -----------------
// This is a simple test bench module to test the 8-Bit Comparator.
// module with a few stimulii.
//


//                                                             }!*/
// Timescale indicates unit of delays.
//  `timescale  unit / precision
// Where delays are given as:
//   #unit.precision                                           /*!\notex{
//
// Let's stick with a "unit" of 1ns. You may choose the "precision".
//
// e.g for `timescale 1ns/100ps then:
//   #1 = 1ns
//   #1.5 = 1.5ns
//   #1.25 = 1.3ns (rounded to nearest precision)
//                                                             }!*/
`timescale 1 ns/100 ps
// Test bench module declaration
// Always end test bench module names with _tb for clarity, and use no port list
module Comparator8Bit_tb;
// Test Bench Generated Signals
reg [7:0] a;
reg [7:0] b;
// DUT Output Signals
wire a_lt_b;
wire a_gt_b;
wire a_eq_b;
// Device Under Test. Instance typically named "dut", or "ModuleName_dut".
Comparator8Bit comparator8Bit_dut (
  .a      ( a      ),
  .b      ( b      ),
  .a_lt_b ( a_lt_b ),
  .a_gt_b ( a_gt_b ),
  .a_eq_b ( a_eq_b )
);
// Test Bench Logic
initial begin
   //Print to console that the simulation has started. $time is the current sim time.
   $display("%d ns\tSimulation Started",$time);  
   //Monitor changes to any values listed, and automatically print to the console 
   //when they change. There can only be one $monitor per simulation.
   $monitor("%d ns\ta=%d\tb=%d\tlt=%b\tgt=%b\teq=%b",$time,a,b,a_lt_b,a_gt_b,a_eq_b);
   //Initialise a and b to 0.
   a = 8'd0;
   b = 8'd0;
   #10; //Wait 10 units.
   a = 8'd10;
   b = 8'd12;
   #10; //Wait 10 units.
   a = 8'd9;
   b = 8'd3;
   #10; //Wait 10 units.
   a = 8'd7;
   b = 8'd7;
   #10; //Wait 10 units.
   a = 8'd21;
   b = 8'd42;
   #10; //Wait 10 units.
   $display("%d ns\tSimulation Finished",$time); //Finished
   //There are no other processes running in this testbench, so "run -all" in 
   //ModelSim will finish the simulation automatically now.
   //We can also use $stop(); to finish the simulation whenever we want.
end
endmodule
