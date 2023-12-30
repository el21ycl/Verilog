//                                                             /*!\notex{
// 8-Bit DigitalLock Test Bench
// ---------------------------
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
module DigitalLock_tb;

localparam RST_CYCLES = 2; //Number of cycles of reset at beginning.
// Test Bench Generated Signals
reg clock;
reg reset;
reg [3:0] key;
// DUT Output Signals
wire Error;
wire Lk;
wire [3:0] k1;
wire [3:0] k2;
wire [3:0] k3;
wire [3:0] k4;
wire [3:0] m1;
wire [3:0] m2;
wire [3:0] m3;
wire [3:0] m4;

// Device Under Test. Instance typically named "dut", or "ModuleName_dut".
DigitalLock DigitalLock_dut (
  .clock      ( clock      ),
  .reset      ( reset      ),
  .key        ( key ),
  .Error      ( Error ),
  .Lk         (Lk     ),
  .k1         ( k1 ),
  .k2         ( k2 ),
  .k3         ( k3 ),
  .k4         ( k4 ),
  .m1         ( m1 ),
  .m2         ( m2 ),
  .m3         ( m3 ),
  .m4         ( m4 )
);
assign Error1 = Error;
wire [6:0] E;
wire [6:0] r0;
wire [6:0] r1;
wire [6:0] o;
wire [6:0] r2;
ErrorTo7Segment ErrorTo7Segment_dut(
  .Error      ( Error1      ),
  .E          ( E  ),
  .r0         ( r0 ),
  .r1         ( r1 ),
  .o          (o   ),
  .r2         ( r2 )
);
wire [6:0] button;
KeyTo7Segment KeyTo7Segment_dut(
  .key      ( key      ),
  .button   ( button)
);
	always #10 clock =~clock;
// Test Bench Logic
initial begin
   //Print to console that the simulation has started. $time is the current sim time.
   $display("%d ns\tSimulation Started",$time);  
   //Monitor changes to any values listed, and automatically print to the console 
   //when they change. There can only be one $monitor per simulation.k1=%d\t k2=%d\t k3=%d\t k4=%d\t ,k1,k2,k3,k4
   $monitor("%d ns\t reset=%d\t key=%d\t Error=%d\t Lk=%d\t k1=%d\t k2=%d\t k3=%d\t k4=%d\t m1=%d\t m2=%d\t m3=%d\t m4=%d\t",$time,reset,key,Error,Lk,k1,k2,k3,k4,m1,m2,m3,m4);
	$monitor("%d ns\t Error1=%d\t E=%d\t r0=%d\t r1=%d\t o=%d\t r2=%d\t ",$time,Error1,E,r0,r1,o,r2);
	$monitor("%d ns\t key=%d\t button=%d\t ",$time,key,button);
	//Initialise reset and d to 0.
	clock = 1'b0;
   reset = 1'b1;
	repeat(RST_CYCLES) @(posedge clock); //Wait for a couple of clocks
	reset = 1'b0; //Then clear the reset signal.
//                      The PIN setting stage
   @(posedge clock); //At the rising edge of the clock
   key = 4'b0001;    // key0
	@(posedge clock); //At the rising edge of the clock
   key = 4'b0000;
	@(posedge clock); //At the rising edge of the clock
   key = 4'b0010;    // key1
	@(posedge clock); //At the rising edge of the clock
   key = 4'b0000;
	@(posedge clock); //At the rising edge of the clock
   key = 4'b0100;    // key2
	@(posedge clock); //At the rising edge of the clock
   key = 4'b0000;
	@(posedge clock); //At the rising edge of the clock
   key = 4'b1000;    // key3
	@(posedge clock); //At the rising edge of the clock
   key = 4'b0000;
//                      The matching stage
	@(posedge clock); //At the rising edge of the clock
   key = 4'b0001;    // key0
	@(posedge clock); //At the rising edge of the clock
   key = 4'b0000;
	@(posedge clock); //At the rising edge of the clock
   key = 4'b0010;    // key1
	@(posedge clock); //At the rising edge of the clock
   key = 4'b0000;
	@(posedge clock); //At the rising edge of the clock
   key = 4'b0100;    // key2
	@(posedge clock); //At the rising edge of the clock
   key = 4'b0000;
	@(posedge clock); //At the rising edge of the clock
   key = 4'b1000;    // key3
	@(posedge clock); //At the rising edge of the clock
   key = 4'b0000;
//                      The Encoding stage
	@(posedge clock); //At the rising edge of the clock
   key = 4'b0001;    // key0
	@(posedge clock); //At the rising edge of the clock
   key = 4'b0000;
	@(posedge clock); //At the rising edge of the clock
   key = 4'b0100;    // key2
	@(posedge clock); //At the rising edge of the clock
   key = 4'b0000;
	@(posedge clock); //At the rising edge of the clock
   key = 4'b0100;    // key2
	@(posedge clock); //At the rising edge of the clock
   key = 4'b0000;
	@(posedge clock); //At the rising edge of the clock
   key = 4'b0001;    // key0
	@(posedge clock); //At the rising edge of the clock
   key = 4'b0000;
   $display("%d ns\tSimulation Finished",$time); //Finished
   //There are no other processes running in this testbench, so "run -all" in 
   //ModelSim will finish the simulation automatically now.
   //We can also use $stop(); to finish the simulation whenever we want.
	# 600
	$stop;
end
endmodule
