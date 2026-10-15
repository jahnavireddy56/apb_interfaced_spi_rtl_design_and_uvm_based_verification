// environment class
  class apb_spi_env extends uvm_env;
   //factory registration 
   `uvm_component_utils(apb_spi_env)
  //handles of scoreboard ,spi_agent_top,apb_agent_top
   apb_spi_scoreboard sb_h;
   apb_agent_top apb_h;
   spi_agent_top spi_h;
  //handles of env_config class
   apb_spi_config e_cfg;
  //extern methods 
  extern function new (string name="apb_spi_env",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  endclass

  //construnctor new
   function apb_spi_env::new (string name="apb_spi_env",uvm_component parent);
    super.new(name,parent);
   endfunction
  
  //build phase
   function void apb_spi_env::build_phase(uvm_phase phase);
      //get configuration from the test
       if(!uvm_config_db#(apb_spi_config)::get(this,"","apb_spi_config",e_cfg))
        `uvm_fatal(get_full_name(),"get failed in env")
          
          super.build_phase(phase);
         /* if(e_cfg.has_score_board)
            for(int i=0;i<e_cfg.no_of_score_board;i++)
            	sb_h[i]=apb_spi_scoreboard::type_id::create($sformatf("sb_h[%0d]",i),this);*/
          if(e_cfg.has_score_board)
            sb_h=apb_spi_scoreboard::type_id::create("sb_h",this);           
          if(e_cfg.has_apb_agent)
            apb_h=apb_agent_top::type_id::create("apb_h",this);
          if(e_cfg.has_spi_agent)
            spi_h=spi_agent_top::type_id::create("spi_h",this);
         
   endfunction
   //connect phase
  function void apb_spi_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
      
   for(int i=0;i<(e_cfg.no_of_apb_agent);i++)
       begin
         apb_h.apb_agent_h[i].monitor_h.m_ap.connect(sb_h.fifo_apb[i].analysis_export);
       end
   for(int i=0;i<(e_cfg.no_of_spi_agent);i++)
       begin
         spi_h.spi_agent_h[i].monitor_h.m_ap.connect(sb_h.fifo_spi[i].analysis_export);
       end
    
  endfunction
  
  
