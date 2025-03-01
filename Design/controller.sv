/*------------------------------------------------------------------------------
 * File          : controller.sv
 * Project       : RTL
 * Author        : epnsrc
 * Creation date : Dec 7, 2024
 * Description   :
 *------------------------------------------------------------------------------*/

`timescale 1ns/1ns

module controller (
	input logic clk,
	input logic reset,
	input logic start,
	input logic image_buffer_valid,
	input logic [8:0] num_images,
	input logic finish_reordering,
	input logic hash_calc_done,
	input logic [11:0] buffer_A1,                      // buffer address
	input logic [31:0] buffer_I1,                      // buffer data inputs
	input logic buffer_WEB1,                           // buffer Read/Write enable
	input logic [11:0] hash_A1, hash_A2,               // hash addresses
	input logic [31:0] hash_I1,                        // hash data inputs
	input logic hash_WEB1, hash_WEB2 ,                 // hash Read/Write enable
	input logic [11:0] reorder_A1, reorder_A2,         // reorder addresses
	input logic reorder_WEB1, reorder_WEB2,            // reorder Read/Write enable
	output logic [11:0] controller_A1, controller_A2,  // controller addresses
	output logic [31:0] controller_I1, controller_I2,  // controller data inputs
	output logic controller_WEB1, controller_WEB2,     // controller Read/Write enable
	output logic controller_OEB1, controller_OEB2,
	output logic controller_CSB1, controller_CSB2,
	output logic hash_start,
	output logic reorder_start
);
	typedef enum logic [1:0] {
		IDLE,
		BUFFERING,
		HASH_CALC,
		REORDER
	} state_t;
	state_t current_state, next_state;

	logic [8:0] current_image;  
	logic [8:0] next_image;    

	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= IDLE;
			current_image <= 0;
		end else begin
			current_state <= next_state;
			current_image <= next_image;
		end
	end

	always_comb begin
		// Default values
		controller_OEB1 = 0;
		controller_OEB2 = 0;
		controller_CSB1 = 0;
		controller_CSB2 = 0;
		
		case (current_state)
			IDLE: begin
				controller_WEB1 = 0;
				controller_WEB2 = 1;
				controller_I1 = 32'(0);
				controller_I2 = 32'(0);
				controller_A1 = 12'(0);
				controller_A2 = 12'(0);
				hash_start = 0;
				reorder_start = 0;
				next_image = current_image;
				if (start) begin
					next_state = BUFFERING;
				end else begin 
					next_state = current_state;
				end
			end
			BUFFERING: begin
				hash_start = 0;
				controller_WEB1 = buffer_WEB1;
				controller_WEB2 = 1;
				controller_I1 = buffer_I1;
				controller_I2 = 32'(0);
				controller_A1 = buffer_A1;
				controller_A2 = 12'(0);
				reorder_start = 0;
				if (image_buffer_valid && !hash_calc_done) begin
					next_image = current_image;
					next_state = HASH_CALC;
				end
			end
			HASH_CALC: begin
				hash_start = 1;
				controller_WEB1 = hash_WEB1;
				controller_WEB2 = hash_WEB2;
				controller_A1 = hash_A1;
				controller_A2 = hash_A2;
				controller_I1 = hash_I1;
				controller_I2 = 32'(0);
				reorder_start = 0;
				if (hash_calc_done && current_image<num_images-1) begin
					next_image = current_image + 1;
					next_state = BUFFERING; 
				end else if (hash_calc_done && current_image==num_images-1) begin
					next_state = REORDER;
					next_image = current_image;
				end else begin
					next_state = current_state;
					next_image = current_image;
				end
			end
			REORDER: begin
				hash_start = 0;
				reorder_start = 1;
				controller_WEB1 = reorder_WEB1;
				controller_WEB2 = reorder_WEB2;
				controller_A1 = reorder_A1;
				controller_A2 = reorder_A2;
				controller_I1 = 32'(0);
				controller_I2 = 32'(0);
				if (finish_reordering) begin
					next_state = IDLE; 
					next_image = current_image;
				end else begin
					next_state = current_state;
					next_image = current_image;
				end
			end
			default: begin
					next_state = current_state;
					next_image = current_image;
					controller_WEB1 = 0;
					controller_WEB2 = 1;
					controller_I1 = 32'(0);
					controller_I2 = 32'(0);
					controller_A1 = 12'(0);
					controller_A2 = 12'(0);
					hash_start = 0;
					reorder_start = 0;
			end 
		endcase
	end
endmodule