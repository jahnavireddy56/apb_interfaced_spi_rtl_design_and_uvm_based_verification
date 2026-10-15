//spi transaction class
class spi_transaction extends uvm_sequence_item;
   //factory registration
   `uvm_object_utils(spi_transaction)
   //PROPERTIES 
   bit sclk;
   bit ss;
   bit [7:0]mosi;
   rand bit[7:0] miso;
   bit  spi_interrupt_error;
   //external methods
    extern function new(string name="spi_transaction");
    extern function void do_copy(uvm_object rhs);
    extern function bit do_compare(uvm_object rhs,uvm_comparer comparer);
    extern function void do_print(uvm_printer printer);
endclass:spi_transaction
 //constructor new
 function spi_transaction::new(string name="spi_transaction");
   super.new(name);
 endfunction :new
 //do copy
 function void spi_transaction::do_copy(uvm_object rhs);
     spi_transaction rhs_;
     if(!$cast(rhs_,rhs))
       begin
             `uvm_fatal("do_copy","cast of rhs object failed in apb")
       end
     super.do_copy(rhs);
     this.sclk=rhs_.sclk;
     this.ss=rhs_.ss;
     this.mosi=rhs_.mosi;
     this.miso=rhs_.miso;
     this.spi_interrupt_error=rhs_.spi_interrupt_error;
 endfunction:do_copy
 //do_compare
 function bit spi_transaction::do_compare(uvm_object rhs,uvm_comparer comparer);
     spi_transaction rhs_;
     if(!$cast(rhs_,rhs))
       begin
         `uvm_fatal("do_compare","cast of rhs object failed in apb")
          return 0;
       end
     return 
     (super.do_compare(rhs,comparer))&&
     (this.sclk==rhs_.sclk)&&
     (this.ss==rhs_.ss )&&
     (this.mosi==rhs_.mosi) &&
     (this.miso==rhs_.miso) &&
     (this.spi_interrupt_error==rhs_.spi_interrupt_error);
 endfunction:do_compare

//do_print
  function void spi_transaction::do_print(uvm_printer printer);
  
     printer.print_field("sclk",this.sclk,1,UVM_BIN);
     printer.print_field("ss",this.ss,1,UVM_BIN);
     printer.print_field("miso",this.miso,8,UVM_BIN);
     printer.print_field("mosi",this.mosi,8,UVM_BIN);
     printer.print_field("spi_interrupt_error",this.spi_interrupt_error,1,UVM_BIN);
  endfunction:do_print
      
//EXTENDED CLASS for full coverage
   class short_data_cover extends spi_transaction;
          `uvm_object_utils(short_data_cover)
           function new(string name="short_data_cover");
               super.new(name);
           endfunction
           constraint sort_miso {miso  inside {[8'h 00:8'h 0f]};}
   endclass
