/*
 * LT24 Test Pattern Top
 * ------------------------
 * By: Thomas Carpenter
 * For: University of Leeds
 * Date: 13th February 2019
 *
 * Change Log
 * ----------
 *  1.0 - Initial Design
 *  1.1 - Correct xAddr/yAddr pipe-lining to be in sync with pixelData.
 *
 * Short Description
 * -----------------
 * This module is designed to interface with the LT24 Display Module
 * from Terasic. It makes use of the LT24Display IP core to show a
 * simple test pattern on the display.
 *
 */

module LT24 (
    // Global Clock/Reset
    // - Clock
    input              clock,
    // - Global Reset
    input              globalReset,
	 input              start,
	 input              P,
	 // Buton Key_3, Key_2, Key_1
	 input              key_R, 
	 input              key_G,
	 input              key_B,
    // - Application Reset - for debug
    output             resetApp,   
    // LT24 Interface
    output             LT24Wr_n,
    output             LT24Rd_n,
    output             LT24CS_n,
    output             LT24RS,
    output             LT24Reset_n,
    output [     15:0] LT24Data,
    output             LT24LCDOn,
	 output reg         score,      // Recording scores
    output reg [  4:0] state_c
);

//
// Local Variables
//
reg  [ 7:0] xAddr;
reg  [ 8:0] yAddr;
reg  [15:0] pixelData;
wire        pixelReady;
reg         pixelWrite;

//
// LCD Display
//
localparam LCD_WIDTH  = 240;
localparam LCD_HEIGHT = 320;

LT24Display #(
    .WIDTH       (LCD_WIDTH  ),
    .HEIGHT      (LCD_HEIGHT ),
    .CLOCK_FREQ  (50000000   )
) Display (
    //Clock and Reset In
    .clock       (clock      ),
    .globalReset (globalReset),
    //Reset for User Logic
    .resetApp    (resetApp   ),
    //Pixel Interface
    .xAddr       (xAddr      ),
    .yAddr       (yAddr      ),
    .pixelData   (pixelData  ),
    .pixelWrite  (pixelWrite ),
    .pixelReady  (pixelReady ),
    //Use pixel addressing mode
    .pixelRawMode(1'b0       ),
    //Unused Command Interface
    .cmdData     (8'b0       ),
    .cmdWrite    (1'b0       ),
    .cmdDone     (1'b0       ),
    .cmdReady    (           ),
    //Display Connections
    .LT24Wr_n    (LT24Wr_n   ),
    .LT24Rd_n    (LT24Rd_n   ),
    .LT24CS_n    (LT24CS_n   ),
    .LT24RS      (LT24RS     ),
    .LT24Reset_n (LT24Reset_n),
    .LT24Data    (LT24Data   ),
    .LT24LCDOn   (LT24LCDOn  )
);

//
// X Counter
//
wire [7:0] xCount;
UpCounterNbit #(
    .WIDTH    (          8),
    .MAX_VALUE(LCD_WIDTH-1)
) xCounter (
    .clock     (clock     ),
    .reset     (resetApp  ),
    .enable    (pixelReady),
    .countValue(xCount    )
);

//
// Y Counter
//
wire [8:0] yCount;
wire yCntEnable = pixelReady && (xCount == (LCD_WIDTH-1));
UpCounterNbit #(
    .WIDTH    (           9),
    .MAX_VALUE(LCD_HEIGHT-1)
) yCounter (
    .clock     (clock     ),
    .reset     (resetApp  ),
    .enable    (yCntEnable),
    .countValue(yCount    )
);



//
// Pixel Write
//
always @ (posedge clock or posedge resetApp) begin
    if (resetApp) begin
        pixelWrite <= 1'b0;
    end else begin
        //In this example we always set write high, and use pixelReady to detect when
        //to update the data.
        pixelWrite <= 1'b1;
        //You could also control pixelWrite and pixelData in a State Machine.
    end
end


//State-Machine Registers
//     reg [4:0] state_c;	  
	  localparam cover_STATE  = 5'b00000;   // The start stage
	  localparam Red_STATE    = 5'b00001;   // The Play stage
	  localparam Green_STATE  = 5'b00010;	// The Game Over stage
	  localparam Blue_STATE   = 5'b00011;	// The Game Over stage 
//
// This is a simple test pattern generator.
//
// We create a different colour for each pixel based on 
// the X-Y coordinate.
//
// Make a 1bit random number
reg random;
reg [32:0] count;
always @ (posedge clock or posedge resetApp) begin
      if (resetApp) begin
			  random <= 1'b0;
	   end
		else begin
			 if (count == 10_000_000)begin
			  random <= ~random;
			  count <= {(32){1'b0}};
			end
			else begin
			  count <= count + 1'b1;
			end
		end
end


always @ (posedge clock or posedge resetApp) begin
    if (resetApp) begin
        pixelData           <= 16'b0;
        xAddr               <= 8'b0;
        yAddr               <= 9'b0;
		  score               <= 1'b0;
		  state_c             <= cover_STATE;
    end else if (pixelReady) begin
	  if (P) begin
	    case (state_c)
		     cover_STATE: begin // Define state start behaviour
				 //X/Y Address are just the counter values
              xAddr               <= xCount;
              yAddr               <= yCount;
		      // Black 0x0000, Blue 0x001F, Red 0xF800, Green 0x07E0, Cyan 0x07FF, 
		      // Magenta 0xF81F, Yellow 0xFFE0 and White 0xFFFF.
				if ((xAddr >= LCD_WIDTH/3) && (xAddr <= LCD_WIDTH*2/3)) begin
		           pixelData           <= 16'h07E0;  // Green in the 1/3 of the screen
				end
		      else if (xAddr > LCD_WIDTH*2/3)	begin	 
			        pixelData           <= 16'h001F;	// Blue in the 1/3 of the screen
			   end
				else begin
				     pixelData           <= 16'hF800;  // Red in the 1/3 of the screen
				end 
                  if (start) begin // Set start as the next state
                      state_c  <= Red_STATE;
                  end 
                  else begin
                      state_c  <= cover_STATE;
                  end
            end
				Red_STATE: begin // Define state start behaviour
				 //X/Y Address are just the counter values
              xAddr               <= xCount;
              yAddr               <= yCount;
		      // Black 0x0000, Blue 0x001F, Red 0xF800, Green 0x07E0, Cyan 0x07FF, 
		      // Magenta 0xF81F, Yellow 0xFFE0 and White 0xFFFF.
		      if ((yAddr <= LCD_HEIGHT/4)) begin
				if ((xAddr >= LCD_WIDTH/3) && (xAddr <= LCD_WIDTH*2/3)) begin
		           pixelData           <= 16'h07E0;  // Green in the 1/3 of the screen
				end
		      else if (xAddr > LCD_WIDTH*2/3)	begin	 
			        pixelData           <= 16'h001F;	// Blue in the 1/3 of the screen
			   end
				else begin
				     pixelData           <= 16'hF800;  // Red in the 1/3 of the screen
				end
				end
				else begin
		        pixelData           <= 16'hF800;
				end
/*				  if (!key_R || !key_G || !key_B) begin // Set Switch as the next state
							if (!key_R) begin
							   score <= 1'b1;
							end
							else begin
							  score <= 1'b0;
							end
						state_c  <= cover_STATE;
                  end 
                  else begin
                  state_c  <= Red_STATE;
                  end
              end
*/				  
                 if (!key_R) begin // Set Key_1 as the next state
							   score = 1'b1;;
							 if (random) begin
                          state_c <= Green_STATE;
                      end 
                      else begin
                          state_c  <= Blue_STATE;
                      end
						end
						else begin
						score = 1'b0;
						end
            end
				Green_STATE: begin // Define state Green behaviour
            //X/Y Address are just the counter values
              xAddr               <= xCount;
              yAddr               <= yCount;
		      // Black 0x0000, Blue 0x001F, Red 0xF800, Green 0x07E0, Cyan 0x07FF, 
		      // Magenta 0xF81F, Yellow 0xFFE0 and White 0xFFFF.
				if ((yAddr <= LCD_HEIGHT/4)) begin
				if ((xAddr >= LCD_WIDTH/3) && (xAddr <= LCD_WIDTH*2/3)) begin
		           pixelData           <= 16'h07E0;  // Green in the 1/3 of the screen
				end
		      else if (xAddr > LCD_WIDTH*2/3)	begin	 
			        pixelData           <= 16'h001F;	// Blue in the 1/3 of the screen
			   end
				else begin
				     pixelData           <= 16'hF800;  // Red in the 1/3 of the screen
				end
				end
				else begin
		        pixelData           <= 16'h07E0;
				end
                  if (!key_G) begin // Set Key_2 as the next state
							   score = 1'b1;
							 if (random) begin
                          state_c  <= Blue_STATE;
                      end 
                      else begin
                          state_c  <= Red_STATE;
                     end
						end
						else begin
						score = 1'b0;
						end
            end
				Blue_STATE: begin // Define state start behaviour
            //X/Y Address are just the counter values
              xAddr               <= xCount;
              yAddr               <= yCount;
		      // Black 0x0000, Blue 0x001F, Red 0xF800, Green 0x07E0, Cyan 0x07FF, 
		      // Magenta 0xF81F, Yellow 0xFFE0 and White 0xFFFF.
		      if ((yAddr <= LCD_HEIGHT/4)) begin
				if ((xAddr >= LCD_WIDTH/3) && (xAddr <= LCD_WIDTH*2/3)) begin
		           pixelData           <= 16'h07E0;  // Green in the 1/3 of the screen
				end
		      else if (xAddr > LCD_WIDTH*2/3)	begin	 
			        pixelData           <= 16'h001F;	// Blue in the 1/3 of the screen
			   end
				else begin
				     pixelData           <= 16'hF800;  // Red in the 1/3 of the screen
				end
				end
				else begin
		        pixelData           <= 16'h001F;
				end
                  if (!key_B) begin // Set Key_1 as the next state
							   score = 1'b1;
							 if (random) begin
                          state_c <= Red_STATE;
                      end 
                      else begin
                          state_c  <= Green_STATE;
                      end
						end
						else begin
						score = 1'b0;
						end
             end
        default: state_c  <= cover_STATE;
       endcase
      end
    end
end

endmodule

/*
 * N-Bit Up Counter
 * ----------------
 * By: Thomas Carpenter
 * Date: 13/03/2017 
 *
 * Short Description
 * -----------------
 * This module is a simple up-counter with a count enable.
 * The counter has parameter controlled width, increment,
 * and maximum value.
 *
 */

module UpCounterNbit #(
    parameter WIDTH = 10,               //10bit wide
    parameter INCREMENT = 1,            //Value to increment counter by each cycle
    parameter MAX_VALUE = (2**WIDTH)-1  //Maximum value default is 2^WIDTH - 1
)(   
    input                    clock,
    input                    reset,
    input                    enable,    //Increments when enable is high
    output reg [(WIDTH-1):0] countValue //Output is declared as "WIDTH" bits wide
);

always @ (posedge clock) begin
    if (reset) begin
        //When reset is high, set back to 0
        countValue <= {(WIDTH){1'b0}};
    end else if (enable) begin
        //Otherwise counter is not in reset
        if (countValue >= MAX_VALUE[WIDTH-1:0]) begin
            //If the counter value is equal or exceeds the maximum value
            countValue <= {(WIDTH){1'b0}};   //Reset back to 0
        end else begin
            //Otherwise increment
            countValue <= countValue + INCREMENT[WIDTH-1:0];
        end
    end
end

endmodule
