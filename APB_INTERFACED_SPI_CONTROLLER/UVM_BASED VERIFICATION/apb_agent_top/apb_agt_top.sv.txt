// apb_agent top
   class apb_agent_top extends uvm_env;
        //factory registrantion
     	`uvm_component_utils(apb_agent_top)
       //handle of apb_agent
        apb_agent apb_agent_h[];
       // handles of env_config
	apb_agent_config apb_cfg[];
       apb_spi_config e_cfg;
       int no_of_agents ;
       // external methods
        extern function new(string name="apb_agent_top",uvm_component parent);
       extern  function void build_phase(uvm_phase phase);
   endclass:apb_agent_top

   //constructor new
        function apb_agent_top::new(string name="apb_agent_top",uvm_component parent);
         super.new(name,parent);
        endfunction

  // build phase
        function void apb_agent_top::build_phase(uvm_phase phase);
          if(!uvm_config_db#(apb_spi_config)::get(this,"","apb_spi_config",e_cfg))
              `uvm_fatal(get_full_name,"get failed in spi agent top")
           no_of_agents=e_cfg.no_of_apb_agent;
           super.build_phase(phase);
           apb_agent_h=new[no_of_agents]; 
           foreach(apb_agent_h[i])
            begin          
              apb_agent_h[i]=apb_agent::type_id::create($sformatf("apb_agent_h[%0d]",i),this);
            end

	   foreach(apb_agent_h[i])
            begin          
	     uvm_config_db#(apb_agent_config)::set(this,$sformatf("apb_agent_h[%0d]*",i),"apb_agent_config",e_cfg.apb_cfg[i]);
            end



        endfunction

