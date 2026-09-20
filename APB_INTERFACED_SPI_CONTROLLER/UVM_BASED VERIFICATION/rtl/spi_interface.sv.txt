//spi interface
 interface spi_if (input  bit clk);
   logic sclk;
   logic ss;
   logic miso;
   logic mosi;
   logic spi_interrupt_error;
   
   //clocking block for a driver
   clocking cb_dr_spi@(posedge clk);
    default input #1 output #1; 
     input  sclk;
     input ss;
     output  miso;
     input mosi;
     input spi_interrupt_error;
   endclocking
 
   //clocking block for a monitor
   clocking cb_mon_spi@(posedge clk);
    default input #1 output #1;
     input sclk;
     input ss;
     input miso;
     input mosi;
     input spi_interrupt_error;
   endclocking
  
   //modports
   modport mp_dr_spi(clocking cb_dr_spi);
   modport mp_mon_spi(clocking cb_mon_spi);
   
    
 endinterface
    
     
