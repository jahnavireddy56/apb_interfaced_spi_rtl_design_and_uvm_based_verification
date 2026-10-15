// spb_spi_environment_config class
  class apb_spi_config extends uvm_object;
    //factory registration
    `uvm_object_utils(apb_spi_config)
   //parameters
   int no_of_spi_agent;
   int no_of_apb_agent;
   bit has_score_board;
   int no_of_score_board;
   bit has_apb_agent;
   bit has_spi_agent;
   //handles of apb ans spi config class dynamic handles
   spi_agent_config spi_cfg[];
   apb_agent_config apb_cfg[];
   //reg_block handle 
   reg_block reg_model;
   //extern methods
   extern function new(string name="apb_spi_config");
 endclass
 
 //constructor new method 
  function apb_spi_config::new(string name="apb_spi_config");
    super.new(name);
  endfunction
  
