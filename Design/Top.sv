/*------------------------------------------------------------------------------
 * File          : Top.sv
 * Project       : RTL
 * Author        : epnsrc
 * Creation date : Dec 14, 2024
 * Description   :
 *------------------------------------------------------------------------------*/

`timescale 1ns/1ns

module top (
	input logic clk,
	input logic reset,
	input logic [7:0] pixel_data,
	input logic pixel_valid,
	input logic start,
	input logic [8:0] num_images,
	input logic [8:0] image_header,
	output logic image_buffer_valid,
	output logic hash_calc_done,
	output logic finish_reordering,
	output logic [8:0] temp_new_reference,
	output logic new_reference_is_done,
	output logic [8:0] last_image,
	output logic [8:0] count_image
);

	// Intermediate signals
	logic hash_start;
	logic [15:0] sum;
	logic reorder_start;

	// Memory interface signals
	logic [31:0] O1, O2;
	logic [31:0] I1, I2;
	logic [11:0] A1, A2;
	logic WEB1, WEB2;
	logic [31:0] buffer_I1, buffer_I2; 
	logic [11:0] buffer_A1, buffer_A2; 
	logic buffer_WEB1, buffer_WEB2; 
	logic [31:0] hash_O2; 
	logic [11:0] hash_A1, hash_A2; 
	logic [31:0] hash_I1; 
	logic hash_WEB1, hash_WEB2;   
	logic [31:0] reorder_O1, reorder_O2; 
	logic [11:0] reorder_A1, reorder_A2; 
	logic reorder_WEB1, reorder_WEB2;   
	logic OEB1, OEB2;
	logic CSB1, CSB2;

	
	// Instantiate `image_buffer`
	image_buffer u_image_buffer (
		.clk(clk),
		.reset(reset),
		.pixel_data(pixel_data),
		.pixel_valid(pixel_valid),
		.image_buffer_valid(image_buffer_valid),
		.sum(sum),
		.buffer_I1(buffer_I1),
		.buffer_A1(buffer_A1),
		.buffer_WEB1(buffer_WEB1)
	);

	// Instantiate `hash_calc`
	hash_calc u_hash_calc (
		.clk(clk),
		.reset(reset),
		.image_header(image_header),    
		.sum(sum),
		.hash_start(hash_start),
		.hash_calc_done(hash_calc_done),  
		.hash_A1(hash_A1),
		.hash_A2(hash_A2),
		.hash_O2(O2),
		.hash_I1(hash_I1),
		.hash_WEB1(hash_WEB1),
		.hash_WEB2(hash_WEB2)
	);
	
	// Instantiate `reordering`
	reordering u_reordering (
		.clk(clk),
		.reset(reset),
		.num_images(num_images),
		.finish_reordering(finish_reordering),
		.temp_new_reference(temp_new_reference),
		.count_image(count_image),
		.last_image(last_image),
		.new_reference_is_done(new_reference_is_done),
		.reorder_start(reorder_start),
		.reorder_A1(reorder_A1),
		.reorder_A2(reorder_A2),
		.reorder_O1(O1),
		.reorder_O2(O2),
		.reorder_WEB1(reorder_WEB1),
		.reorder_WEB2(reorder_WEB2)
	);

	// Instantiate `controller`
	controller u_controller (
		.clk(clk),
		.reset(reset),
		.start(start),
		.image_buffer_valid(image_buffer_valid),
		.num_images(num_images),
		.finish_reordering(finish_reordering),
		.hash_calc_done(hash_calc_done),
		.hash_start(hash_start),
		.reorder_start(reorder_start),
		.controller_I1(I1),
		.controller_I2(I2),
		.controller_A1(A1),
		.controller_A2(A2),
		.controller_WEB1(WEB1),
		.controller_WEB2(WEB2),
		.controller_CSB1(CSB1),
		.controller_CSB2(CSB2),
		.controller_OEB1(OEB1),
		.controller_OEB2(OEB2),
		.buffer_I1(buffer_I1),
		.buffer_A1(buffer_A1),
		.buffer_WEB1(buffer_WEB1),
		.hash_A1(hash_A1),
		.hash_A2(hash_A2),
		.hash_I1(hash_I1),
		.hash_WEB1(hash_WEB1),
		.hash_WEB2(hash_WEB2),
		.reorder_A1(reorder_A1),
		.reorder_A2(reorder_A2),
		.reorder_WEB1(reorder_WEB1),
		.reorder_WEB2(reorder_WEB2)
	);

	dpram4096x32_CB RAM_U1(
		.A1(A1), .I1(I1), .O1(O1), .CEB1(clk), .WEB1(WEB1), .OEB1(OEB1), .CSB1(CSB1),
		.A2(A2), .I2(I2), .O2(O2), .CEB2(clk), .WEB2(WEB2), .OEB2(OEB2), .CSB2(CSB2)
	);
	
endmodule
