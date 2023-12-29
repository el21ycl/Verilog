/*
  Use Mealy State Machine to create a digital lock
*/
module DigitalLock #(
   parameter N = 4    //Number of bits in Key (default 4)
)(

      input clock,
		input reset,
		input [N-1:0] key,
		output reg Error, // Error
		output reg Lk,    //Locked
		output reg [N-1:0] k1,     // Record the sequence of the four buttons
	   output reg [N-1:0] k2,
	   output reg [N-1:0] k3,
	   output reg [N-1:0] k4,
		output reg [N-1:0] m1,
	   output reg [N-1:0] m2,
	   output reg [N-1:0] m3,
	   output reg [N-1:0] m4
);
 //State-Machine Registers
     reg [3:0] state;	  
	  localparam PIN1_STATE = 4'b0001;     // The PIN setting stage
	  localparam PIN2_STATE = 4'b0010;
	  localparam PIN3_STATE = 4'b0011;	  
	  localparam PIN4_STATE   = 4'b0100;	  
	  localparam MATCH1_STATE = 4'b0101;   // The matching stage
	  localparam MATCH2_STATE = 4'b0110;
	  localparam MATCH3_STATE = 4'b0111;
	  localparam MATCH4_STATE = 4'b1000;
	  localparam Lock1_STATE = 4'b1001;    // The encoding stage
	  localparam Lock2_STATE = 4'b1010;
	  localparam Lock3_STATE = 4'b1011;
	  localparam Lock4_STATE = 4'b1100;
	  
//Define the outputs for each state
always @ (*) begin
    case (state)
        PIN1_STATE: begin // Define state PIN1 behaviour
                Lk = 1'b0;
					 Error = 1'b0;  
        end
        PIN2_STATE: begin // Define state PIN2 behaviour
                Lk = 1'b0;
			  if (key) begin
            if (key == k1) begin // When the repeated button is pressed, an error will be reported
					 Error <= 1'b1;  
            end 
				else begin
				    Error <= 1'b0;  // When there is a mismatch, the error indicator output is marked high
				end
           end		  
        end
		  PIN3_STATE: begin // Define state PIN3 behaviour
                Lk = 1'b0;
			  if (key) begin
            if (key == k1 & key == k2) begin // When the repeated button is pressed, an error will be reported
					 Error <= 1'b1;  
            end 
				else begin
				    Error <= 1'b0;  // When there is a mismatch, the error indicator output is marked high
				end
           end	
        end
		  PIN4_STATE: begin // Define state PIN4 behaviour
                Lk = 1'b0;
			  if (key) begin
            if (key != ~( k1| k2 | k3)) begin // When the repeated button is pressed, an error will be reported
					 Error <= 1'b1;  
            end 
				else begin
				    Error <= 1'b0;  // When there is a mismatch, the error indicator output is marked high
				end
           end	
        end
		  MATCH1_STATE: begin // Define state MATCH1 behaviour
             Lk <= 1'b0;
			  if (key) begin
            if (k1 == key) begin
					 Error <= 1'b0;  
            end 
				else begin
				    Error <= 1'b1;  //When there is a mismatch, the error indicator output is marked high
				end
           end		      
        end
		  MATCH2_STATE: begin // Define state MATCH2 behaviour
             Lk <= 1'b0;
			  if (key) begin
            if (k2 == key) begin
					 Error <= 1'b0;  
            end 
				else begin
				    Error <= 1'b1;  //When there is a mismatch, the error indicator output is marked high
				end
           end		       
        end
		  MATCH3_STATE: begin // Define state MATCH3 behaviour
             Lk <= 1'b0;
			  if (key) begin
            if (k3 == key) begin
					 Error <= 1'b0;  
            end 
				else begin
				    Error <= 1'b1;  //When there is a mismatch, the error indicator output is marked high
				end
           end		    
        end
		  MATCH4_STATE: begin // Define state MATCH4 behaviour
		          Lk <= 1'b0;
			  if (key) begin
            if (k4 == key) begin
					 Error <= 1'b0;  
            end 
				else begin
				    Error <= 1'b1;  //When there is a mismatch, the error indicator output is marked high
				end
           end				
        end
		  Lock1_STATE: begin // Define state Lock1 behaviour
             Lk <= 1'b1;  // LOCKED indicator output is marked high 
			  if (key) begin
            if (k1 == key) begin
					 Error <= 1'b0;  
            end 
				else begin
				    Error <= 1'b1;  //When there is a mismatch, the error indicator output is marked high
				end
           end
        end
		  Lock2_STATE: begin // Define state Lock2 behaviour
              Lk <= 1'b1;  // LOCKED indicator output is marked high 
			  if (key) begin
            if (k2 == key) begin
					 Error <= 1'b0;  
            end 
				else begin
				    Error <= 1'b1;  //When there is a mismatch, the error indicator output is marked high
				end
           end	         
        end
		  Lock3_STATE: begin // Define state Lock3 behaviour
              Lk <= 1'b1;  // LOCKED indicator output is marked high
			  if (key) begin
            if (k3 == key) begin
					 Error <= 1'b0;  
            end 
				else begin
				    Error <= 1'b1;  //When there is a mismatch, the error indicator output is marked high
				end
           end	      
        end
		  Lock4_STATE: begin // Define state Lock4 behaviour
               Lk <= 1'b1; // LOCKED indicator output is marked high
			  if (key) begin
            if (k4 == key) begin
					 Error <= 1'b0;  
            end 
				else begin
				    Error <= 1'b1;  //When there is a mismatch, the error indicator output is marked high
				end
           end	        
        end
        default: begin
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
/*else if (t) begin
        state <= PIN1_STATE; // To timer
    end 
*/
	 else begin // Press the button within 50 rise times
        case (state)
               // Unlocked State //
// According to the sequence of pressing the four key buttons as a PIN code
            PIN1_STATE: begin // Define state PIN1 behaviour
                if (key) begin
                    state <= PIN2_STATE;
						  k1 <= key;    // The first Key button pressed
                end 
                else begin
                    state <= PIN1_STATE;
                end
            end
            PIN2_STATE: begin // Define state PIN2 behaviour
				   if (key) begin
                if (key != k1) begin // Make the pressed key not repeated
                    state <= PIN3_STATE;
						  k2 <= key;    // The second Key button pressed
                end 
                if (key == k1) begin
                    state <= PIN1_STATE;
                end
					end
            end
				PIN3_STATE: begin // Define state PIN3 behaviour
               if (key) begin
                if (key != k1 & key != k2) begin // Exclude the two keys that have been pressed
                    state <= PIN4_STATE;
						  k3 <= key;    // The third Key button pressed
                end 
					 else begin
                    state <= PIN1_STATE;
                end
               end
            end
				PIN4_STATE: begin // Define state PIN4 behaviour
               if (key) begin // == ~( k1| k2 | k3) to simulation 
						 if (key != k2 & key != k3) begin // Exclude the three keys that have been pressed
							  state <= MATCH1_STATE;
							  k4 <= key;    // The forth Key button pressed
						 end 
						 else begin
							  state <= PIN1_STATE;
						 end
					end
            end
// Pairing with the sequence of the first press of the four key buttons
			MATCH1_STATE: begin // Define state MATCH1 behaviour
             if (key) begin  
					if (k1 == key) begin // Matching successful, input next button
                    state <= MATCH2_STATE;
						  m1 <= key;
                end 
                if (k1 != key) begin
                    state <= PIN1_STATE;
                end
				 end	 
            end
			MATCH2_STATE: begin // Define state MATCH2 behaviour
              if (key) begin  
					if (k2 == key) begin
                    state <= MATCH3_STATE;
						  m2 <= key;
                end 
                if (k2 != key) begin
                    state <= PIN1_STATE;
                end
				  end	 
            end
				MATCH3_STATE: begin // Define state MATCH3 behaviour
              if (key) begin  
					if (k3 == key) begin
                    state <= MATCH4_STATE;
						  m3 <= key;
                end 
                if (k3 != key) begin
                    state <= PIN1_STATE;
                end
				  end	 
            end
				MATCH4_STATE: begin // Define state MATCH4 behaviour
              if (key) begin  
					if (k4 == key) begin
                    state <= Lock1_STATE;
						  m4 <= key;
                end 
                if (k4 != key) begin
                    state <= PIN1_STATE;
                end
				  end	 
            end
               // Locked State //				
// Press the four key buttons in the correct sequence to unlock
            Lock1_STATE: begin // Define state MATCH4 behaviour
				  if (key) begin
                if (k1 == key) begin
                    state <= Lock2_STATE;
                end 
                if (k1 != key) begin
                    state <= Lock1_STATE;
                end
				  end
				end
				Lock2_STATE: begin // Define state MATCH4 behaviour
				  if (key) begin
                if (k2 == key) begin
                    state <= Lock3_STATE;
                end 
                if (k2 != key) begin
                    state <= Lock1_STATE;
                end
				  end
				end
				Lock3_STATE: begin // Define state MATCH4 behaviour
				  if (key) begin
                if (k3 == key) begin
                    state <= Lock4_STATE;
                end 
                if (k3 != key) begin
                    state <= Lock1_STATE;
                end
				  end
				end
				Lock4_STATE: begin // Define state MATCH4 behaviour
				  if (key) begin
                if (k4 == key) begin
                    state <= PIN1_STATE;  // Unlocked successfully, back to unlocked state
                end 
                if (k4 != key) begin
                    state <= Lock1_STATE;
                end
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
	 
// Instantiate ErrorTo7Segment
//	Calculate the time when the user stops pressing the key

/*wire t;
Time Time1(
	     .key   (key     ),
        .t     (t  )
	 );*/	 
endmodule

	 