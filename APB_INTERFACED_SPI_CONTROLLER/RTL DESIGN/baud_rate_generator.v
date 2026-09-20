module serial_clock_generator( pclk,presetn,spi_mode_i,spiswai_i,sppr_i,spr_i,cpol_i,cpha_i,ss_i,sclk_o,miso_receive_sclk_o,miso_receive_sclk0_o,mosi_send_sclk_o,mosi_send_sclk0_o,baud_rate_divisor_o);
input pclk,presetn,spiswai_i,cpol_i,cpha_i,ss_i;
input [1:0]spi_mode_i;
input [2:0] sppr_i,spr_i;

output reg sclk_o;
output reg miso_receive_sclk_o,miso_receive_sclk0_o,mosi_send_sclk_o,mosi_send_sclk0_o;
output [11:0] baud_rate_divisor_o;
reg pre_sclk;
reg [11:0] count;

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
		mosi_send_sclk_o<=0;
		mosi_send_sclk0_o<=0;
	end
	else
	begin
		if((cpha_i ==1'b0 && cpol_i==1'b0) ||(cpha_i==1'b1 && cpol_i==1'b1))
		begin
			if(!sclk_o)
			begin
				if(count==(((baud_rate_divisor_o)/2)-2))
					mosi_send_sclk_o<=1'b1;
				else
					mosi_send_sclk_o<=1'b0;
			end
			else
				mosi_send_sclk_o<=1'b0;
		end
		else
		begin
			if(sclk_o)
			begin
				if(count==(((baud_rate_divisor_o)/2)-2))
					mosi_send_sclk0_o<=1'b1;
				else
					mosi_send_sclk0_o<=1'b0;
			end
			else
				mosi_send_sclk0_o<=1'b0;
		end
	end
end


//miso_receive_sclk_o

always@(posedge pclk or negedge presetn)
begin
	if(!presetn)
	begin
		miso_receive_sclk_o<=0;
		miso_receive_sclk0_o<=0;
	end
		
	else
	begin
		if((cpha_i ==1'b0 && cpol_i==1'b0) ||(cpha_i==1'b1 && cpol_i==1'b1))
		begin
			if(!sclk_o)
			begin
				if(count==(((baud_rate_divisor_o)/2)-1))
					miso_receive_sclk_o<=1'b1;
				else
					miso_receive_sclk_o<=1'b0;
			end
			else
				miso_receive_sclk_o<=1'b0;
		end
		else
		begin
			if(sclk_o)
			begin
				if(count==(((baud_rate_divisor_o)/2)-1))
					miso_receive_sclk0_o<=1'b1;
				else
					miso_receive_sclk0_o<=1'b0;
			end
			else
				miso_receive_sclk0_o<=1'b0;
		end
	end
end


endmodule



