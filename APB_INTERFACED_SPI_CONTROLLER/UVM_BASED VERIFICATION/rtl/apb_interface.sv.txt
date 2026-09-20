//interface od apb master
 interface apb_if(input bit clk);
   logic       presetn;
   logic       psel;
   logic       penable;
   logic [2:0] paddr;
   logic [7:0] pwdata;
   logic [7:0] prdata;
   logic       pwrite;
   logic       pready;
   logic       p_slv_err;
    bit        pclk;
 
	assign pclk=clk;
  //clockingblock for the driving
   clocking cb_dr_apb @(posedge pclk);
     default input #1 output #1;
     output  presetn;
     output  psel;
     output  penable;
     output  paddr;
     output  pwdata;
     input   prdata;
     output  pwrite;
     input   pready;
     input   p_slv_err;
   endclocking 
  
   //clockingblock for the monitoring from the dut
   clocking cb_mon_apb @(posedge pclk);
     default input #1 output #1;
     input  presetn;
     input  psel;
     input  penable;
     input  paddr;
     input  pwdata;
     input  prdata;
     input  pwrite;
     input  pready;
     input  p_slv_err;
   endclocking 

  //modports
  modport md_dr_apb (clocking cb_dr_apb);
  modport ms_mon_apb (clocking cb_mon_apb);
 
 endinterface
