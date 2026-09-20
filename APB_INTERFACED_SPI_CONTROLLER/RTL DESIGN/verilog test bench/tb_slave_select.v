`timescale 1ns/1ns

module slave_select_tb();
reg pclk,presetn,mstr_i,spiswai_i,send_data_i;
reg [11:0] baud_rate_divisor_i;
reg [1:0]spi_mode_i;
wire receive_data_o,ss_o,tip_o;

slave_select DUT(pclk,presetn,mstr_i,spiswai_i,spi_mode_i,send_data_i,baud_rate_divisor_i,receive_data_o,ss_o,tip_o);

parameter t=40;

initial
begin
	pclk=1'b0;
	forever #(t/2) pclk=~pclk;
end

task reset();
begin
	@(negedge pclk)
	presetn=1'b0;
	@(negedge pclk)
	presetn=1'b1;
end
endtask


task fixed();
	begin
		mstr_i=1'b1;
		spiswai_i=1'b0;
		spi_mode_i=2'b00;
	end
endtask

task data_send_signal();
	begin
		@(negedge pclk)
		send_data_i=1'b1;
		@(negedge pclk)
		send_data_i=1'b0;
	end
endtask

task baud();
	begin
		baud_rate_divisor_i=12'd4;
	end
endtask

initial
begin
	reset();
	baud();
	fixed();
	data_send_signal;
end
endmodule


