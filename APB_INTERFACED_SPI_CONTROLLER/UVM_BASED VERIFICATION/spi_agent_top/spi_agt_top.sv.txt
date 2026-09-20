
// spi_agent top
   class spi_agent_top extends uvm_env;
        //factory registrantion
     	`uvm_component_utils(spi_agent_top)
        //declaring dynamic handles of a spi agengt
        spi_agent spi_agent_h[];
       //handle of apb_spi_env_config to know how many agents
        apb_spi_config e_cfg;
       // external methods
        extern function new(string name="spi_agent_top",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
   endclass:spi_agent_top
   //constructor new
        function spi_agent_top::new(string name="spi_agent_top",uvm_component parent);
         super.new(name,parent);
        endfunction
  // build phase
        function void spi_agent_top::build_phase(uvm_phase phase);
            if(!uvm_config_db#(apb_spi_config)::get(this,"","apb_spi_config",e_cfg))
              `uvm_fatal(get_full_name,"get failed in spi agent top")
            super.build_phase(phase);
           spi_agent_h=new[e_cfg.no_of_spi_agent];
          // forever(spi_agent_h[i])
           for(int i=0;i<$size(spi_agent_h);i++)
             begin
              spi_agent_h[i]=spi_agent::type_id::create($sformatf("spi_agent_h[%0d]",i),this);
              uvm_config_db#(spi_agent_config)::set(this,$sformatf("spi_agent_h[%0d]*", i),"spi_agent_config",e_cfg.spi_cfg[i]);
             end
        endfunction
