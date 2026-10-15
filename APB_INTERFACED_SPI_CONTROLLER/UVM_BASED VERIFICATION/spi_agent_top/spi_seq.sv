// spi_sequences
 class spi_sequence extends uvm_sequence#(spi_transaction);
   //factory registration
   `uvm_object_utils(spi_sequence)

   //external methods
    extern function new(string name="spi_sequence");
    extern task body();
endclass:spi_sequence
 
 //constructor new
 function spi_sequence::new(string name="spi_sequence");
   super.new(name);
 endfunction :new
 
 //task body
 task spi_sequence::body();
    req=spi_transaction::type_id::create("req");
    repeat(1)
       begin
       start_item(req);
       assert(req.randomize() );
      // `uvm_info("spi_sequence",$sformatf("spi transactions after randomizartion =%s",req.sprint),UVM_MEDIUM)
       finish_item(req);
       end
 endtask

