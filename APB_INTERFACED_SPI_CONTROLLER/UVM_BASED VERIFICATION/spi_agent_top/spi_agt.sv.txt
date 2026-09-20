// spi_agent 
   class spi_agent extends uvm_agent;
        //factory registrantion
     	`uvm_component_utils(spi_agent)
       //handles of apb_driver,monitor,sequence
        spi_driver driver_h;
        spi_monitor monitor_h;
        spi_sequencer sequencer_h;
       // config hadle of spi_agent 
       spi_agent_config agent_cfg;
       // virtual if and is active parameter declaration
       uvm_active_passive_enum is_active;
       // external methods
        extern function new(string name="spi_agent",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);
        
   endclass:spi_agent
   //constructor new
        function spi_agent::new(string name="spi_agent",uvm_component parent);
         super.new(name,parent);
        endfunction:new
  // build phase
        function void spi_agent::build_phase(uvm_phase phase);
           //get agent configuartion class
           if(!uvm_config_db#(spi_agent_config)::get(this,"","spi_agent_config",agent_cfg))
             `uvm_fatal("SPI_AGENT","get in spi agent failed");
           //store agent_congfig is_active parameter into a ,this is_active
           is_active=agent_cfg.is_active;
           super.build_phase(phase);
           //create object for monitor
            monitor_h=spi_monitor::type_id::create("monitor_h",this);
           //create instances for driver and monitor id is_active is parameter is uvm_active
           if(is_active==UVM_ACTIVE)
             begin
               driver_h=spi_driver::type_id::create("driver_h",this);
               sequencer_h=spi_sequencer::type_id::create("sequencer_h",this);
             end
        endfunction:build_phase
  //connect phase
        function void spi_agent::connect_phase(uvm_phase phase);
           super.connect_phase(phase);
              if(agent_cfg.is_active==UVM_ACTIVE)
              driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
        endfunction
