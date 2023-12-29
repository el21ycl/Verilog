module CoffeeMachine_mealy (
    input clock, 
    input reset,
    input B,       // Brew
	 input S,       // Stop
	 input W,       // Water Level
	 input T,       // Temperature
	 input P,
    output reg H,
	 output reg G,
	 output reg Brew,
	 output reg Wait
); 

//State-Machine Registers
reg [2:0] state;

//Local Parameters used to define state names (similar to #define in C)
localparam WAIT_STATE = 3'b000;
localparam HEAT_STATE = 3'b001;
localparam READY_STATE = 3'b010;
localparam BREW_STATE = 3'b011;
localparam ERROR_STATE = 3'b100;

//Define the outputs for each state
always @(state) begin
    case (state)
        WAIT_STATE: begin // Define state A outputs
           H = 1'b0; // Default value for output
	        G = 1'b0; // Default value for output
	        Wait = 1'b1; // when sufficient water level
	        Brew = 1'b0; // Default value for output
        end
        HEAT_STATE: begin // Define state B outputs
           H = 1'b1;
        end
        READY_STATE: begin // Define state C outputs
           G = 1'b1;
        end
		  BREW_STATE: begin // Define state C outputs
           Brew = 1'b1;
        end
		  ERROR_STATE: begin // Define state C outputs
		    if (!reset) begin
           H = 1'b0; // Default value for output
	        G = 1'b1; // Default value for output
	        Wait = 1'b1; // Default value for output
	        Brew = 1'b0; // Default value for output
			 end else begin
			  H = 1'b0; // Default value for output
	        G = 1'b0; // Default value for output
	        Wait = 1'b1; // Default value for output
	        Brew = 1'b0; // Default value for output
          end
		  end
		  default:begin
		  H = 1'b0; // Default value for output
	     G = 1'b0; // Default value for output
	     Wait = 1'b1; // Default value for output
	     Brew = 1'b0; // Default value for output
		  end
    endcase
end

//Define state transitions, which are synchronous
always @(posedge clock or posedge reset) begin
    if (reset) begin
        //Reset the state machine
        state <= WAIT_STATE;
    end 
	 else if (P) begin
	     state <= ERROR_STATE;
	 end
	 else begin
        case (state)
            WAIT_STATE: begin // Define state A behaviour
                if (W) begin 
                    state <= HEAT_STATE;
                end 
                if (!W) begin
                    state <= WAIT_STATE;
                end
            end
            HEAT_STATE: begin // Define state B behaviour
                if (T) begin
                    state <= READY_STATE;
                end 
                if (!T) begin
                    state <= HEAT_STATE;
                end
            end
            READY_STATE: begin // Define state C behaviour
                if (B) begin
                    state <= BREW_STATE;
                end 
                if (!B) begin
                    state <= READY_STATE;
                end
            end
				BREW_STATE: begin // Define state C behaviour
                if (S) begin
                    state <= WAIT_STATE;
                end 
                if (!S) begin
                    state <= BREW_STATE;
                end
            end
            default: begin
                state <= WAIT_STATE;
            end
        endcase
	 end
end

endmodule
