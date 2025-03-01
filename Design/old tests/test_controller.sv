/*------------------------------------------------------------------------------
 * File          : test_controller.sv
 * Project       : RTL
 * Author        : epnsrc
 * Creation date : Dec 7, 2024
 * Description   :
 *------------------------------------------------------------------------------*/

`timescale 1ns/100fs

module controller_tb;

	// Testbench signals
	logic clk;
	logic reset;
	logic start;
	logic image_buffer_valid;
	logic hash_calc_done;
	logic send_next_image;
	logic finish_reordering;  // Input for the finish reordering signal
	logic [15:0] num_images;
	logic hash_start;
	logic reorder_start;

	// Instantiate the controller
	controller uut (
		.clk(clk),
		.reset(reset),
		.start(start),
		.image_buffer_valid(image_buffer_valid),
		.num_images(num_images),
		.hash_calc_done(hash_calc_done),
		.send_next_image(send_next_image),
		.finish_reordering(finish_reordering),
		.hash_start(hash_start),
		.reorder_start(reorder_start)
	);

	// Clock generation
	initial begin
		clk = 0;
		forever #5 clk = ~clk; // 10ns clock period
	end

	// Test scenario
	initial begin
		// Initialize signals
		reset = 1;
		start = 0;
		image_buffer_valid = 0;
		hash_calc_done = 0;
		send_next_image = 0;
		finish_reordering = 0;
		num_images = 3; // Set the number of images for the test

		// Release reset
		#15 reset = 0;

		// Start the process
		#10 start = 1;
		#10 start = 0;

		// Simulate image buffering for the first image
		@(posedge clk);
		#5 image_buffer_valid = 1;
		@(posedge clk);
		#5 image_buffer_valid = 0;

		// Simulate hash calculation for the first image
		@(posedge clk);
		#5 hash_calc_done = 1;
		@(posedge clk);
		#5 hash_calc_done = 0;

		// Simulate image buffering for the second image
		@(posedge clk);
		#5 image_buffer_valid = 1;
		@(posedge clk);
		#5 image_buffer_valid = 0;

		// Simulate hash calculation for the second image
		@(posedge clk);
		#5 hash_calc_done = 1;
		@(posedge clk);
		#5 hash_calc_done = 0;
		
		// Simulate image buffering for the second image
		@(posedge clk);
		#5 image_buffer_valid = 1;
		@(posedge clk);
		#5 image_buffer_valid = 0;

		// Simulate hash calculation for the second image
		@(posedge clk);
		#5 hash_calc_done = 1;
		@(posedge clk);
		#5 hash_calc_done = 0;

		// Simulate the reordering process
		@(posedge clk);
		#5 finish_reordering = 0;
		#20 finish_reordering = 1;
		@(posedge clk);
		#5 finish_reordering = 0;

		// End simulation
		#100 $stop;
	end

	// Monitor signals
	initial begin
		$monitor($time,
				 " Reset=%b, Start=%b, Image_Buffer_Valid=%b, Hash_Calc_Done=%b, Send_Next_Image=%b, Finish_Reordering=%b | Hash_Start=%b, Reorder_Start=%b, Current_State=%b",
				 reset, start, image_buffer_valid, hash_calc_done, send_next_image, finish_reordering,
				 hash_start, reorder_start, uut.current_state);
	end

endmodule
