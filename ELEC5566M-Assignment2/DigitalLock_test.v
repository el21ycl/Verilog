/*
  Use Mealy State Machine to create a digital lock
*/
module DigitalLock_test #(
   parameter N = 4    //Number of bits in Key (default 4)
)(

      input clock,
		input reset,
		input [N-1:0] key,
		output reg Error,   // Error
		output reg Lk  //Locked

);
 //State-Machine Registers
     reg [3:0] state;
	  reg [N-1:0] k1;
	  reg [N-1:0] k2;
	  reg [N-1:0] k3;
	  reg [N-1:0] k4;
	  reg [N-1:0] a;
	  localparam PIN1_STATE = 4'b0001;
	  localparam PIN2_STATE = 4'b0010;
	  localparam PIN3_STATE = 4'b0011;	  
	  localparam PIN4_STATE   = 4'b0100;	  
	  localparam MATCH1_STATE = 4'b0101;
	  localparam MATCH2_STATE = 4'b0110;
	  localparam MATCH3_STATE = 4'b0111;
	  localparam MATCH4_STATE = 4'b1000;
	  localparam Lock1_STATE = 4'b1001;
	  localparam Lock2_STATE = 4'b1010;
	  localparam Lock3_STATE = 4'b1011;
	  localparam Lock4_STATE = 4'b1100;
	  
//Define the outputs for each state
always @ (*) begin
    case (state)
        PIN1_STATE: begin // Define state PIN1 behaviour
            k1 <= key;    // The first Key button pressed
        end
        PIN2_STATE: begin // Define state PIN2 behaviour
            k2 <= key;    // The second Key button pressed
        end
		  PIN3_STATE: begin // Define state PIN3 behaviour
            k3 <= key;    // The third Key button pressed
        end
		  PIN4_STATE: begin // Define state PIN4 behaviour
            k4 <= key;    // The fourth Key button pressed
        end
		  MATCH1_STATE: begin // Define state MATCH1 behaviour
            if (k1 == (key & 4'b1111)) begin
                Lk = 1'b0;
					 Error = 1'b0;
            end 
				else begin
				    Error = 1'b1;   //When there is a mismatch, the error indicator output is marked high
				end      
        end
		  MATCH2_STATE: begin // Define state MATCH2 behaviour
            if (k2 == (key & 4'b1111)) begin
                Lk = 1'b0;
					 Error = 1'b0;
            end 
				else begin
				    Error = 1'b1;   //When there is a mismatch, the error indicator output is marked high
				end       
        end
		  MATCH3_STATE: begin // Define state MATCH3 behaviour
            if (k3 == (key & 4'b1111)) begin
                Lk = 1'b0;
					 Error = 1'b0;
            end 
				else begin
				    Error = 1'b1;   //When there is a mismatch, the error indicator output is marked high
				end        
        end
		  MATCH4_STATE: begin // Define state MATCH4 behaviour
            if (k4 == (key & 4'b1111)) begin
                Lk = 1'b0;
					 Error = 1'b0;  
            end 
				else begin
				    Error = 1'b1;  //When there is a mismatch, the error indicator output is marked high
				end       
        end
		  Lock1_STATE: begin // Define state Lock1 behaviour
            Lk = 1'b1;     // LOCKED indicator output is marked high
        end
		  Lock2_STATE: begin // Define state Lock2 behaviour
            Lk = 1'b1;      
        end
		  Lock3_STATE: begin // Define state Lock3 behaviour
            Lk = 1'b1;      
        end
		  Lock4_STATE: begin // Define state Lock4 behaviour
            Lk = 1'b1;      
        end
        default: begin
		  k1 = 4'b0000;
		  k2 = 4'b0000;
		  k3 = 4'b0000;
		  k4 = 4'b0000;
		  Lk = 1'b0;
		  Error = 1'b0;
		  end
    endcase
end 

//Define state transitions, which are synchronous
always @(posedge clock or posedge reset) begin
    if (reset) begin
        state <= PIN1_STATE;
    end 
	 else begin
        case (state)
               // Unlocked State //
// According to the sequence of pressing the four key buttons as a PIN code
            PIN1_STATE: begin // Define state PIN1 behaviour
                if (key & 4'b1111) begin
                    state <= PIN2_STATE;
                end 
                else begin
                    state <= PIN1_STATE;
                end
            end
            PIN2_STATE: begin // Define state PIN2 behaviour
				   if (key & 4'b1111) begin
                if (key != k1) begin // Make the pressed key not repeated
                    state <= PIN3_STATE;
                end 
                if (key == k1) begin
                    state <= PIN1_STATE;
                end
					end
            end
				PIN3_STATE: begin // Define state PIN3 behaviour
               if (key & 4'b1111) begin
                if (key != k1 & key != k2) begin
                    state <= PIN4_STATE;
                end 
					 else begin
                    state <= PIN1_STATE;
                end
               end
            end
				PIN4_STATE: begin // Define state PIN4 behaviour
               if (key & 4'b1111) begin
						 if (key == a) begin
							  state <= MATCH1_STATE;
						 end 
						 else begin
							  state <= PIN1_STATE;
						 end
					end
            end
// Pairing with the sequence of the first press of the four key buttons
			MATCH1_STATE: begin // Define state MATCH1 behaviour
                if (k1 == (key & 4'b1111)) begin
                    state <= MATCH2_STATE;
                end 
                if (k1 != (key & 4'b1111)) begin
                    state <= PIN1_STATE;
                end
            end
			MATCH2_STATE: begin // Define state MATCH2 behaviour
                if (k2 == (key & 4'b1111)) begin
                    state <= MATCH3_STATE;
                end 
                if (k2 != (key & 4'b1111)) begin
                    state <= PIN1_STATE;
                end
            end
				MATCH3_STATE: begin // Define state MATCH3 behaviour
                if (k3 == (key & 4'b1111)) begin
                    state <= MATCH4_STATE;
                end 
                if (k3 != (key & 4'b1111)) begin
                    state <= PIN1_STATE;
                end
            end
				MATCH4_STATE: begin // Define state MATCH4 behaviour
                if (k4 == (key & 4'b1111)) begin
                    state <= Lock1_STATE;
                end 
                if (k4 != (key & 4'b1111)) begin
                    state <= PIN1_STATE;
                end
				end
               // Locked State //				
// Press the four key buttons in the correct sequence to unlock
            Lock1_STATE: begin // Define state MATCH4 behaviour
                if (k1 == (key & 4'b1111)) begin
                    state <= Lock2_STATE;
                end 
                if (k1 != (key & 4'b1111)) begin
                    state <= Lock1_STATE;
                end
				end
				Lock2_STATE: begin // Define state MATCH4 behaviour
                if (k2 == (key & 4'b1111)) begin
                    state <= Lock3_STATE;
                end 
                if (k2 != (key & 4'b1111)) begin
                    state <= Lock1_STATE;
                end
				end
				Lock3_STATE: begin // Define state MATCH4 behaviour
                if (k3 == (key & 4'b1111)) begin
                    state <= Lock4_STATE;
                end 
                if (k3 != (key & 4'b1111)) begin
                    state <= Lock1_STATE;
                end
				end
				Lock4_STATE: begin // Define state MATCH4 behaviour
                if (k4 == (key & 4'b1111)) begin
                    state <= PIN1_STATE;  // Unlocked successfully, back to unlocked state
                end 
                if (k4 != (key & 4'b1111)) begin
                    state <= Lock1_STATE;
                end
				end
            default: state <= PIN1_STATE;
        endcase
    end
end 

// Instantiate ErrorTo7Segment
//	Error message on the 7-segment display
ErrorTo7Segment ErrorSegment(
	     .Error  (Error    ),
        .E    (E    ),
		  .r0   (r0   ),
		  .r1   (r1   ),
        .o    (o    ),
        .r2   (r2   )
	 );
	 
// Instantiate ErrorTo7Segment
//	Display of keys on a 7-segment display
KeyTo7Segment KeySegment(
	     .key     (key     ),
        .button (button )
	 );
	 
endmodule

	 