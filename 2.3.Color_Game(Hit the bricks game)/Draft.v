/*
  Use State Machine to create a Tic Tac Toe Game
*/
module Draft #(
   parameter N = 4    //Number of bits in Key (default 4)
)(
      (*chip_pin = "AF14"*)
      input clock,
		(*chip_pin = "W15"*)
		input reset,    // Key_2
		(*chip_pin = "Y16"*)
		input key,      // Key_3
		(*chip_pin = "AA15"*)
		input Result,   // Key_1
		(*chip_pin = "AD10, AC9, AE11, AD12, AD11, AF10, AF9, AC12, AB12"*)
		input [8:0] S,    // Record nine switches
 		output reg Tie,   //Tie
		output reg o,     // Circles Player1
		output reg x,     // Cross   Player2
		output reg P1,    // Play1 win
		output reg P2,    // Play2 win
		output reg J,     // Judge the win or lose
		output reg G,     // Game Over
   	(*chip_pin = "Y21, W21, W20, Y19, W19, W17, V18, V17, W16, V16"*)
		output [9:0] LED,
		(*chip_pin = "AH28, AG28, AF28, AG27, AE28, AE27, AE26"*)
	   output [6:0] Hex0,    // Display Hex0
		(*chip_pin = "AD27, AF30, AF29, AG30, AH30, AH29, AJ29"*)
	   output [6:0] Hex1,    // Display Hex1
		(*chip_pin = "AC30, AC29, AD30, AC28, AD29, AE29, AB23"*)
	   output [6:0] Hex2,    // Display Hex2
		(*chip_pin = "AB22, AB25, AB28, AC25, AD25, AC27, AD26"*)
	   output [6:0] Hex3,    // Display Hex3
		(*chip_pin = "W25, V23, W24, W22, Y24, Y23, AA24"*)
		output [6:0] Hex4,    // Display Hex4
		(*chip_pin = "AA25, AA26, AB26, AB27, Y27, AA28, V25"*)
		output [6:0] Hex5     // Display Hex5
	
);
wire enable;
wire [8:0] w;
wire [8:0] Ro;  // The result of circles
wire [8:0] Rx;  // The result of crosses
wire [8:0] Current;
wire [8:0] last;


//State-Machine Registers
     reg [4:0] state;	  
	  localparam start_STATE = 5'b00000;   // The start stage
	  localparam Well0_STATE = 5'b00001;   // The well stage
	  localparam Well1_STATE = 5'b00010;	  
	  localparam Well2_STATE = 5'b00011;	  
	  localparam Well3_STATE = 5'b00100;   
	  localparam Well4_STATE = 5'b00101;
	  localparam Judge1_STATE= 5'b00110;   // The Judge stage
	  localparam Well5_STATE = 5'b00111;
	  localparam Judge2_STATE= 5'b01000;   // The Judge stage   
	  localparam Well6_STATE = 5'b01001;
	  localparam Judge3_STATE= 5'b01010;   // The Judge stage   
	  localparam Well7_STATE = 5'b01011;
	  localparam Judge4_STATE= 5'b01100;   // The Judge stage   
	  localparam Well8_STATE = 5'b01101;
	  localparam Result_STATE= 5'b01110;   // The Result stage
	  localparam GG_STATE    = 5'b01111;   // The Game over stage
	  	  
// Define the outputs for each state
always @ (*) begin
    case (state)
        start_STATE: begin // Define state start behaviour
					 o <= 1'b0; // Player1
					 x <= 1'b0; // Player2
					 P1 <= 1'b0;  
					 P2 <= 1'b0;
					 Tie <= 1'b0;
					 J <= 1'b0; 
					 G <= 1'b0; 
        end
        Well0_STATE: begin // Define state Well0 behaviour
			       o <= 1'b1; // Player1
					 x <= 1'b0;
        end
		  Well1_STATE: begin // Define state Well1 behaviour
		          o <= 1'b0;
					 x <= 1'b1; // Player2
        end
		  Well2_STATE: begin // Define state Well2 behaviour
					 o <= 1'b1; // Player1
					 x <= 1'b0;
        end
		  Well3_STATE: begin // Define state Well3 behaviour					 
					 o <= 1'b0;
					 x <= 1'b1; // Player2
        end
/* 
      0 | 1 | 2
	  --- --- ---
      3 | 4 | 5
	  --- --- ---            -> 876543210
      6 | 7 | 8             9'b000000000
*/
		  Well4_STATE: begin // Define state Well4 behaviour
      			 o <= 1'b1; // Player1
					 x <= 1'b0;
				 // Check whether P1 has won the tic-tac-toe game 
				  if (((Ro & 9'b000000111) == 9'b000000111) ||
				      ((Ro & 9'b000111000) == 9'b000111000) ||
					   ((Ro & 9'b111000000) == 9'b111000000) ||
					   ((Ro & 9'b001001001) == 9'b001001001) ||
						((Ro & 9'b010010010) == 9'b010010010) ||
						((Ro & 9'b100100100) == 9'b100100100) ||
						((Ro & 9'b100010001) == 9'b100010001) ||
						((Ro & 9'b001010100) == 9'b001010100) 
					  ) begin
					  P1 <= 1'b1;
					 end 
					 else begin
					  P1 <= 1'b0; 
					 end	 
        end
		  Judge1_STATE: begin // Define state Judge1 behaviour					 
					 o <= 1'b0;  
					 x <= 1'b0;
					 J <= 1'b1;
        end
		  Well5_STATE: begin // Define state Well5 behaviour	          
					 o <= 1'b0;
					 x <= 1'b1; // Player2 
				 // Check whether P2 has won the tic-tac-toe game  
				  if (((Rx & 9'b000000111) == 9'b000000111) ||
				      ((Rx & 9'b000111000) == 9'b000111000) ||
					   ((Rx & 9'b111000000) == 9'b111000000) ||
					   ((Rx & 9'b001001001) == 9'b001001001) ||
						((Rx & 9'b010010010) == 9'b010010010) ||
						((Rx & 9'b100100100) == 9'b100100100) ||
						((Rx & 9'b100010001) == 9'b100010001) ||
						((Rx & 9'b001010100) == 9'b001010100) 
					  ) begin
					  P2 <= 1'b1;
					end
					else begin
					  P2 <= 1'b0; 
					end
        end
		  Judge2_STATE: begin // Define state Judge2 behaviour					 
					 o <= 1'b0;  
					 x <= 1'b0;
					 J <= 1'b1;
        end
		  Well6_STATE: begin // Define state Well6 behaviour 
					 o <= 1'b1; // Player1
					 x <= 1'b0;
			 // Check whether P1 has won the tic-tac-toe game 
			     if (((Ro & 9'b000000111) == 9'b000000111) ||
				      ((Ro & 9'b000111000) == 9'b000111000) ||
					   ((Ro & 9'b111000000) == 9'b111000000) ||
					   ((Ro & 9'b001001001) == 9'b001001001) ||
						((Ro & 9'b010010010) == 9'b010010010) ||
						((Ro & 9'b100100100) == 9'b100100100) ||
						((Ro & 9'b100010001) == 9'b100010001) ||
						((Ro & 9'b001010100) == 9'b001010100) 
					  ) begin
					  P1 <= 1'b1;
					 end 
					 else begin
					  P1 <= 1'b0; 
					 end		
        end
		  Judge3_STATE: begin // Define state Judge3 behaviour					 
					 o <= 1'b0;  
					 x <= 1'b0;
					 J <= 1'b1;
        end
		  Well7_STATE: begin // Define state Well7 behaviour		  			 
					 o <= 1'b0;
					 x <= 1'b1; // Player2
		   // Check whether P2 has won the tic-tac-toe game 
				  if (((Rx & 9'b000000111) == 9'b000000111) ||
				      ((Rx & 9'b000111000) == 9'b000111000) ||
					   ((Rx & 9'b111000000) == 9'b111000000) ||
					   ((Rx & 9'b001001001) == 9'b001001001) ||
						((Rx & 9'b010010010) == 9'b010010010) ||
						((Rx & 9'b100100100) == 9'b100100100) ||
						((Rx & 9'b100010001) == 9'b100010001) ||
						((Rx & 9'b001010100) == 9'b001010100) 
					  ) begin
					  P2 <= 1'b1;
					end
				 	else begin
					  P2 <= 1'b0; 
					end 
        end
		  Judge4_STATE: begin // Define state Judge4 behaviour					 
					 o <= 1'b0;  
					 x <= 1'b0;
					 J <= 1'b1;
        end
		  Well8_STATE: begin // Define state Well8 behaviour		          
					 o <= 1'b1; // Player1
				 	 x <= 1'b0; 
			// Check whether P1 has won the tic-tac-toe game 
			      if(((Ro & 9'b000000111) == 9'b000000111) ||
				      ((Ro & 9'b000111000) == 9'b000111000) ||
					   ((Ro & 9'b111000000) == 9'b111000000) ||
					   ((Ro & 9'b001001001) == 9'b001001001) ||
						((Ro & 9'b010010010) == 9'b010010010) ||
						((Ro & 9'b100100100) == 9'b100100100) ||
						((Ro & 9'b100010001) == 9'b100010001) ||
						((Ro & 9'b001010100) == 9'b001010100) 
					  ) begin
					  P1 <= 1'b1;
				     end	
				     else begin
					  Tie <= 1'b1;
				     end	   
        end
		  Result_STATE: begin // Define state Lock3 behaviour
		          o <= 1'b0; 
					 x <= 1'b0; 
        end
		  GG_STATE: begin // Define state Lock3 behaviour
		          o <= 1'b0; 
					 x <= 1'b0; 
		          G <= 1'b1;  // Game Over
        end
    endcase
end 

//Define state transitions, which are synchronous
always @(posedge clock or negedge reset) begin
    if (!reset) begin
        state <= start_STATE;
    end 
/*else if (t) begin
        state <= PIN1_STATE; // To timer
    end 
*/
	 else begin // Press the button within 50 rise times
        case (state)
               // Unlocked State //
// According to the sequence of pressing the four key buttons as a PIN code
//-----------    Start state    ----------// 
            start_STATE: begin // Define state start behaviour
                if (!key) begin // Set Key_3 as the start key
                    state <= Well0_STATE;
                end 
                else begin
                    state <= start_STATE;
                end
            end
//---------     Well state    ----------//
            Well0_STATE: begin // Define state Well0 behaviour
				   if (current > last) begin // Make the pressed switch not repeated
                    state <= Well1_STATE;
					end
					else begin
                    state <= Well0_STATE;
                end
            end
				Well1_STATE: begin // Define state Well1 behaviour
					if (current > last) begin
						  state <= Result_STATE;
                end 
					 else begin
                    state <= Well1_STATE;
                end
            end
/*				Well2_STATE: begin // Define state Well2 behaviour
               if (enable) begin  
						  state <= Well3_STATE;
					end 
					else begin
						  state <= Well2_STATE;
					end
            end
			   Well3_STATE: begin // Define state Well3 behaviour
               if (enable) begin  
						  state <= Well4_STATE;
					end 
					else begin
						  state <= Well3_STATE;
					end
            end
			   Well4_STATE: begin // Define state Well4 behaviour
              if (enable) begin  
					     state <= Judge1_STATE; 
					end 
					else begin
						  state <= Well4_STATE;
					end	 
            end
				Judge1_STATE: begin // Define state Judge1 behaviour
					if (P1 || P2) begin
						  state <= Result_STATE;
                end 
					 else begin
                    state <= Well5_STATE;
                end
            end
				Well5_STATE: begin // Define state Well5 behaviour 
				  if (enable) begin
					     state <= Judge2_STATE;
				  end   
				  else begin
						  state <= Well5_STATE;
				  end
            end
				Judge2_STATE: begin // Define state Judge2 behaviour
					if (P1 || P2) begin
						  state <= Result_STATE;
                end 
					 else begin
                    state <= Well6_STATE;
                end
            end
				Well6_STATE: begin // Define state Well6 behaviour  
				  if (enable) begin
					     state <= Judge3_STATE;
				  end   
				  else begin
						  state <= Well6_STATE;
				  end
            end
				Judge3_STATE: begin // Define state Judge3 behaviour
					if (P1 || P2) begin
						  state <= Result_STATE;
                end 
					 else begin
                    state <= Well7_STATE;
                end
            end
            Well7_STATE: begin // Define state Well7 behaviour  
				  if (enable) begin
					     state <= Judge4_STATE;
				  end   
				  else begin
						  state <= Well7_STATE;
				  end
            end
				Judge4_STATE: begin // Define state Judge4 behaviour
					if (P1 || P2) begin
						  state <= Result_STATE;
                end 
					 else begin
                    state <= Well8_STATE;
                end
            end
				Well8_STATE: begin // Define state Well8 behaviour
				   if (enable) begin  
						  state <= Result_STATE;
					end 
					else begin
						  state <= Well8_STATE;
					end
            end*/
//----------     Win state    -----------//
            Result_STATE: begin // Define state Result behaviour
				  if (!Result) begin
					  state <= GG_STATE;					  
				  end
				  else begin
				     state <= Result_STATE;	
				  end
            end
				GG_STATE: begin // Define state Game Over behaviour
				  if (!reset) begin
					  state <= start_STATE;					  
				  end
				  else begin
				     state <= GG_STATE;	
				  end
            end
				
            default: state <= start_STATE;
        endcase
    end
end 


//	Display of o&x on a 7-segment display
Segment7_ox Theox(
	     .o     (o    ),
        .x     (x   ),
		  .Hex2  (Hex2 ),
		  .Hex3  (Hex3 ),
		  .Hex4  (Hex4 ),
		  .Hex5  (Hex5 )
	 );

HexTo7Segment thetest1(
        .hex   (w    ),
		  .seg7  (Hex1 ),
	 );

StateTo7Segment thestate(
        .hex   (state),
		  .seg7  (Hex0 ),
	 );
 
//	Calculation of switches
Switch TheS(
        .S      (S    ),
	     .o      (o    ),
        .x      (x    ),
		  .LED    (LED  ),
		  .clock  (clock),
		  .reset  (reset),
		  .w      (w    ),
		  .Ro     (Ro   ),
		  .Rx     (Rx   ),
		  .enable (enable),
		  .last   (last  ),
		  .current(current)
		  
	 );
	 
	 
endmodule // End of module

module Switch (
  inout [8:0] S,  // Switch
  input clock,
  input reset,
  input o,    // Turn to Player 1
  input x,    // Turn to Player 2
  output reg [8:0] w,
  output reg [8:0] Ro, // The result of circles
  output reg [8:0] Rx, // The result of corsses
  output reg enable,    // Determining whether to go to the next stage
  output reg [8:0] last,
  output reg [8:0] current,
  output reg [9:0] LED
);


always@ (posedge clock or negedge reset) begin
    if (!reset)begin
	    last <= {(9){1'b0}};
		 current <= {(9){1'b0}};
	    enable <= 1'b0;
		 Ro <= {(9){1'b0}};
		 Rx <= {(9){1'b0}};
		 w <= {(9){1'b0}};
		 LED [9] <= 1'b0;
     end
	  else if (S && 9'b111111111) begin
	      current <= S;
			if (current > last) begin
			  w <= ~last & current; // Determine which switch it is
			  LED [9] <= 1'b1;
			  enable <= 1'b1;       // Allowed to the next stage
			  last <= S;
			  if (o) begin
			  Ro <= Ro | w;
			  LED [8] <= 1'b1;
			  LED [7] <= 1'b0;
			  end
			  else if (x) begin
			  Rx <= Rx | w;
			  LED [8] <= 1'b0;
			  LED [7] <= 1'b1;
			  end
			end
			else begin
			  enable <= 1'b0;
			  LED [9] <= 1'b0;
			end
	  end
  end
  
 always@ (*) begin
     
     LED [4:0] <= Ro;

end
  
endmodule
