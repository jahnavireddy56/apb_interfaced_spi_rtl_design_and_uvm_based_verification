//apb sequencer class
 class apb_sequencer extends uvm_sequencer#(apb_transaction);
    //factory registration
    `uvm_component_utils(apb_sequencer)
    //external methods
    extern function new (string name="apb_sequencer",uvm_component parent);
 endclass:apb_sequencer
  
 function apb_sequencer::new (string name="apb_sequencer",uvm_component parent);
   super.new(name,parent);
 endfunction

