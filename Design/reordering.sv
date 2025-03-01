/*------------------------------------------------------------------------------
 * File          : reordering.sv
 * Project       : RTL
 * Author        : epnsrc
 * Creation date : Jul 24, 2024
 * Description   :
 *------------------------------------------------------------------------------*/
`timescale 1ns/1ns

module reordering (
	input logic clk,
	input logic reset,
	input logic [8:0] num_images,
	input logic reorder_start,
	output logic [8:0] temp_new_reference,
	output logic new_reference_is_done,
	output logic [8:0] count_image,
	output logic [8:0] last_image,
	output logic finish_reordering,
	// Memory signals
	input logic [31:0] reorder_O1, reorder_O2,    // Memory data inputs
	output logic [11:0] reorder_A1, reorder_A2,   // Memory address outputs
	output logic reorder_WEB1, reorder_WEB2       // Write enable outputs
);

	logic [8:0] distance;
	logic [511:0] images_bus;
	logic [255:0] hash_referance; 
	logic [255:0] compare_hash; 
	logic [3:0] hash_index;
	logic [8:0] temp_minimum;
	logic [8:0] current_image_index, compare_image_index;
	logic reading_current, reading_compare, compare_in_progress;
	logic hashes_ready;
	logic distance_ready;
	logic finish_flag;

	// Sequential logic (register loading)
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			count_image <= 0;
			images_bus <= 1;
			distance <=  16'hFFFF;
			temp_minimum <= 16'hFFFF;
			temp_new_reference <= 16'hFFFF;
			hash_index <= 0;
			current_image_index <= 0;
			compare_image_index <= 0;
			reading_current <= 0;
			reading_compare <= 0;
			hashes_ready <= 0;
			hash_referance <= 0;
			compare_hash <= 0;
			compare_in_progress <= 0;
			new_reference_is_done <= 0;
			distance_ready <=0;
			finish_flag <= 0;
			finish_reordering <= 0; 
			reorder_A1 <= reorder_A1;
			reorder_A2 <= reorder_A2;
		end else if (reorder_start) begin
			//default values - set previous values
			count_image <= count_image;
			images_bus <= images_bus;
			distance <=  distance;
			temp_minimum <= temp_minimum;
			temp_new_reference <= temp_new_reference;
			hash_index <= hash_index;
			current_image_index <= current_image_index;
			compare_image_index <= compare_image_index;
			reading_current <= reading_current;
			reading_compare <= reading_compare;
			hashes_ready <= hashes_ready;
			hash_referance <= hash_referance;
			compare_hash <= compare_hash;
			compare_in_progress <= compare_in_progress;
			new_reference_is_done <= new_reference_is_done;
			finish_flag <= finish_flag;
			finish_reordering <= finish_reordering; 
			reorder_A1 <= reorder_A1;
			reorder_A2 <= reorder_A2;
			if (count_image < num_images && !finish_flag) begin
				if (!reading_current && !reading_compare && !compare_in_progress && !hashes_ready) begin
					// Start reading the current hash
					current_image_index <= (count_image == 0) ? 0 : temp_new_reference;
					reading_current <= 1;
					hash_index <= 2;
					reorder_A1 <= (count_image == 0) ? 12'(256): 12'((temp_new_reference * 8) + 256);
					reorder_A2 <= (count_image == 0) ? 12'(256+1): 12'((temp_new_reference * 8) + 256+1);
				end

				if (reading_current && !hashes_ready) begin
					hash_referance[((hash_index-1) * 32)-1 -: 32] <= reorder_O1;
					hash_referance[((hash_index) * 32)-1 -: 32] <= reorder_O2;
					hash_index <= hash_index + 2;
					if (hash_index < 8) begin
						reorder_A1 <= 12'(current_image_index* 8 + hash_index + 256);
						reorder_A2 <= 12'(current_image_index* 8 + hash_index +1+ 256);
					end

					if (hash_index == 8) begin
						hash_index <= 2;
						reading_current <= 0;
						compare_image_index <= 0; 
						compare_in_progress <= 1;
					end
				end

				if (compare_in_progress && !reading_compare  && !hashes_ready) begin
					// Start reading the compare hash
					if (!images_bus[compare_image_index]) begin
						reading_compare <= 1;
						hash_index <= 2;
						reorder_A1 <= 12'(compare_image_index*8 + 256);
						reorder_A2 <= 12'(compare_image_index*8 + 256 +1);
						hashes_ready <= 0;
					end else begin
						compare_image_index <= compare_image_index + 1; // Skip already used images
						hashes_ready <= 0;
						reading_compare <= 0;
					end
				end

				if (reading_compare && !hashes_ready) begin
					compare_hash[((hash_index-1) * 32)-1 -: 32] <= reorder_O1;
					compare_hash[((hash_index) * 32)-1 -: 32] <= reorder_O2;
					hash_index <= hash_index + 2;
					if (hash_index < 8) begin
						reorder_A1 <= 12'(compare_image_index* 8 + hash_index + 256);
						reorder_A2 <= 12'(compare_image_index* 8 + hash_index +1 + 256);
					end
					if (hash_index == 8) begin
						hash_index <= 2;
						reading_compare <= 0;
						hashes_ready <= 1;
					end
				end

				if ((hashes_ready && !images_bus[compare_image_index])) begin
					// Compare current and compare hashes
					if (compare_image_index < num_images) begin
						if (!distance_ready) begin
							distance <= $countones(hash_referance ^ compare_hash);
							distance_ready <= 1;
						end else begin 
							$display("Comparing i=%0d, j=%0d: Distance=%0d", current_image_index, compare_image_index, distance);
							$display("image i=%0d, hash=%b", current_image_index, hash_referance);
							$display("image j=%0d, hash=%b", compare_image_index, compare_hash);
							if (distance < temp_minimum) begin
								$display("Updating temp_minimum: Old=%0d, Now=%0d, Index=%0d", temp_minimum, distance, compare_image_index);
								temp_minimum <= distance;
								temp_new_reference <= compare_image_index;
							end
							distance_ready <= 0;
							compare_image_index <= compare_image_index + 1;
							hashes_ready <= 0;
							reorder_A1 <= 12'((compare_image_index+1)*8 + 256);
							reorder_A2 <= 12'((compare_image_index+1)*8 + 256 +1);
							if (compare_image_index >= num_images-1) begin
								new_reference_is_done <= 1;
							end
						end 
					end 
				end
				
				if (compare_image_index >= num_images-1 && images_bus[compare_image_index]==1) begin
					new_reference_is_done <= 1;
				end
				
				if (new_reference_is_done) begin
					$display("Finished comparisons for image %0d, next reference is %0d", current_image_index, temp_new_reference);
					// Finished comparisons for this image
					images_bus[temp_new_reference] <= 1;
					count_image <= count_image + 1;
					compare_in_progress <= 0;
					reading_compare <= 0;
					temp_minimum <= 16'hFFFF;
					distance <=  16'hFFFF;
					temp_new_reference <= temp_new_reference;
					new_reference_is_done <= 0;
				end
				
				if (count_image == num_images-2) begin
					finish_flag <= 1;
				end 
			end else begin 
				new_reference_is_done <= 1;				
				finish_reordering <= 1;		
			end
		end
	end

	// Combinational logic for memory address and write-enable
	always_comb begin
		reorder_WEB1 = 1; // Always in read mode
		reorder_WEB2 = 1; // Always in read mode
		if (finish_flag) begin
			//$display("image bus %b", images_bus);
			for (int i=0; i<num_images; i++) begin
				if (images_bus[i] == 0 ) begin 
					last_image = i;
					break;
				end
			end
		end else begin 
			last_image = 0;
		end
	end

endmodule