/*------------------------------------------------------------------------------
 * File          : test_hash.sv
 * Project       : RTL
 * Author        : epnsrc
 * Creation date : Aug 7, 2024
 * Description   :
 *------------------------------------------------------------------------------*/
`timescale 1ns/100fs

module test_hash;

// Clock and reset signals
logic clk;
logic reset;

// Inputs to the hash_calc module
logic [7:0] image_buffer [0:255];
logic [15:0] image_header;
logic image_buffer_valid;
logic [15:0] num_images;

// Outputs from the hash_calc module
logic [255:0] hash_value;
logic [15:0] image_index_output;
logic hash_calc_done;

// Instantiate the hash_calc module
hash_calc uut (
	.clk(clk),
	.reset(reset),
	.image_buffer(image_buffer),
	.image_header(image_header),
	.image_buffer_valid(image_buffer_valid),
	.hash_value(hash_value),
	.image_index_output(image_index_output),
	.num_images(num_images),
	.hash_calc_done(hash_calc_done)
);


// Clock generation
always #5 clk = ~clk;

// Task to initialize inputs
task init_inputs;
	int i;
	begin
		for (i = 0; i < 256; i++) begin
			image_buffer[i] = $urandom_range(0, 255);
		end
		image_header = $urandom_range(0, 65535);
		num_images = $urandom_range(1, 100);
		image_buffer_valid = 0;
	end
endtask

// Task to reset the design
task reset_dut;
	begin
		reset = 1;
		#10;
		reset = 0;
		#10;
	end
endtask

// Test procedure
initial begin
	$display("Starting the test...");

	// Initialize the clock and inputs
	clk = 0;
	init_inputs();

	// Apply reset
	reset_dut();

	// Apply test vectors
	image_buffer_valid = 1;
	#10;
	image_buffer_valid = 0;

	// Wait for the hash calculation to complete
	wait(hash_calc_done);

	// Check the results
	for (int j = 0; j < 256; j++) begin
		$display("image_buffer[%0d]: %0d", j, image_buffer[j]);
	end
	$display("Hash Value: %b", hash_value);
	$display("Image Index Output: %h", image_index_output);
	$display("Hash Calc Done: %0d", hash_calc_done);

	// End simulation
	$finish;
end

endmodule