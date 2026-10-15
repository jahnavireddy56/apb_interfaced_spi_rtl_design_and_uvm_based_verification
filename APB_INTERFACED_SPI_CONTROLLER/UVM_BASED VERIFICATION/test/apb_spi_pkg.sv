
package apb_spi_pkg;


//import uvm_pkg.sv
	import uvm_pkg::*;
//include uvm_macros.sv
	`include "uvm_macros.svh"
//including reg fils
     `include "reqisters.sv"
     `include "reg_block.sv"
//including apb files
     `include "apb_transaction.sv"
     `include "apb_config.sv"
     `include "spi_config.sv"
     `include "apb_spi_env_config.sv"
     `include "apb_driver.sv"
     `include "apb_monitor.sv"
     `include "apb_sequencer.sv"
     `include "apb_agent.sv"
     `include "apb_agent_top.sv"
     `include "apb_sequences.sv"
//including spi files
     `include "spi_transaction.sv"
     `include "spi_monitor.sv"
     `include "spi_sequencer.sv"
     `include "spi_sequences.sv"
     `include "spi_driver.sv"
     `include "spi_agent.sv"
    `include "spi_agent_top.sv"
//including virtual files
   // `include "ram_virtual_sequencer.sv"
  // `include "ram_virtual_seqs.sv"
//including scoreboard
   `include "apb_spi_score_board.sv"
//including environment
   `include "apb_spi_env.sv"

//including test file
   `include "apb_spi_test.sv"
endpackage
