//spi sequencer class
 class spi_sequencer extends uvm_sequencer#(spi_transaction);
    //factory registration
    `uvm_component_utils(spi_sequencer)
    //external methods
    extern function new (string name="spi_sequencer",uvm_component parent);
 endclass:spi_sequencer
  
 function spi_sequencer::new (string name="spi_sequencer",uvm_component parent);
   super.new(name,parent);
 endfunction

