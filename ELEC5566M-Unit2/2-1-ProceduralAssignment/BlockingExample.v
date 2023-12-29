/*
 * Blocking Assignment Example
 * ===========================
 *
 */

module BlockingExample (
    input clock, 
    input D, 
    output reg Q1,
    output reg Q2
);

always @( posedge clock ) begin //At to rising edge of clock
    Q1 = D;  //Set Q1 equal to D
    Q2 = Q1; //Then set Q2 equal to Q1
end
endmodule
