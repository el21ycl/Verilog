/*
  Use State Machine to create a Tic Tac Toe Game
*/
module MiniProject #(
   parameter N = 4    //Number of bits in Key (default 4)
)(
      (*chip_pin = "AF14"*)
      input clock,
		(*chip_pin = "AA14"*)
		input reset,    // Key_0
		(*chip_pin = "Y16"*)
		input key_R,    // Key_3
		(*chip_pin = "W15"*)
		input key_G,   // Key_2
		(*chip_pin = "AA15"*)
		input key_B,   // Key_1
		(*chip_pin = "AE12"*)
		input r,       // switch for reset the Highest score
		(*chip_pin = "AB12"*)
		input Switch,    // switch for start game
		output reg start,// start the game
 		output reg P,    //Play
		output reg G,    // Game Over
		// LT24 uses V16
   	(*chip_pin = "Y21, W21, W20, Y19, W19, W17, V18, V17, W16"*)
		output reg [8:0] LED,
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
		output [6:0] Hex5,     // Display Hex5
		    // LT24 Interface
	   output             resetApp,
      output             LT24Wr_n,
      output             LT24Rd_n,
      output             LT24CS_n,
      output             LT24RS,
      output             LT24Reset_n,
      output [     15:0] LT24Data,
      output             LT24LCDOn
  	
);

reg [2:0] key;

/* // Try to make the button active when released
wire [2:0] kkkey;
reg [2:0] T1;
reg [2:0] T2;
 Try to make the button active when released
always @(posedge clock or negedge reset)begin
     if (!reset) begin
	    T1[2:0]<=0;
	    T2[2:0]<=0;
    end 
	 else begin
	    T1[0] <= ~key_R;
		 T1[1] <= ~key_G;
		 T1[2] <= ~key_B;
		 T2[2:0] <= T1[2:0];
	 end
end

assign kkkey[2:0] = ~T1[2:0] & T2[2:0];

wire button_R;
wire button_G;
wire button_B;
assign button_R = ~kkkey[2];
assign button_G = ~kkkey[1];
assign button_B = ~kkkey[0];
*/

// Separate display of the three buttons with LEDs
always @(posedge clock or negedge reset)begin
     if (!reset) begin
	     key <= {(3){1'b0}};		  
    end 
	 else begin
	     key <= {key_R,key_G,key_B};
	     LED[8:6] <= key;
	 end
end


//State-Machine Registers
     reg [4:0] state;	  
	  localparam start_STATE = 5'b00000;   // The start stage
	  localparam Play_STATE  = 5'b00001;   // The Play stage
	  localparam GG_STATE    = 5'b00010;	// The Game Over stage  

// Define state transitions, which are synchronous
// Define the outputs for each state
always @(posedge clock or negedge reset) begin
    if (!reset) begin
	     P <= 1'b1;
		  G <= 1'b0;
		  start <= 1'b0;
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
                if (Switch) begin // Set Switch as the start key
					     P     <= 1'b1;
						  G <= 1'b0;
					     start <= 1'b0;
                    state <= Play_STATE;
                end 
                else begin
                    state <= start_STATE;
                end
            end

				 Play_STATE: begin // Define state Play behaviour
				    P <= 1'b1;
					 G <= 1'b0;
					 start <= 1'b1;
                if ((count_one) == 0 && (count_ten == 0)) begin // Set Key_3 as the start key
						  state <= GG_STATE;
                end 
                else begin
                    state <= Play_STATE;
                end
             end
				 GG_STATE: begin // Define state Game over behaviour
				    start <= 1'b0;
					 P <= 1'b0;
					 G <= 1'b1;
                if (!reset) begin // Set reset 
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

wire [7:0] count_ten;
wire [7:0] count_one;

// The Countdown timer
Timer #(
        .Time (50_000_000),    // The number of times required to change 50MHz to 1 second
	     .ones (5),
	     .tens (1)
) Timer(
        .start   (start ),
		  .Switch  (Switch),
        .clock   (clock ),
		  .reset   (reset ),
		  .count_ten  (count_ten ),
		  .count_one  (count_one )
	 );

//	Display of countdown timer on a 7-segment display
HexTo7Segment theten(
        .hex   (count_ten  ),
		  .seg7  (Hex5       )
	 );
	 
HexTo7Segment Theone(
        .hex   (count_one  ),
		  .seg7  (Hex4       )
	 );
 
 wire score;

// Display the screen 
LT24 LT24(
//      .Switch          (Switch      ),
        .start        (start    ),
        .P            (P        ),
		  .key_R        (key_R    ),// button_R    ),
		  .key_G        (key_G    ),// button_G    ),
		  .key_B        (key_B    ),// button_B    ),
        .clock        (clock    ),
		  .globalReset  (~reset   ),
		  .resetApp     (resetApp ),
		  .LT24Wr_n     (LT24Wr_n ),
		  .LT24Rd_n     (LT24Rd_n ),
		  .LT24CS_n     (LT24CS_n ),
		  .LT24RS       (LT24RS   ),
		  .LT24Reset_n  (LT24Reset_n ),
		  .LT24Data     (LT24Data    ),
		  .LT24LCDOn    (LT24LCDOn   ),
		  .score        (score       ),
		  .state_c      (state_c     )
	 );

// Record the score
score Therecord(
        .score   (score     ),
		  .r       (r         ),
		  .clock   (clock     ),
		  .reset   (reset     ),
		  .one     (one       ),
		  .ten     (ten       ),
		  .High_one (High_one ),
		  .High_ten (High_ten )
	 );
wire [7:0] ten;
wire [7:0] one;
//	Display of one&ten on a 7-segment display	 
HexTo7Segment Thescore2(
        .hex   (ten        ),
		  .seg7  (Hex1       )
	 );
	 
HexTo7Segment Thescore1(
        .hex   (one        ),
		  .seg7  (Hex0       )
	 );
wire [7:0] High_ten;
wire [7:0] High_one;	

HexTo7Segment TheH2(
        .hex   (High_ten   ),
		  .seg7  (Hex3       )
	 );
	 
HexTo7Segment TheH1(
        .hex   (High_one   ),
		  .seg7  (Hex2       )
	 );

 /*
wire [4:0] state_c;	 
//	Display of state2 on a 7-segment display		 
HexTo7Segment Thestate2(
        .hex   (state_c    ),
		  .seg7  (Hex3       )
	 );

//	Display of state1 on a 7-segment display	 
StateTo7Segment thestate(
        .hex   (state),
		  .seg7  (Hex2 )
	 );	 
*/	 
endmodule // End of module

