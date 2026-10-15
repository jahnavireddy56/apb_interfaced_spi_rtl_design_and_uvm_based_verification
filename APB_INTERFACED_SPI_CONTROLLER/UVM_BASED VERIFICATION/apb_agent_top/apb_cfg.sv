//apb_config class
  class apb_agent_config extends uvm_object;
     //factory registration
     `uvm_object_utils(apb_agent_config)
     //is active parameter
      uvm_active_passive_enum is_active;
     //virtual interface
      virtual apb_if vif;
     //EXTERN METHODS
     extern function new (string name="apb_agent_config");
     
  endclass
  
  //constructor new
     function apb_agent_config::new (string name="apb_agent_config");
       super.new(name);
     endfunction:new
