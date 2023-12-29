/*
 * 2-State Mealy Example
 * ---------------------
 * For: University of Leeds
 * Date: 2nd January 2018
 *
 * Description
 * ------------
 * The module is a simple example of a two state
 * Mealy machine described in the Lab 5 notes.
 *
 */

module Mealy (
    input clock, 
    input reset,
    input w,
    output reg z
);
//State-Machine Registers
reg [1:0] state;
localparam A_STATE = 2'b01;
localparam B_STATE = 2'b10;
//Define the outputs for each state
always @ (*) begin
    case (state)
        A_STATE: begin // Define state A behaviour
            z = 1'b1; // when sufficient water level
        end
        B_STATE: begin // Define state B behaviour
            if (w) begin
                z = 1'b1; // In state B, z *is* dependent on input and state.
            end else begin
                z = 1'b0;
            end
        end
        default: z = 1'b0;
    endcase
end 
//Define state transitions, which are synchronous
always @(posedge clock or posedge reset) begin
    if (reset) begin
        state <= A_STATE;
    end else begin
        case (state)
            A_STATE: begin // Define state A behaviour
                if (w) begin
                    state <= B_STATE;
                end 
                if (!w) begin
                    state <= A_STATE;
                end
            end
            B_STATE: begin // Define state B behaviour
                if (w) begin
                    state <= B_STATE;
                end 
                if (!w) begin
                    state <= A_STATE;
                end
            end
            default: state <= A_STATE;
        endcase
    end
end
endmodule
