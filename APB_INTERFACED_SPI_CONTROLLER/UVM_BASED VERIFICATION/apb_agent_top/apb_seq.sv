// apb_sequences
 class apb_sequence extends uvm_sequence#(apb_transaction);
   //factory registration
   `uvm_object_utils(apb_sequence)
   //external methods
    extern function new(string name="apb_sequence");
endclass:apb_sequence
 
 function apb_sequence::new(string name="apb_sequence");
   super.new(name);
 endfunction :new
  //CASE : TO READ APB TRASACTIONS 
  class apb_read_seq extends apb_sequence;
     //factory registration
     `uvm_object_utils(apb_read_seq)
    //extern methods
     extern function new (string name="apb_read_seq");
     extern task body();
  endclass
 
 //constructor new 
  function apb_read_seq ::new (string name="apb_read_seq");
   super.new(name);
  endfunction

 //task body
  task  apb_read_seq::body();
     req=apb_transaction::type_id::create("req");
     repeat(1)
     begin
        //TO READ DATA
         start_item(req);
         assert(req.randomize() with {pwrite==0;paddr==5;});
        `uvm_info( get_type_name(),$sformatf(" PREAD  to read miso after  %s ",req.sprint()),UVM_HIGH)      
         finish_item(req);
     end
  endtask 


  //case 1:  cpol_0_cpha_0_lsbfe_1
  class cpol_0_cpha_0_lsbfe_1 extends apb_sequence;
     //factory registration
     `uvm_object_utils(cpol_0_cpha_0_lsbfe_1)
    //extern methods
     extern function new (string name="cpol_0_cpha_0_lsbfe_1");
     extern task body();
  endclass
 
 //constructor new 
  function cpol_0_cpha_0_lsbfe_1 ::new (string name="cpol_0_cpha_0_lsbfe_1");
   super.new(name);
  endfunction

 //task body
  task  cpol_0_cpha_0_lsbfe_1::body();
     req=apb_transaction::type_id::create("req");
     repeat(1)
     begin
    //cr1 register configure
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==0;pwdata==8'b11110001;});
     `uvm_info( get_type_name(), $sformatf(" cr1 after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)    
     finish_item(req);
   //cr2 register configure
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==1;pwdata==8'b0001_0000;});
     `uvm_info( get_type_name(),$sformatf(" cr2 after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)          
     finish_item(req);
   //baud rate register
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==2;pwdata==8'b0000_0010;});
     `uvm_info( get_type_name(),$sformatf(" BR after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)        
     finish_item(req);
   //data register
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==5;pwdata==8'b1111_1001;});
     `uvm_info( get_type_name(),$sformatf(" DR after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)      
     finish_item(req);
   //TO READ DATA OF STATUS  REGISTER
     start_item(req);
     assert(req.randomize() with {pwrite==0;paddr==3;});
     `uvm_info( get_type_name(),$sformatf(" PREAD after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)      
     finish_item(req);
   
     end
  endtask 
 
 //case 2:cpol=0;cpha=1; lsbfe=1
  class cpol_0_cpha_1_lsbfe_1 extends apb_sequence;
     //factory registration
     `uvm_object_utils(cpol_0_cpha_1_lsbfe_1)
    //extern methods
     extern function new (string name="cpol_0_cpha_1_lsbfe_1");
     extern task body();
  endclass
 
 //constructor new 
  function cpol_0_cpha_1_lsbfe_1::new (string name="cpol_0_cpha_1_lsbfe_1");
   super.new(name);
  endfunction

 //task body
  task cpol_0_cpha_1_lsbfe_1::body();
     req=apb_transaction::type_id::create("req");
     repeat(1)
     begin
    //cr1 register configure
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==0;pwdata==8'b11110101;});
     `uvm_info( get_type_name(), $sformatf(" cr1 after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)    
     finish_item(req);
   //cr2 register configure
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==1;pwdata==8'b00010000;});
     `uvm_info( get_type_name(), $sformatf(" cr2 after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)    
     finish_item(req);
   //baud rate register
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==2;pwdata==8'b0000_0010;});
     `uvm_info( get_type_name(), $sformatf(" br after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)         
     finish_item(req);
   //data register
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==5;});
     `uvm_info( get_type_name(), $sformatf(" dr after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)    
     finish_item(req);
   //TO READ SR DATA
     start_item(req);
     assert(req.randomize() with {pwrite==0;paddr==3;});
     `uvm_info( get_type_name(),$sformatf(" PREAD after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)      
     finish_item(req);
   
     end
  endtask 
 
  //case 3:cpol=1;cpha=0; lsbfe=1
  class cpol_1_cpha_0_lsbfe_1 extends apb_sequence;
     //factory registration
     `uvm_object_utils(cpol_1_cpha_0_lsbfe_1)
    //extern methods
     extern function new (string name="cpol_1_cpha_0_lsbfe_1");
     extern task body();
  endclass
 
 //constructor new 
  function cpol_1_cpha_0_lsbfe_1::new (string name="cpol_1_cpha_0_lsbfe_1");
   super.new(name);
  endfunction

 //task body
  task cpol_1_cpha_0_lsbfe_1::body();
     req=apb_transaction::type_id::create("req");
     repeat(1)
     begin
    //cr1 register configure
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==0;pwdata==8'b11111001;});
     `uvm_info( get_type_name(), $sformatf(" cr1 after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)            
     finish_item(req);
   //cr2 register configure
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==1;pwdata==8'b00010000;});
     `uvm_info( get_type_name(), $sformatf(" cr2 after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)             
     finish_item(req);
   //baud rate register
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==2;pwdata==8'b0000_0010;});
     `uvm_info( get_type_name(), $sformatf(" br after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)            
     finish_item(req);
   //data register
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==5; });
     `uvm_info( get_type_name(), $sformatf(" dr after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)         
     finish_item(req);
   //TO READ SR DATA
     start_item(req);
     assert(req.randomize() with {pwrite==0;paddr==3;});
     `uvm_info( get_type_name(),$sformatf(" PREAD after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)      
     finish_item(req);

     end
  endtask 


 //case 4:cpol=1;cpha=1; lsbfe=1
  class cpol_1_cpha_1_lsbfe_1 extends apb_sequence;
     //factory registration
     `uvm_object_utils(cpol_1_cpha_1_lsbfe_1)
    //extern methods
     extern function new (string name="cpol_1_cpha_1_lsbfe_1");
     extern task body();
  endclass
 
 //constructor new 
  function cpol_1_cpha_1_lsbfe_1::new (string name="cpol_1_cpha_1_lsbfe_1");
   super.new(name);
  endfunction

 //task body
  task cpol_1_cpha_1_lsbfe_1::body();
     req=apb_transaction::type_id::create("req");
    repeat(1)
    begin
    //cr1 register configure
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==0;pwdata==8'b11111101;});
     `uvm_info( get_type_name(), $sformatf(" cr1 after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)        
     finish_item(req);
   //cr2 register configure
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==1;pwdata==8'b00010000;});
     `uvm_info( get_type_name(), $sformatf(" cr2 after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)        
     finish_item(req);
   //baud rate register
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==2;pwdata==8'b0000_0010;});
     `uvm_info( get_type_name(), $sformatf(" br after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)        
     finish_item(req);
   //data register
     start_item(req);// for all the configuration objects, set the following parameters 
		// is_active to UVM_ACTIVE
		// Get the virtual interface from the config database

     assert(req.randomize() with {pwrite==1;paddr==5; });
     `uvm_info( get_type_name(), $sformatf(" dr after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)        
     finish_item(req);
  //TO READ DATA
     start_item(req);
     assert(req.randomize() with {pwrite==0;paddr==3;});
     `uvm_info( get_type_name(),$sformatf(" PREAD after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)      
     finish_item(req);

    end
  endtask 
 
         
  //case 5:cpol=0;cpha=0; lsbfe=0
  class cpol_0_cpha_0_lsbfe_0 extends apb_sequence;
     //factory registration
     `uvm_object_utils(cpol_0_cpha_0_lsbfe_0)
    //extern methods
     extern function new (string name="cpol_0_cpha_0_lsbfe_0");
     extern task body();
  endclass
 
 //constructor new 
  function cpol_0_cpha_0_lsbfe_0::new (string name="cpol_0_cpha_0_lsbfe_0");
   super.new(name);
  endfunction

 //task body
  task cpol_0_cpha_0_lsbfe_0::body();
     req=apb_transaction::type_id::create("req");
     repeat(1)
     begin
    //cr1 register configure
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==0;pwdata==8'b11110000;});
     `uvm_info( get_type_name(), $sformatf(" cr1 after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)    
     finish_item(req);
   //cr2 register configure
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==1;pwdata==8'b00010000;});
     `uvm_info( get_type_name(), $sformatf(" cr2 after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)    
      finish_item(req);
   //baud rate register
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==2;pwdata==8'b0000_0010;});
     `uvm_info( get_type_name(), $sformatf(" br after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)    
     finish_item(req);
   //data register
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==5; });
     `uvm_info( get_type_name(), $sformatf(" dr  after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)    
     finish_item(req);
  //TO READ DATA
     start_item(req);
     assert(req.randomize() with {pwrite==0;paddr==3;});
     `uvm_info( get_type_name(),$sformatf(" PREAD after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)      
     finish_item(req);

     end
  endtask 
 
 //case 6:cpol=0;cpha=1; lsbfe=0
  class cpol_0_cpha_1_lsbfe_0 extends apb_sequence;
     //factory registration
     `uvm_object_utils(cpol_0_cpha_1_lsbfe_0)
    //extern methods
     extern function new (string name="cpol_0_cpha_1_lsbfe_0");
     extern task body();
  endclass
 
 //constructor new 
  function cpol_0_cpha_1_lsbfe_0::new (string name="cpol_0_cpha_1_lsbfe_0");
   super.new(name);
  endfunction

 //task body
  task cpol_0_cpha_1_lsbfe_0::body();
     req=apb_transaction::type_id::create("req");
    repeat(1)
     begin
    //cr1 register configure
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==0;pwdata==8'b11110100;});
     `uvm_info( get_type_name(), $sformatf(" cr1 after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)    
     finish_item(req);
   //cr2 register configure
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==1;pwdata==8'b00010000;});
     `uvm_info( get_type_name(), $sformatf(" cr2 after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)    
     finish_item(req);
   //baud rate register
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==2;pwdata==8'b0000_0010;});
     `uvm_info( get_type_name(), $sformatf(" br after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)    
     finish_item(req);
   //data register
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==5; });
     `uvm_info( get_type_name(), $sformatf(" dr after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)    
     finish_item(req);
   //TO READ DATA
     start_item(req);
     assert(req.randomize() with {pwrite==0;paddr==3;});
     `uvm_info( get_type_name(),$sformatf(" PREAD after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)      
     finish_item(req);
    
    end
  endtask 
 
  //case 7:cpol=1;cpha=0; lsbfe=0
  class cpol_1_cpha_0_lsbfe_0 extends apb_sequence;
     //factory registration
     `uvm_object_utils(cpol_1_cpha_0_lsbfe_0)
    //extern methods
     extern function new (string name="cpol_1_cpha_0_lsbfe_0");
     extern task body();
  endclass
 
 //constructor new 
  function cpol_1_cpha_0_lsbfe_0::new (string name="cpol_1_cpha_0_lsbfe_0");
   super.new(name);
  endfunction

 //task body
  task cpol_1_cpha_0_lsbfe_0::body();
     req=apb_transaction::type_id::create("req");
    repeat(1)
    begin
    //cr1 register configure
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==0;pwdata==8'b11111000;});
     `uvm_info( get_type_name(), $sformatf(" cr1 after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)        
     finish_item(req);
   //cr2 register configure
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==1;pwdata==8'b00010000;});
     `uvm_info( get_type_name(), $sformatf(" cr2 after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)        
     finish_item(req);
   //baud rate register
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==2;pwdata==8'b0000_0010;});
     `uvm_info( get_type_name(), $sformatf(" br after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)         
     finish_item(req);
   //data register
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==5; });
     `uvm_info( get_type_name(), $sformatf(" cr after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)          
     finish_item(req);
  //TO READ DATA
     start_item(req);
     assert(req.randomize() with {pwrite==0;paddr==3;});
     `uvm_info( get_type_name(),$sformatf(" PREAD after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)      
     finish_item(req);
 
     end
  endtask 

 //case 8:cpol=1;cpha=1; lsbfe=0
  class cpol_1_cpha_1_lsbfe_0 extends apb_sequence;
     //factory registration
     `uvm_object_utils(cpol_1_cpha_1_lsbfe_0)
    //extern methods
     extern function new (string name="cpol_1_cpha_1_lsbfe_0");
     extern task body();
  endclass
 
 //constructor new 
  function cpol_1_cpha_1_lsbfe_0::new (string name="cpol_1_cpha_1_lsbfe_0");
   super.new(name);
  endfunction

 //task body
  task cpol_1_cpha_1_lsbfe_0::body();
     req=apb_transaction::type_id::create("req");
     repeat(1)
     begin
    //cr1 register configure
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==0;pwdata==8'b11111100;});
     `uvm_info( get_type_name(), $sformatf(" cr1 after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)        
     finish_item(req);
   //cr2 register configure
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==1;pwdata==8'b00010000;});
     `uvm_info( get_type_name(), $sformatf(" cr2 after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)         
     finish_item(req);
   //baud rate register
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==2;pwdata==8'b0000_0010;});
     `uvm_info( get_type_name(), $sformatf(" br after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)          
     finish_item(req);
   //data register
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==5; });
     `uvm_info( get_type_name(), $sformatf(" dr after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)         
     finish_item(req);
  //TO READ DATA
     start_item(req);
     assert(req.randomize() with {pwrite==0;paddr==3;});
     `uvm_info( get_type_name(),$sformatf(" PREAD after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)      
     finish_item(req);

     end
  endtask 
  
  //case 9:reset
  class reset_seq extends apb_sequence;
     //factory registration
     `uvm_object_utils(reset_seq)
    //extern methods
     extern function new (string name="reset_seq");
     extern task body();
  endclass
 
 //constructor new 
  function reset_seq::new (string name="reset_seq");
   super.new(name);
  endfunction

 //task body
  task reset_seq::body();
     req=apb_transaction::type_id::create("req");
     repeat(1)
     begin
     //reset 
     start_item(req);
     assert(req.randomize() with {presetn==0;});
     `uvm_info(  get_type_name()," preset after randomization printing a apb_trasaction",UVM_HIGH)                       
     finish_item(req);

    //cr1 register configure
     start_item(req);
     assert(req.randomize() with {presetn==0;pwrite==1;paddr==0;pwdata==8'b11111100;});
     `uvm_info(  get_type_name()," cr1 after randomization printing a apb_trasaction",UVM_HIGH)                       
     finish_item(req);
   //cr2 register configure
     start_item(req);
     assert(req.randomize() with {presetn==0;pwrite==1;paddr==1;pwdata==8'b00010000;});
     `uvm_info(  get_type_name()," cr2  after randomization printing a apb_trasaction",UVM_HIGH)               
      finish_item(req);
   //baud rate register
     start_item(req);
     assert(req.randomize() with {presetn==0;pwrite==1;paddr==2;pwdata==8'b0000_0010;});
     `uvm_info(  get_type_name()," br  after randomization printing a apb_trasaction",UVM_HIGH)                     
     finish_item(req);
   //data register
     start_item(req);
     assert(req.randomize() with {presetn==0;pwrite==1;paddr==5;pwdata==8'b1111_1111; });
     `uvm_info(  get_type_name()," dr  after randomization printing a apb_trasaction",UVM_HIGH)                      
     finish_item(req);
   //TO READ DATA
     start_item(req);
     assert(req.randomize() with {pwrite==0;});
     `uvm_info( get_type_name(),$sformatf(" PREAD after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)      
     finish_item(req);

     end
  endtask 

//case 10:low_power 
  class low_power extends apb_sequence;
     //factory registration
     `uvm_object_utils(low_power)
    //extern methods
     extern function new (string name="low_power");
     extern task body();
  endclass
 
 //constructor new 
  function low_power::new (string name="low_power");
   super.new(name);
  endfunction

 //task body
  task low_power::body();
     req=apb_transaction::type_id::create("req");
     repeat(1)
     begin
    //cr1 register configure
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==0;pwdata==8'b11111100;});
     `uvm_info( get_type_name(), $sformatf(" cr1 after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)    
     finish_item(req);
   //cr2 register configure
     //which is having a spiswait signal that make stop at wait mode spi which leads lowpower
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==1;pwdata==8'b00010010;});
     `uvm_info(get_type_name(), $sformatf(" cr 2after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)         
     finish_item(req);
   //baud rate register
     start_item(req);
     assert(req.randomize() with {pwrite==1;paddr==2;pwdata==8'b0000_0010;});
     `uvm_info(get_type_name(), $sformatf(" br after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)       
     finish_item(req);
   //data register
     start_item(req);	
     assert(req.randomize() with {pwrite==1;paddr==5; });
     `uvm_info(get_type_name(), $sformatf(" dr after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)    
    finish_item(req);
   /* //TO READ DATA
     start_item(req);
     assert(req.randomize() with {pwrite==0;});
     `uvm_info( get_type_name(),$sformatf(" PREAD after randomization printing a apb_trasaction %s ",req.sprint()),UVM_HIGH)      
     finish_item(req);
    */
     end
  endtask 


