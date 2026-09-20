

//apb transaction class
class apb_transaction extends uvm_sequence_item;
   //factory registration
   `uvm_object_utils(apb_transaction)
   //properties
    rand bit        pwrite;
    rand bit [2:0] paddr;
    rand bit [7:0] pwdata;
         bit [7:0] prdata;
    rand bit        presetn;
         bit        penable;
         bit        psel;
         bit        pready;
         bit        p_slv_err;
   //constraint to mention when write is high we cant access status register that is adress of 3
    constraint c1{if(pwrite)
                   paddr inside {0,1,2,5};
                  else
                   paddr inside {0,1,2,3,5};}
   //to get access of modeling data we can register the fields or ovveride methods
   /*
   `uvm_object_utils_begin(apb_transaction)
   
     `uvm_field_int(pwrite,UVM_ALL_ON)
     `uvm_field_int(paddr,UVM_ALL_ON)
     `uvm_field_int(pwdata,UVM_ALL_ON)
     `uvm_field_int(prdata,UVM_ALL_ON)
     `uvm_field_int(presetn,UVM_ALL_ON)
     `uvm_field_int(penable,UVM_ALL_ON)
     `uvm_field_int(psel,UVM_ALL_ON)
     `uvm_field_int(pready,UVM_ALL_ON)
     `uvm_field_int(p_slv_err,UVM_ALL_ON)
   `uvm_object_utils_end
  */
      
   //external methods
    extern function new(string name="apb_transaction");
    extern function void do_copy(uvm_object rhs);
    extern function bit do_compare(uvm_object rhs,uvm_comparer comparer);
    extern function void do_print(uvm_printer printer);
endclass:apb_transaction
 
 //constructor new method
 function apb_transaction::new(string name="apb_transaction");
   super.new(name);
 endfunction :new
 
 //do_copy method 
 function void apb_transaction::do_copy(uvm_object rhs);
     apb_transaction rhs_;
     if(!$cast(rhs_,rhs))
       begin
             `uvm_fatal("do_copy","cast of rhs object failed in apb")
       end
     super.do_copy(rhs);
     this.pwrite=rhs_.pwrite;
     this.paddr=rhs_.paddr;
     this.pwdata=rhs_.pwdata;
     this.prdata=rhs_.prdata;
     this.presetn=rhs_.presetn;
     this.penable=rhs_.penable;
     this.psel=rhs_.psel;
     this.pready=rhs_.pready;
     this.p_slv_err=rhs_.p_slv_err;
 endfunction:do_copy
 
 //do_compare
 function bit apb_transaction::do_compare(uvm_object rhs,uvm_comparer comparer);
     apb_transaction rhs_;
     if(!$cast(rhs_,rhs))
       begin
         `uvm_fatal("do_compare","cast of rhs object failed in apb")
          return 0;
       end
     return 
     (super.do_compare(rhs,comparer))&&
     (this.pwrite=rhs_.pwrite)&&
     (this.paddr=rhs_.paddr )&&
     (this.pwdata=rhs_.pwdata) &&
     (this.prdata=rhs_.prdata)&&
     (this.presetn=rhs_.presetn) &&
     (this.penable=rhs_.penable)&&
     (this.psel=rhs_.psel) &&
     (this.pready=rhs_.pready) &&
     (this.p_slv_err=rhs_.p_slv_err);
  endfunction:do_compare

  //do_print
  function void apb_transaction::do_print(uvm_printer printer);
  
     printer.print_field("pwrite",this.pwrite,1,UVM_BIN);
     printer.print_field("paddr",this.paddr,3,UVM_BIN);
     printer.print_field("pwdata",this.pwdata,8,UVM_BIN);
     printer.print_field("prdata",this.prdata,8,UVM_BIN);
     printer.print_field("presetn",this.presetn,1,UVM_BIN);
     printer.print_field("penable",this.penable,1,UVM_BIN);
     printer.print_field("psel",this.psel,1,UVM_BIN);
     printer.print_field("pready",this.pready,1,UVM_BIN);
     printer.print_field("p_slv_err",this.p_slv_err,1,UVM_BIN);
 endfunction:do_print
      
