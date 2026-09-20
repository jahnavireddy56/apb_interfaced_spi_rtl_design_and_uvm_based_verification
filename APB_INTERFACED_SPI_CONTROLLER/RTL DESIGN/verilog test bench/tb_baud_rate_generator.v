`timescale 1ns/1ns
module serial_clock_generator_tb();

reg pclk,presetn,spiswai_i,cpol_i,cpha_i,ss_i;
reg [1:0]spi_mode_i;
reg [2:0] sppr_i,spr_i;
wire sclk_o,miso_receive_sclk_o,miso_receive_sclk0_o,mosi_send_sclk,mosi_send_sclk0_o;
wire [11:0] baud_rate_divisor_o;

parameter t=40;
serial_clock_generator DUT ( pclk,presetn,spi_mode_i,spiswai_i,sppr_i,spr_i,cpol_i,cpha_i,ss_i,sclk_o,miso_receive_sclk_o,miso_receive_sclk0_o,mosi_send_sclk,mosi_send_sclk0_o,baud_rate_divisor_o);

initial
begin
	pclk=1'b0;
	forever #(t/2) pclk=~pclk;
end

task resetn();
begin
	@(negedge pclk)
	presetn=1'b0;
	@(negedge pclk)
	presetn=1'b1;
end
endtask

task fixed_stimulus(input spiswai_i1,ss_i1,input [1:0]spi_mode_i1);
	begin
		spiswai_i=spiswai_i1;
		ss_i=ss_i1;
		spi_mode_i=spi_mode_i1;
	end
endtask

task variable_stimulus(input [2:0] sppr_i1,spr_i1, input cpol_i1,cpha_i1);
	begin
		sppr_i=sppr_i1;
		spr_i=spr_i1;
		cpol_i=cpol_i1;
		cpha_i=cpha_i1;
	end
endtask


initial
fork
	resetn();
	fixed_stimulus(1'b0,1'b0,2'b00);
	variable_stimulus(3'b000,3'b010,0,1);
	#500
	variable_stimulus(3'b000,3'b010,0,0);
join

endmodule


