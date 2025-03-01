/*------------------------------------------------------------------------------
 * File          : Hash.sv
 * Project       : RTL
 * Author        : epnsrc
 * Creation date : Aug 14, 2024
 * Description   :
 *------------------------------------------------------------------------------*/

`timescale 1ns/1ns

module hash_calc (        
	input logic clk,
	input logic reset,
	input logic [8:0] image_header,
	input logic hash_start,
	input logic [15:0] sum,
	output logic hash_calc_done,
	// Memory signals
	input logic [31:0] hash_O2,   // pixel data outputs
	output logic [31:0] hash_I1,  // hash data inputs
	output logic [11:0] hash_A1, hash_A2,  // addresses
	output logic hash_WEB1, hash_WEB2      // Write/Read enable
);
	logic [8:0] pixel_index;
	logic [3:0] hash_index;
	logic bit_value;
	logic [31:0] bits; 
	logic [255:0] hash_value;
	
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			bits <= 0;
			pixel_index <= 0;
			hash_calc_done <= 0;
			hash_index <= 0;
			hash_value <= 0;
		end else if (hash_start) begin
			//default values - set previous values
			hash_calc_done <= hash_calc_done;
			pixel_index <= pixel_index ;
			hash_index <= hash_index; 
			bits <= bits;
			hash_value <= hash_value;
			if (!hash_calc_done) begin
				if (pixel_index < 256) begin 
					bits[pixel_index%32] <= bit_value;
					pixel_index <= pixel_index +1;
					hash_value[pixel_index] <= bit_value;
					if ((pixel_index+1)%32==0) begin
						hash_index <= hash_index+1;
					end
				end else if (pixel_index>=256) begin
					hash_calc_done <= 1;
				end
			end else begin
				// Reset hash_calc_done after processing is done
				$display("Hash Value: %b", hash_value);
				$display("avg: %d", sum / 256);
				$display("Hash Value: %b", hash_value);
				$display("Image Index Output: %d", image_header-1);
				$display("Hash Calc Done: %0d", hash_calc_done);
				hash_calc_done <= 0;
				pixel_index <= 0 ;
				hash_index <= 0; 
			end
		end 
	end
	
	always_comb begin
		if (hash_start && pixel_index==0) begin
			hash_A1 = 12'hFFF;
			hash_I1 = 32'(0);
			hash_WEB1 = 0; 
		end else if (hash_start && hash_index<=8 && (pixel_index)%32==0 && pixel_index!=0) begin 
			hash_A1 = 12'(image_header*8+hash_index+256-1);
			hash_I1 = 32'(bits);
			hash_WEB1 = 0; 
		end else begin
			hash_A1 = hash_A1;
			hash_I1 = hash_I1;
			hash_WEB1 = hash_WEB1;
		end
		hash_A2 = 12'(pixel_index);
		hash_WEB2=1;
		if (pixel_index <= 256) begin
			bit_value  = (int'(hash_O2) >= (sum / 256)) ? 1 : 0;
		end else begin
			bit_value = bit_value;
		end
	end
endmodule