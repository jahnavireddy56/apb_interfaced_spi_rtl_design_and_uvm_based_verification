//spi monitor class
 class spi_monitor extends uvm_monitor;
    //factory registration
    `uvm_component_utils(spi_monitor)
     //analysis port handle for the sb connection
    uvm_analysis_port#(spi_transaction) m_ap;
    //virtual interface
    virtual spi_if.mp_mon_spi vif;
    //spi congih nadle diclaration
    spi_agent_config spi_h;   
    //CR1 REGISTER
    bit [7:0] CR1; 
    //internals bits in a CR1
     bit cpol;
     bit cpha;
     bit lsbfe;
     int idx;

    apb_transaction apb_xtn;
    spi_transaction spi_xtn;
     
    //external methods
    extern function new (string name="spi_monitor",uvm_component parent);
    extern function void build_phase(uvm_phase phase);    
    extern function void connect_phase(uvm_phase phase);
    extern task collect_data(spi_transaction xtn);
    extern task run_phase(uvm_phase phase);

 endclass:spi_monitor
  //constructor new
 function spi_monitor::new (string name="spi_monitor",uvm_component parent);
   super.new(name,parent);
   m_ap=new("m_ap",this);
 endfunction

 //build_phase
  function void spi_monitor::build_phase(uvm_phase phase);    
    super.build_phase(phase);
    if(!uvm_config_db#(spi_agent_config)::get(this,"","spi_agent_config",spi_h))
      `uvm_fatal(get_full_name(),"getting failed in a spi monitor")
  endfunction

 //connect_phase
  function void spi_monitor::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif=spi_h.vif;
  endfunction
  
//run_phase
  task spi_monitor::run_phase(uvm_phase phase);
    super.run_phase(phase);
    //spi_transaction spi_xtn;
    spi_xtn=spi_transaction::type_id::create("spi_xtn");
    forever
     begin
       collect_data(spi_xtn);
     end
  endtask

 //collect data
 task spi_monitor::collect_data(spi_transaction xtn);
 
    if(!uvm_config_db#(bit[7:0])::get(this,"*","bit[7:0]",CR1))
    
      `uvm_fatal(get_full_name(),"get failed in a spi monitor")
    `uvm_info(get_full_name(),$sformatf("cr1 data =%0b",CR1),UVM_HIGH);
      //CR1 = apb_xtn.pwdata;
      cpol=CR1[3];
      cpha=CR1[2];
      lsbfe=CR1[0];
    // int idx;
  wait(!vif.cb_mon_spi.ss)
     for (int i=0;i<8;i++)
     begin
      idx=lsbfe? i:(7-i);
	if(cpha^cpol)
           @(negedge vif.cb_mon_spi.sclk);
          else
           @(posedge vif.cb_mon_spi.sclk);
     xtn.miso[idx]=vif.cb_mon_spi.miso;
     xtn.mosi[idx]=vif.cb_mon_spi.mosi;
    xtn.ss=vif.cb_mon_spi.ss;
   //printing trasactions  
     `uvm_info("monitor",$sformatf("data from SPI Monitor %s",xtn.sprint()),UVM_MEDIUM)
     
    end
   //write method to a analysis port
   m_ap.write(xtn);
  
 //@(vif.cb_mon_spi);
 /*		wait(!vif.cb_mon_spi.ss)
		begin
			if(lsbfe)
			begin
				for(int i=0;i<=7;i++)
				begin
					if(((!cpol)&&(!cpha))||((cpol)&&(cpha)))
					begin
						@(posedge vif.cb_mon_spi.sclk)
						xtn.miso[i]=vif.cb_mon_spi.miso;
						xtn.mosi[i]=vif.cb_mon_spi.mosi;
						xtn.sclk=vif.cb_mon_spi.sclk;
						xtn.spi_interrupt_error=vif.cb_mon_spi.spi_interrupt_error;
                                                                                              

					end
					else
					begin
						@(negedge vif.cb_mon_spi.sclk)

						xtn.miso[i]=vif.cb_mon_spi.miso;
						xtn.mosi[i]=vif.cb_mon_spi.mosi;
						xtn.sclk=vif.cb_mon_spi.sclk;
						xtn.spi_interrupt_error=vif.cb_mon_spi.spi_interrupt_error;

					end
                                      $display("************************************************************");
                                      $display("data of miso[%0d]=%b mosi[%0d]=%b ",i,xtn.miso[i],i,xtn.mosi[i]);
 	                             `uvm_info("SPI Monitor",xtn.sprint,UVM_MEDIUM)

				end
                              
			end
			else
			begin
				for(int i=7;i>=0;i--)
				begin
					if(((!cpol)&&(!cpha))||((cpol)&&(cpha)))
					begin
						@(posedge vif.cb_mon_spi.sclk)
						xtn.miso[i]=vif.cb_mon_spi.miso;
						xtn.mosi[i]=vif.cb_mon_spi.mosi;
						xtn.sclk=vif.cb_mon_spi.sclk;
						xtn.spi_interrupt_error=vif.cb_mon_spi.spi_interrupt_error;

					end
					else
					begin
						@(negedge vif.cb_mon_spi.sclk)
						xtn.miso[i]=vif.cb_mon_spi.miso;
						xtn.mosi[i]=vif.cb_mon_spi.mosi;
						xtn.sclk=vif.cb_mon_spi.sclk;
						xtn.spi_interrupt_error=vif.cb_mon_spi.spi_interrupt_error;

					end
                                      $display("************************************************************");
                                   $display("data of miso[%0d]=%b mosi[%0d]=%b ",i,xtn.miso[i],i,xtn.mosi[i]);
	                         `uvm_info("SPI Monitor",xtn.sprint,UVM_MEDIUM)
 
				end
	                                        
			end
	       m_ap.write(xtn);           
		end*/
  
  endtask    

