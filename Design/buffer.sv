/*------------------------------------------------------------------------------
 * File          : buffer.sv
 * Project       : RTL
 * Author        : epnsrc
 * Creation date : Aug 14, 2024
 * Description   :
 *------------------------------------------------------------------------------*/

`timescale 1ns/1ns

module image_buffer (
	input logic clk,
	input logic reset,
	input logic [7:0] pixel_data,
	input logic pixel_valid,
	output logic image_buffer_valid,
	output logic [15:0] sum,
	// Memory interface signals
	output logic [31:0] buffer_I1,  // Memory data inputs
	output logic [11:0] buffer_A1,  // Memory address outputs
	output logic buffer_WEB1        // Write enable outputs
);

	logic [8:0] pixel_index;

	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			pixel_index <= 0;
			image_buffer_valid <= 0;
			sum <= 0;
		end else if (pixel_valid) begin
			if (pixel_index < 256) begin
				pixel_index <= pixel_index + 1;
				image_buffer_valid <= 0;
				if (pixel_index==0) begin
					sum <= pixel_data;
				end else begin 
					sum <= sum + pixel_data;
				end
				$display("pixel %d value %d", pixel_index, pixel_data);
			end
			else if (pixel_index >= 256) begin
				image_buffer_valid <= 1;
				$display("image_buffer_valid=1");
				pixel_index <= 0; 
				sum <= sum;
			end
		end
	end
	
	always_comb begin
		if (pixel_index<=256 && image_buffer_valid==0 && pixel_valid) begin
			buffer_A1 = pixel_index>0 ? 12'(pixel_index-1) : 12'(0);
			buffer_I1 = 32'(pixel_data);
		end else begin
			buffer_A1 = buffer_A1;
			buffer_I1 = buffer_I1;
		end
		buffer_WEB1 = 0; // Write enable
	end

endmodule
