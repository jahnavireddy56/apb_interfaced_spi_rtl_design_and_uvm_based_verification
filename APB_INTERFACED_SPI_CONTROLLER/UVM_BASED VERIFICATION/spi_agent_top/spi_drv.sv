//spi driver class
 class spi_driver extends uvm_driver#(spi_transaction);
    //factory registration
    `uvm_component_utils(spi_driver)
     //virtual interface 
    virtual spi_if.mp_dr_spi vif;
    //apb config handle
    spi_agent_config spi_h;
    //to get cr1
    bit[7:0] CR1;
   //internals bits in a CR1
     bit cpol;
     bit cpha;
     bit lsbfe;

    //external methods
    extern function new (string name="spi_driver",uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern task send_to_dut(spi_transaction xtn);

 endclass:spi_driver
 //constructor new 
 function spi_driver::new (string name="spi_driver",uvm_component parent);
   super.new(name,parent);
 endfunction
//build_phase
 function void spi_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(spi_agent_config)::get(this,"","spi_agent_config",spi_h))
      `uvm_fatal(get_full_name(),"getting failed in a spi driver")
 endfunction

 //connect phase
  function void spi_driver::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif=spi_h.vif;
  endfunction
     
 
 
 //run_phase
   task spi_driver::run_phase(uvm_phase phase);
     forever
      begin
      seq_item_port.get_next_item(req);
      send_to_dut(req);
      seq_item_port.item_done();
      end
   endtask
 
 //send to dut task
  
 task spi_driver::send_to_dut(spi_transaction xtn);
 // uvm_config_db#(bit[31:0])::set(this,"env_h.spi_h.spi_agent_h[i].*","bit[31:0]",apb_xtn.pwdata);

  // if(!uvm_config_db#(bit[31:0])::get(this,"*","bit[31:0]",CR1))
    if(!uvm_config_db#(bit[7:0])::get(this,"*","bit[7:0]",CR1))
   
      `uvm_fatal(get_full_name,"get failed in a spi driver")
    `uvm_info(get_full_name(),$sformatf("cr1 data =%0b",CR1),UVM_LOW);

      cpol=CR1[3];
      cpha=CR1[2];
      lsbfe=CR1[0];
     //wait until slave select is low
      wait(!vif.cb_dr_spi.ss)
        if(!cpha)
         vif.cb_dr_spi.miso<=xtn.miso[lsbfe ? 0:7];
        for(int i=(cpha ? 0:1);i<8;i++)
         begin
          //if((cpha==0 && cpol==0) || (cpha==1 && cpol==1))
          if(cpha^cpol)
           @(posedge vif.cb_dr_spi.sclk);
          else
           @(negedge vif.cb_dr_spi.sclk);
         vif.cb_dr_spi.miso<=xtn.miso[lsbfe ?i:(7-i)];
        end
      //PRINTING TRASACTIONS AFTER THE DRIVING
       `uvm_info("driver",$sformatf("after driving trasactions %s",xtn.sprint()),UVM_MEDIUM )   
  /*	wait(!vif.cb_dr_spi.ss)
	//@(posedge vif.cb_dr_spi.sclk)
      
		begin
			if(lsbfe)
			begin
				if((!cpol)&&(!cpha))
				begin
					vif.cb_dr_spi.miso<=xtn.miso[0];
					for(int i=1;i<=7;i++)
					begin
						@(negedge vif.cb_dr_spi.sclk)
						vif.cb_dr_spi.miso<=xtn.miso[i];
	                                	//`uvm_info(get_type_name(),xtn.sprint,UVM_LOW)
                                                $display("######################SPI DRIVER#######################");
                                                $display("data of miso[%0d]=%b mosi[%0d]=%b ",i,xtn.miso[i],i,xtn.mosi[i]);

					end
				end
				else if((cpol)&&(!cpha))
				begin
					vif.cb_dr_spi.miso<=xtn.miso[0];
					for(int i=1;i<=7;i++)
					begin
						@(posedge vif.cb_dr_spi.sclk)
						vif.cb_dr_spi.miso<=xtn.miso[i];
					end
				end
				else if((!cpol)&&(cpha))
				begin
					for(int i=0;i<=7;i++)
					begin
						@(posedge vif.cb_dr_spi.sclk)
						vif.cb_dr_spi.miso<=xtn.miso[i];
					end
				end
				else
				begin
					for(int i=0;i<=7;i++)
					begin
						@(negedge vif.cb_dr_spi.sclk)
						vif.cb_dr_spi.miso<=xtn.miso[i];
					end
				end
			end

			else
			begin
				if((!cpol)&&(!cpha))
				begin
					vif.cb_dr_spi.miso<=xtn.miso[7];
					for(int i=6;i>=0;i--)
					begin
						@(negedge vif.cb_dr_spi.sclk)
						vif.cb_dr_spi.miso<=xtn.miso[i];
                                                $display("######################SPI DRIVER#######################");
                                                $display("data of miso[%0d]=%b mosi[%0d]=%b ",i,xtn.miso[i],i,xtn.mosi[i]);

					end
				end
				else if((cpol)&&(!cpha))
				begin
					vif.cb_dr_spi.miso<=xtn.miso[7];
					for(int i=6;i>=0;i--)
					begin
						@(posedge vif.cb_dr_spi.sclk)
						vif.cb_dr_spi.miso<=xtn.miso[i];
                                                $display("######################SPI DRIVER#######################");
                                                $display("data of miso[%0d]=%b mosi[%0d]=%b ",i,xtn.miso[i],i,xtn.mosi[i]);

					end
				end
				else if((!cpol)&&(cpha))
				begin
					for(int i=7;i>=0;i--)
					begin
						@(posedge vif.cb_dr_spi.sclk)
						vif.cb_dr_spi.miso<=xtn.miso[i];
                                                $display("######################SPI DRIVER#######################");
                                                $display("data of miso[%0d]=%b mosi[%0d]=%b ",i,xtn.miso[i],i,xtn.mosi[i]);

					end
				end
				else
				begin
					for(int i=7;i>=0;i--)
					begin
						@(negedge vif.cb_dr_spi.sclk)
						vif.cb_dr_spi.miso<=xtn.miso[i];
                                                $display("######################SPI DRIVER#######################");
                                                $display("data of miso[%0d]=%b mosi[%0d]=%b ",i,xtn.miso[i],i,xtn.mosi[i]);

					end
				end
			end
		end
		`uvm_info(get_type_name(),xtn.sprint,UVM_LOW)*/

 endtask

