//spi_config class
  class spi_agent_config extends uvm_object;
     //factory registration
     `uvm_object_utils(spi_agent_config)
     // is active active parameter
     uvm_active_passive_enum is_active;
     //virtual interface
     virtual spi_if vif;
     //TO GET CR1
     bit[31:0] cr1;
     //extern methods
     extern function new (string name="spi_agent_config");
     
  endclass
  
  //constructor new
     function spi_agent_config::new (string name="spi_agent_config");
       super.new(name);
     endfunction
