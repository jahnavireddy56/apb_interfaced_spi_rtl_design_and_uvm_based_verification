module shift_register(pclk,presetn,ss_i,send_data_i,lsbfe_i,cpha_i,cpol_i,miso_receive_sclk_i,miso_receive_sclk0_i,mosi_send_sclk_i,mosi_send_sclk0_i,data_mosi_i,miso_i,receive_data_i,mosi_o,data_miso_o);
input pclk,presetn,ss_i,send_data_i,lsbfe_i,cpha_i,cpol_i,miso_receive_sclk_i,miso_receive_sclk0_i,mosi_send_sclk_i,mosi_send_sclk0_i,miso_i,receive_data_i;
input [7:0] data_mosi_i;
output reg mosi_o;
output reg [7:0]data_miso_o;

reg [7:0]temp_reg;
reg [7:0]shift_register;
reg [2:0]count1,count2,count3,count;

//shift register logic


always@(posedge pclk or negedge presetn)
begin
	if(!presetn)
		shift_register<=8'b0;
	else if(send_data_i)
		shift_register<=data_mosi_i;
	else
		shift_register<=shift_register;
end

always@(*)
begin
	if(receive_data_i)
		data_miso_o=temp_reg;
	else
		data_miso_o=8'h0;
end


//parallel to serial conversion the data is already available in shift register we need to convert this parallel data to serial to comunnicate with peripherals

always@(posedge pclk or negedge presetn)
begin
	if(!presetn)
	begin
		mosi_o<=1'b0;
		count<=3'd0;
		count1<=3'd7;
	end
	else
		begin
			if(ss_i)
			begin
				mosi_o<=mosi_o;
				count<=count;
				count1<=count1;
		       end
		        else
			begin
				if((cpha_i==1'b0 && cpol_i==1'b1) || (cpha_i==1'b1 && cpol_i==1'b0))
				begin
					if(lsbfe_i)
					begin
						if(count<=3'd7)
						begin
							if(mosi_send_sclk0_i)
							begin
								mosi_o<=shift_register[count];
								count<=count+1;
							end
							else
								mosi_o<=mosi_o;
						end
						else
							mosi_o<=3'd0;
					end

					else
						begin
							if(count1>=3'd0)
							begin
								if(mosi_send_sclk0_i)
								begin
									mosi_o<=shift_register[count1];
									count1<=count1-1;
								end
								else
									mosi_o<=mosi_o;

							end
							else
								mosi_o<=3'd7;
						end
				end

				else
				begin
					if(lsbfe_i)
					begin
						if(count<=3'd7)
						begin
							if(mosi_send_sclk_i)
							begin
								mosi_o<=shift_register[count];
								count<=count+1;
							end
						        else
								mosi_o<=mosi_o;
						end
						else
							mosi_o<=3'd0;
					end
						else
						begin
							if(count1>=3'd0)
							begin
								if(mosi_send_sclk_i)
								begin
									mosi_o<=shift_register[count1];
									count1<=count1-1;
								end
								else
								mosi_o<=mosi_o;
							end
							 else
								 mosi_o<=3'd7;
						end
			      end
		end
	end
end



//serial to parallel conversion

always@(posedge pclk or negedge presetn)
	begin
		if(!presetn)
			begin
				temp_reg[count2]<=8'b0;
				temp_reg[count3]<=8'b0;
				count2<=3'd0;
				count3<=3'd7;
				temp_reg<=8'b0;
			end
			else
				begin
					if(ss_i)
						begin
							temp_reg[count2]<=temp_reg[count2];
							temp_reg[count3]<=temp_reg[count3];
							count2<=count2;
							count3<=count3;
						end
						else
							begin
								if((cpha_i==0 && cpol_i==1) || (cpha_i==1 && cpol_i==0))
								begin
									if(lsbfe_i)
										begin
											if(count2<=3'd7)
												begin
													if(miso_receive_sclk0_i)
													begin
														temp_reg[count2]<=miso_i;
														count2<=count2+1;
													end
													else
														temp_reg[count2]<=temp_reg[count2];
												end
											else
												temp_reg[count2]<=3'd0;
										end
									else
									begin
										if(count3>=3'd0)
										begin
											if(miso_receive_sclk0_i)
											begin
												temp_reg[count3]<=miso_i;
												count3<=count3-1;
											end
											else
												temp_reg[count3]<=temp_reg[count3];
										end
										else
											temp_reg[count3]<=3'd7;
									end
								end

								else
								begin
										if(lsbfe_i)
										begin
											if(count2<=3'd7)
												begin
													if(miso_receive_sclk_i)
													begin
														temp_reg[count2]<=miso_i;
														count2<=count2+1;
													end
													else
														temp_reg[count2]<=temp_reg[count2];
												end
											else
												temp_reg[count2]<=3'd0;
										end
									else
									begin
										if(count3>=3'd0)
										begin
											if(miso_receive_sclk_i)
											begin
												temp_reg[count3]<=miso_i;
												count3<=count3-1;
											end
											else
												temp_reg[count3]<=temp_reg[count3];
										end
										else
											temp_reg[count3]<=3'd7;
									end
								end
				end
			end
	 end


endmodule

