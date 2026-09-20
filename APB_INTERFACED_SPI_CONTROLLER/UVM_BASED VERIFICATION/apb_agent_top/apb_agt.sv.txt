// apb_agent 
   class apb_agent extends uvm_agent;
        //factory registrantion
     	`uvm_component_utils(apb_agent)
       //handles of apb_driver,monitor,sequence
        apb_driver driver_h;
        apb_monitor monitor_h;
        apb_sequencer sequencer_h;
       // config hadle of apb_agent 
       apb_agent_config agent_cfg;
       // virtual if and is active parameter declaration
       
       // external methods
        extern function new(string name="apb_agent",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);
   endclass:apb_agent
   //constructor new
        function apb_agent::new(string name="apb_agent",uvm_component parent);
         super.new(name,parent);
        endfunction:new
  // build phase
        function void apb_agent::build_phase(uvm_phase phase);
		  super.build_phase(phase);

           //get agent configuartion class
           if(!uvm_config_db #(apb_agent_config)::get(this,"","apb_agent_config",agent_cfg))
             `uvm_fatal(get_full_name(),"get failed in agent")
            super.build_phase(phase);
           //create object for monitor
            monitor_h=apb_monitor::type_id::create("monitor_h",this);
           //create instances for driver and monitor id is_active is parameter is uvm_active
		
           if(agent_cfg.is_active==UVM_ACTIVE)
             begin
               driver_h=apb_driver::type_id::create("driver_h",this);
               sequencer_h=apb_sequencer::type_id::create("sequencer_h",this);
             end
        endfunction:build_phase
 
  //connect phase
        function void apb_agent::connect_phase(uvm_phase phase);
           super.connect_phase(phase);
              if(agent_cfg.is_active==UVM_ACTIVE)
              driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
        endfunction
