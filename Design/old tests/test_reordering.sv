/*------------------------------------------------------------------------------
 * File          : test_reordering.sv
 * Project       : RTL
 * Author        : epnsrc
 * Creation date : Aug 14, 2024
 * Description   :
 *------------------------------------------------------------------------------*/

`timescale 1ns/100fs

module test_reordering();

	// Testbench signals
	logic clk;
	logic reset;
	logic [255:0] hashes[0:65535];
	logic [15:0] num_images;
	logic [15:0] reordered_indices[0:65535];
	logic send_next_image;
	logic [15:0] temp_minimum;
	logic [15:0] temp_new_reference;

	// Instantiate the reordering module
	reordering dut (
		.clk(clk),
		.reset(reset),
		.hashes(hashes),
		.num_images(num_images),
		.reordered_indices(reordered_indices),
		.send_next_image(send_next_image),
		.temp_minimum(temp_minimum),
		.temp_new_reference(temp_new_reference)
	);

	// Clock generation
	always #5 clk = ~clk;

	// Test vector
	localparam TEST_IMAGES = 5;
	logic [255:0] test_hashes[TEST_IMAGES] = '{
		256'h0000_0000_0000_0000_0000_0000_0000_0001,
		256'h1111_0000_0000_0000_0000_0000_0000_0011,
		256'h1111_0000_0000_0000_0000_0000_0000_0111,
		256'h0000_1111_0000_0000_0000_0000_0000_1111,
		256'h0000_1111_0000_0000_0000_0000_0000_0000
	};

	// Testbench process
	initial begin
		// Initialize signals
		clk = 0;
		reset = 1;
		num_images = TEST_IMAGES;

		// Load test hashes
		for (int i = 0; i < TEST_IMAGES; i++) begin
			hashes[i] = test_hashes[i];
		end

		// Apply reset
		#10 reset = 0;

		// Wait for sorting to complete
		wait(reordered_indices[TEST_IMAGES-1] != 16'hFFFF);

		// Display results
		$display("Sorting complete. Reordered indices:");
		for (int i = 0; i < TEST_IMAGES; i++) begin
			$display("Index %0d: %0d", i, reordered_indices[i]);
		end

		// Verify sorting
		for (int i = 1; i < TEST_IMAGES; i++) begin
			automatic logic [255:0] prev_hash = hashes[reordered_indices[i-1]];
			automatic logic [255:0] curr_hash = hashes[reordered_indices[i]];
			automatic int prev_distance = $countones(prev_hash ^ hashes[0]);
			automatic int curr_distance = $countones(curr_hash ^ hashes[0]);
			
			assert(curr_distance >= prev_distance) else
				$error("Sorting error at index %0d: distance %0d should be >= previous distance %0d",
					   i, curr_distance, prev_distance);
		end

		$display("Testbench complete");
		$finish;
	end 
endmodule