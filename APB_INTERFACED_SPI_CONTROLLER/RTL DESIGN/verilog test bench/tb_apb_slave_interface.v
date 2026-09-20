`timescale 1ns/1ns

module APB_slave_interface_tb();
reg pclk,presetn,pwrite_i,psel_i,penable_i,ss_i,receive_data_i,tip_i;
reg [2:0]paddr_i;
reg [7:0]pwdata_i,miso_data_i;

wire mstr_o,cpol_o,cpha_o,lsbfe_o,spiswai_o,pready_o,pslverr_o;
wire send_data_o,spi_interrupt_request_o;
wire  [1:0] spi_mode_o;
wire [7:0] prdata_o,mosi_data_o;
wire [2:0] sppr_o,spr_o;

parameter t=40;



APB_slave_interface DUT(pclk,presetn,paddr_i,pwrite_i,psel_i,penable_i,pwdata_i,ss_i,miso_data_i,receive_data_i,tip_i,prdata_o,mstr_o,cpol_o,cpha_o,lsbfe_o,spiswai_o,sppr_o,spr_o,spi_interrupt_request_o,pready_o,pslverr_o,send_data_o,mosi_data_o,spi_mode_o);

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

initial
begin
	presetn=1'b0;
	pwrite_i=1'b0;
	psel_i=1'b0;
	penable_i=1'b0;
	ss_i=1'b0;
	receive_data_i=1'b0;
	tip_i=1'b1;
end
	
task APB_config_write(input [2:0] addr,input [7:0] data);
	begin
		@(negedge pclk)
			psel_i=1'b1;
			penable_i=1'b0;
			paddr_i=addr;
			pwdata_i=data;
			pwrite_i=1'b1;
		@(negedge pclk)
			penable_i=1'b1;
		@(negedge pclk)
			psel_i=1'b0;
			penable_i=1'b0;
	end
endtask


task APB_config_read(input [2:0] rd_addr);
	begin
		@(negedge pclk)
			psel_i=1'b1;
			penable_i=1'b0;
			paddr_i=rd_addr;
			pwrite_i=1'b0;
		@(negedge pclk)
			penable_i=1'b1;
		@(negedge pclk)
			psel_i=1'b0;
			penable_i=1'b0;
	end
endtask

task APB_config_miso_data(input [7:0]miso_data);
	begin
		@(negedge pclk)
			psel_i=1'b1;
			penable_i=1'b0;
			paddr_i=3'b101;
			pwrite_i=1'b0;
			miso_data_i=miso_data;
			receive_data_i=1'b1;
		@(negedge pclk)
			penable_i=1'b1;
		@(negedge pclk)
			psel_i=1'b0;
			penable_i=1'b0;
	end
endtask

initial
	begin
		reset();
		APB_config_write(3'b000,8'd9); //cr1
		#100;
		APB_config_write(3'b001,8'd15);//cr2
		#100;
		APB_config_write(3'b010,8'd9);//br
		#100;
		APB_config_write(3'b101,8'd17);//dr
		#100;
		APB_config_read(3'b000);//read cr1
		#100;
		APB_config_read(3'b001);//readcr2
		#100;
		APB_config_read(3'b010);//read br
		#100;
		APB_config_read(3'b101);//rd dr
		#100;
		APB_config_read(3'b011);//rd sr
		#100
		APB_config_miso_data(8'b10101010);

	end	
endmodule


