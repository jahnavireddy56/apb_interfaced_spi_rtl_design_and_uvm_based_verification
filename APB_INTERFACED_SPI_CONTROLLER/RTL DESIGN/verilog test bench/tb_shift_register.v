`timescale 1ns/1ns
module shift_register_tb();

reg pclk,presetn,ss_i,send_data_i,lsbfe_i,cpha_i,cpol_i,miso_receive_sclk_i,miso_receive_sclk0_i,mosi_send_sclk_i,mosi_send_sclk0_i,miso_i,receive_data_i;
reg [7:0] data_mosi_i;
wire mosi_o;
wire [7:0]data_miso_o;
reg spiswai_i;
reg [1:0]spi_mode_i;
reg [2:0] sppr_i,spr_i;

reg sclk_o;
wire [11:0] baud_rate_divisor_o;
reg [11:0]count;
reg pre_sclk;


shift_register DUT(pclk,presetn,ss_i,send_data_i,lsbfe_i,cpha_i,cpol_i,miso_receive_sclk_i,miso_receive_sclk0_i,mosi_send_sclk_i,mosi_send_sclk0_i,data_mosi_i,miso_i,receive_data_i,mosi_o,data_miso_o);



parameter t=40;
initial
begin
	pclk=1'b0;
	forever #(t/2) pclk=~pclk;
end

initial
	begin
		variable_stimulus(3'b00,3'b001,1'b0,1'b1,1'b0);
		@(negedge pclk)
		presetn=1'b0;
		@(negedge pclk)
		presetn=1'b1;
	end

task send_data();
	begin
		@(negedge pclk)
		send_data_i=1'b1;
		@(negedge pclk)
		send_data_i=1'b0;
	end
endtask

task variable_stimulus(input [2:0] sppr_i1,spr_i1, input cpol_i1,cpha_i1,lsbfe_i1);
	begin
		sppr_i=sppr_i1;
		spr_i=spr_i1;
		cpol_i=cpol_i1;
		cpha_i=cpha_i1;
		lsbfe_i=lsbfe_i1;
	end
endtask

task data(input [7:0]j);
	begin
		@(negedge pclk)
		data_mosi_i=j;
	end
endtask

task receive();
	begin
		@(negedge pclk)
		receive_data_i=1'b1;
		@(negedge pclk)
		receive_data_i=1'b0;
	end
endtask

task fixed_stimulus();
	begin
		spiswai_i=1'b0;
		ss_i=1'b0;
		spi_mode_i=2'b00;
	end
endtask

task serial_input(input s);
begin
	@(negedge sclk_o)
	miso_i=s;
end
endtask



initial
begin
	fixed_stimulus();
	data(8'd57);
	#100;
	send_data();
end

initial
begin
	serial_input(1'b1);
	serial_input(1'b0);
	serial_input(1'b1);
	serial_input(1'b0);
	serial_input(1'b1);
	serial_input(1'b0);
	serial_input(1'b1);
	serial_input(1'b0);
	receive();
end






//serial clk generation

always@(posedge pclk or negedge presetn)
begin
	if(!presetn)
		sclk_o<=pre_sclk;
	else
		begin
			if(((spi_mode_i==2'b00)|| (spi_mode_i==2'b01)) && (ss_i==1'b0) && (spiswai_i==1'b0))
				begin
					if(count==(((baud_rate_divisor_o)/2)-1))
						sclk_o<=~sclk_o;
					else
						sclk_o<=sclk_o;
				end
			else
				sclk_o<=pre_sclk;
		end
end

always@(posedge pclk or negedge presetn)
begin
	if(!presetn)
		count<=12'b0;
	else
	begin
		if(((spi_mode_i==2'b00)|| (spi_mode_i==2'b01)) && (ss_i==1'b0) && (spiswai_i==1'b0))
		begin
			if(count==(((baud_rate_divisor_o)/2)-1))
				count<=12'b0;
			else
				count<=count+1;
		end
		else
			count<=12'b0;
	end
end

always@(*)
begin
	if(cpol_i)
		pre_sclk=1'b1;
	else
		pre_sclk=1'b0;
end

assign baud_rate_divisor_o=((sppr_i+1)*(2**(spr_i+1)));




//flags logic

//MOSI send clk and mosi send sclk0
always@(posedge pclk or negedge presetn)
begin
	if(!presetn)
	begin
		mosi_send_sclk_i<=0;
		mosi_send_sclk0_i<=0;
	end
	else
	begin
		if((cpha_i ==1'b0 && cpol_i==1'b0) ||(cpha_i==1'b1 && cpol_i==1'b1))
		begin
			if(!sclk_o)
			begin
				if(count==(((baud_rate_divisor_o)/2)-2))
					mosi_send_sclk_i<=1'b1;
				else
					mosi_send_sclk_i<=1'b0;
			end
			else
				mosi_send_sclk_i=1'b0;
		end
		else
		begin
			if(sclk_o)
			begin
				if(count==(((baud_rate_divisor_o)/2)-2))
					mosi_send_sclk0_i=1'b1;
				else
					mosi_send_sclk0_i=1'b0;
			end
			else
				mosi_send_sclk0_i=1'b0;
		end
	end
end

//miso_receive_sclk_i sclk0_i

always@(posedge pclk or negedge presetn)
begin
	if(!presetn)
	begin
		miso_receive_sclk_i<=0;
		miso_receive_sclk_i<=0;
	end
		
	else
	begin
		if((cpha_i ==1'b0 && cpol_i==1'b0) ||(cpha_i==1'b1 && cpol_i==1'b1))
		begin
			if(!sclk_o)
			begin
				if(count==(((baud_rate_divisor_o)/2)-1))
					miso_receive_sclk_i<=1'b1;
				else
					miso_receive_sclk_i<=1'b0;
			end
			else
				miso_receive_sclk_i<=1'b0;
		end
		else
		begin
			if(sclk_o)
			begin
				if(count==(((baud_rate_divisor_o)/2)-1))
					miso_receive_sclk0_i<=1'b1;
				else
					miso_receive_sclk0_i<=1'b0;
			end
			else
				miso_receive_sclk0_i<=1'b0;
		end
	end
end

endmodule

