//test class
 class apb_spi_test extends uvm_test;
   //factory registration
   `uvm_component_utils(apb_spi_test)
   //env handle 
   apb_spi_env env_h;
   //apb_spi_config handle 
   apb_spi_config e_cfg;
   //spi and apb dynamic handles
   spi_agent_config spi_cfg[];
   apb_agent_config apb_cfg[];
   //parameters
   int no_of_spi_agent=1;
   int no_of_apb_agent=1;
   bit has_score_board=1;
   int no_of_score_board=1;
   bit has_apb_agent=1;
   bit has_spi_agent=1;
   //reg blocjk handle
   reg_block reg_model;
   //cr1
   bit[7:0] cr1;
   //externs methods 
  extern function void configuration ();
  extern function new(string name="apb_spi_test",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void end_of_elaboration_phase(uvm_phase phase); 
   
 // extern function void extract_phase(uvm_phase phase);
 endclass
 
 //constructor new
   function apb_spi_test::new(string name="apb_spi_test",uvm_component parent);
     super.new(name,parent);
   endfunction
 
 //configuration method
   function void apb_spi_test::configuration ();
     if(has_apb_agent)
      begin
       apb_cfg=new[no_of_apb_agent];
       foreach(apb_cfg[i])
        begin
           apb_cfg[i]=apb_agent_config::type_id::create($sformatf("apb_cfg[%0d]",i));
           apb_cfg[i].is_active=UVM_ACTIVE;
           if(!uvm_config_db#(virtual apb_if)::get(this,"*","vif_0",apb_cfg[i].vif))
             begin
            `uvm_fatal(get_full_name(),"virtual if get failed in a apb test ")
             end     
           e_cfg.apb_cfg[i]=apb_cfg[i];
                
        end
     end
    if(has_spi_agent)
     begin
       spi_cfg=new[no_of_spi_agent];
       foreach(spi_cfg[i])
          begin
           spi_cfg[i]=spi_agent_config::type_id::create($sformatf("spi_cfg[%0d]",i));
           spi_cfg[i].is_active=UVM_ACTIVE;
           if(!uvm_config_db#(virtual spi_if)::get(this,"*","vif_1",spi_cfg[i].vif))
             begin
            `uvm_fatal(get_full_name(),"virtual if get failed in a spi test")     
             end
           
           
           e_cfg.spi_cfg[i]=spi_cfg[i];
          end
      end
     e_cfg.has_score_board=has_score_board;
     e_cfg.has_apb_agent=has_apb_agent;
     e_cfg.has_spi_agent=has_spi_agent;
     e_cfg.no_of_spi_agent=no_of_spi_agent;
     e_cfg.no_of_apb_agent=no_of_apb_agent;
     e_cfg.no_of_score_board=no_of_score_board;
   
  endfunction
  //build phase
   function void apb_spi_test::build_phase(uvm_phase phase);
      //creating object for ther env config
      e_cfg=apb_spi_config::type_id::create("e_cfg");
     //initialize the dynamic array of handles spi cfg and apb cfg into a no of spi and apb
      if(has_apb_agent)
       begin 
        e_cfg.apb_cfg=new[no_of_apb_agent];
       end
    
      if(has_spi_agent)
       begin
        e_cfg.spi_cfg=new[no_of_spi_agent]; 
       end

    //calling merthod configuration
      configuration ();
    //creating instance for the reg block 
     reg_model=reg_block::type_id::create("spi_reg_block");
     reg_model.build();
     e_cfg.reg_model=this.reg_model;
    //set configuration into uvm_config_db
     uvm_config_db#(apb_spi_config)::set(this,"*","apb_spi_config",e_cfg);
    //setting cr1 register to a spi driver and monitor
    uvm_config_db#(bit[7:0])::set(this,"*","bit[7:0]",cr1); 
     super.build_phase(phase);
     //creating instance for the environment
     env_h=apb_spi_env::type_id::create("env_h",this);
  endfunction

 
   function void apb_spi_test::end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);
      uvm_top.print_topology;
  endfunction
  
   //extract phase
   /*function void apb_spi_test::extract_phase(uvm_phase phase);
      super.extract_phase(phase);
      uvm_top.print_topology;
  endfunction*/
 
  //case 1 cpol_0_cpha_0_lsbfe_1 
   class cpol_0_cpha_0_lsbfe_1_test extends apb_spi_test;
     //factory registration
      `uvm_component_utils(cpol_0_cpha_0_lsbfe_1_test)
     //haldles of apb & spi sequences
      apb_read_seq apb_read;     
      cpol_0_cpha_0_lsbfe_1 apb;
      spi_sequence spi;   
     //extern methods
     extern function new (string name="cpol_0_cpha_0_lsbfe_1_test",uvm_component parent);
     extern function void build_phase(uvm_phase phase);
     extern function void start_of_simulation_phase(uvm_phase phase);
     extern task run_phase(uvm_phase phase);
   endclass
   //constructor new
    function cpol_0_cpha_0_lsbfe_1_test::new (string name="cpol_0_cpha_0_lsbfe_1_test",uvm_component parent);
     super.new(name,parent);
    endfunction
   //BUILD PHASE
   function void cpol_0_cpha_0_lsbfe_1_test::build_phase(uvm_phase phase);
     //cr1 explicitly mentioned value
     cr1=8'b1111_0011;
     super.build_phase(phase);
    
   endfunction
   //START OF SIMULATION PHASE
   function void cpol_0_cpha_0_lsbfe_1_test::start_of_simulation_phase(uvm_phase phase);
     super.start_of_simulation_phase(phase);
        foreach(env_h.apb_h.apb_agent_h[i])
      //  ram_envh.wr_agnth.seqrh.set_arbitration(SEQ_ARB_STRICT_RANDOM);
        
           begin
           env_h.apb_h.apb_agent_h[i].sequencer_h.set_arbitration(SEQ_ARB_STRICT_FIFO);
           env_h.spi_h.spi_agent_h[i].sequencer_h.set_arbitration(SEQ_ARB_STRICT_FIFO);
           
           end
  endfunction
   //run_phase
   task cpol_0_cpha_0_lsbfe_1_test::run_phase(uvm_phase phase);
     super.run_phase(phase);
		`uvm_info(get_type_name(), $sformatf("The current arbitration set is: %s",env_h.apb_h.apb_agent_h[0].sequencer_h.get_arbitration()),UVM_MEDIUM)		
		`uvm_info(get_type_name(), $sformatf("The current arbitration set is: %s",env_h.spi_h.spi_agent_h[0].sequencer_h.get_arbitration()),UVM_MEDIUM)		

       phase.raise_objection(this);
       apb=cpol_0_cpha_0_lsbfe_1::type_id::create("apb");
       spi=spi_sequence::type_id::create("spi");
       apb_read=apb_read_seq::type_id::create("apb_read");
    begin
       fork

         foreach(env_h.apb_h.apb_agent_h[i])
           begin
           apb.start(env_h.apb_h.apb_agent_h[i].sequencer_h,,400);
           end
        foreach(env_h.spi_h.spi_agent_h[i])
           begin
           spi.start(env_h.spi_h.spi_agent_h[i].sequencer_h,,300);
           end
         #1000;
       join
         foreach(env_h.apb_h.apb_agent_h[i])
           begin
           apb_read.start(env_h.apb_h.apb_agent_h[i].sequencer_h,,200);
           end

      // #1000;
     end    
       phase.drop_objection(this);
   endtask
  
  //case 2 cpol_0_cpha_1_lsbfe_1 
   class cpol_0_cpha_1_lsbfe_1_test extends apb_spi_test;
     //factory registration
      `uvm_component_utils(cpol_0_cpha_1_lsbfe_1_test)
     //haldles of apb & spi sequences
       cpol_0_cpha_1_lsbfe_1 apb;
       spi_sequence spi; 
       apb_read_seq apb_read;     
            
     //extern methods
     extern function new (string name="cpol_0_cpha_1_lsbfe_1_test",uvm_component parent);
     extern function void build_phase(uvm_phase phase);
     extern task run_phase(uvm_phase phase);
   endclass
   //constructor new
    function cpol_0_cpha_1_lsbfe_1_test::new (string name="cpol_0_cpha_1_lsbfe_1_test",uvm_component parent);
     super.new(name,parent);
    endfunction
   //BUILD PHASE
   function void cpol_0_cpha_1_lsbfe_1_test::build_phase(uvm_phase phase);
     //cr1 explicitly mentioned value
     cr1=8'b1111_0111;
     super.build_phase(phase);
   endfunction

   //run_phase
   task cpol_0_cpha_1_lsbfe_1_test::run_phase(uvm_phase phase);
     super.run_phase(phase);
     phase.raise_objection(this);
       apb=cpol_0_cpha_1_lsbfe_1::type_id::create("apb");
       spi=spi_sequence::type_id::create("spi");
       apb_read=apb_read_seq::type_id::create("apb_read");
   begin
       fork
         for(int i=0;i<no_of_apb_agent;i++)          
          begin
          apb.start(env_h.apb_h.apb_agent_h[i].sequencer_h);
          end
         foreach(env_h.spi_h.spi_agent_h[i])
           begin
           spi.start(env_h.spi_h.spi_agent_h[i].sequencer_h);
           end
         #1000;
       join;  
       foreach(env_h.apb_h.apb_agent_h[i])
           begin
           apb_read.start(env_h.apb_h.apb_agent_h[i].sequencer_h,,200);
           end

    end
 
     phase.drop_objection(this);
   endtask

 //case 3 cpol_1_cpha_0_lsbfe_1 
   class cpol_1_cpha_0_lsbfe_1_test extends apb_spi_test;
     //factory registration
      `uvm_component_utils(cpol_1_cpha_0_lsbfe_1_test)
     //haldles of apb & spi sequences
      cpol_1_cpha_0_lsbfe_1 apb;
      spi_sequence spi;
      apb_read_seq apb_read;     
      
    //extern methods
     extern function new (string name="cpol_1_cpha_0_lsbfe_1_test",uvm_component parent);
     extern function void build_phase(uvm_phase phase);
     extern task run_phase(uvm_phase phase);
   endclass
   //constructor new
    function cpol_1_cpha_0_lsbfe_1_test::new (string name="cpol_1_cpha_0_lsbfe_1_test",uvm_component parent);
     super.new(name,parent);
    endfunction
   //BUILD PHASE
   function void cpol_1_cpha_0_lsbfe_1_test::build_phase(uvm_phase phase);
     //cr1 explicitly mentioned value
     cr1=8'b1111_1011;
     super.build_phase(phase);
   endfunction

   //run_phase
   task cpol_1_cpha_0_lsbfe_1_test::run_phase(uvm_phase phase);
     super.run_phase(phase);
     phase.raise_objection(this);
       apb=cpol_1_cpha_0_lsbfe_1::type_id::create("apb");
       spi=spi_sequence::type_id::create("spi");
       apb_read=apb_read_seq::type_id::create("apb_read");
    begin
       fork
         for(int i=0;i<no_of_apb_agent;i++)          
          begin
          apb.start(env_h.apb_h.apb_agent_h[i].sequencer_h);
          end
         foreach(env_h.spi_h.spi_agent_h[i])
           begin
           spi.start(env_h.spi_h.spi_agent_h[i].sequencer_h);
           end
         #1000;
      join;   
      foreach(env_h.apb_h.apb_agent_h[i])
           begin
           apb_read.start(env_h.apb_h.apb_agent_h[i].sequencer_h,,200);
           end
   end

    phase.drop_objection(this);
   endtask
  
  //case 4 cpol_1_cpha_1_lsbfe_1 
   class cpol_1_cpha_1_lsbfe_1_test extends apb_spi_test;
     //factory registration
      `uvm_component_utils(cpol_1_cpha_1_lsbfe_1_test)
     //haldles of apb & spi sequences
      cpol_1_cpha_1_lsbfe_1 apb;
      spi_sequence spi;
      apb_read_seq apb_read;     
      
     //extern methods
     extern function new (string name="cpol_1_cpha_1_lsbfe_1_test",uvm_component parent);
     extern function void build_phase(uvm_phase phase);
     extern task run_phase(uvm_phase phase);
   endclass
   //constructor new
    function cpol_1_cpha_1_lsbfe_1_test::new (string name="cpol_1_cpha_1_lsbfe_1_test",uvm_component parent);
     super.new(name,parent);
    endfunction
   //BUILD PHASE
   function void cpol_1_cpha_1_lsbfe_1_test::build_phase(uvm_phase phase);
     //cr1 explicitly mentioned value
     cr1=8'b1111_1111;
     super.build_phase(phase);
   endfunction

   //run_phase
   task cpol_1_cpha_1_lsbfe_1_test::run_phase(uvm_phase phase);
     super.run_phase(phase);
     phase.raise_objection(this);
       apb=cpol_1_cpha_1_lsbfe_1::type_id::create("apb");
       spi=spi_sequence::type_id::create("spi");
       apb_read=apb_read_seq::type_id::create("apb_read");
    begin
       fork
         for(int i=0;i<no_of_apb_agent;i++)          
          begin
          apb.start(env_h.apb_h.apb_agent_h[i].sequencer_h);
          end
        foreach(env_h.spi_h.spi_agent_h[i])
           begin
           spi.start(env_h.spi_h.spi_agent_h[i].sequencer_h);
           end
        #1000;
       join;
     foreach(env_h.apb_h.apb_agent_h[i])
           begin
           apb_read.start(env_h.apb_h.apb_agent_h[i].sequencer_h,,200);
           end
     end
       
     phase.drop_objection(this);
   endtask
 //case 5: cpol_0_cpha_0_lsbfe_0_test
 class cpol_0_cpha_0_lsbfe_0_test extends apb_spi_test;
     //factory registration
      `uvm_component_utils(cpol_0_cpha_0_lsbfe_0_test)
     //haldles of apb & spi sequences
      cpol_0_cpha_0_lsbfe_0 apb;
      spi_sequence spi;    
      apb_read_seq apb_read;     
  
     //extern methods
     extern function new (string name="cpol_0_cpha_0_lsbfe_0_test",uvm_component parent);
     extern function void build_phase(uvm_phase phase);

     extern task run_phase(uvm_phase phase);
   endclass
   //constructor new
    function cpol_0_cpha_0_lsbfe_0_test::new (string name="cpol_0_cpha_0_lsbfe_0_test",uvm_component parent);
     super.new(name,parent);
    endfunction
 //BUILD PHASE
   function void cpol_0_cpha_0_lsbfe_0_test::build_phase(uvm_phase phase);
     //cr1 explicitly mentioned value
     cr1=8'b1111_0010;
     super.build_phase(phase);
   endfunction

   //run_phase
   task cpol_0_cpha_0_lsbfe_0_test::run_phase(uvm_phase phase);
     super.run_phase(phase);
     phase.raise_objection(this);
       apb=cpol_0_cpha_0_lsbfe_0::type_id::create("apb");
       spi=spi_sequence::type_id::create("spi");
     apb_read=apb_read_seq::type_id::create("apb_read");  
    begin

      fork
         for(int i=0;i<no_of_apb_agent;i++)          
          begin
          apb.start(env_h.apb_h.apb_agent_h[i].sequencer_h);
          end
         foreach(env_h.spi_h.spi_agent_h[i])
           begin
           spi.start(env_h.spi_h.spi_agent_h[i].sequencer_h);
           end
         #1000;
      join;  
        for(int i=0;i<no_of_apb_agent;i++)          
          begin
          apb_read.start(env_h.apb_h.apb_agent_h[i].sequencer_h);
          end

   end    
    phase.drop_objection(this);
   endtask
  
  //case 6 cpol_0_cpha_1_lsbfe_0 
   class cpol_0_cpha_1_lsbfe_0_test extends apb_spi_test;
     //factory registration
      `uvm_component_utils(cpol_0_cpha_1_lsbfe_0_test)
     //haldles of apb & spi sequences
       apb_read_seq apb_read;     
      cpol_0_cpha_1_lsbfe_0 apb;
      spi_sequence spi;
      
     //extern methods
     extern function new (string name="cpol_0_cpha_1_lsbfe_0_test",uvm_component parent);
     extern function void build_phase(uvm_phase phase);
     extern task run_phase(uvm_phase phase);
   endclass
   //constructor new
    function cpol_0_cpha_1_lsbfe_0_test::new (string name="cpol_0_cpha_1_lsbfe_0_test",uvm_component parent);
     super.new(name,parent);
    endfunction
  //BUILD PHASE
   function void cpol_0_cpha_1_lsbfe_0_test::build_phase(uvm_phase phase);
     //cr1 explicitly mentioned value
     cr1=8'b1111_0110;
     super.build_phase(phase);
   endfunction

   //run_phase
   task cpol_0_cpha_1_lsbfe_0_test::run_phase(uvm_phase phase);
     super.run_phase(phase);
     phase.raise_objection(this);
       apb=cpol_0_cpha_1_lsbfe_0::type_id::create("apb");
       spi=spi_sequence::type_id::create("spi");
       apb_read=apb_read_seq::type_id::create("apb_read");
     begin
       fork
         for(int i=0;i<no_of_apb_agent;i++)          
          begin
          apb.start(env_h.apb_h.apb_agent_h[i].sequencer_h);
          end
         foreach(env_h.spi_h.spi_agent_h[i])
           begin
           spi.start(env_h.spi_h.spi_agent_h[i].sequencer_h);
           end
         #1000;
      join; 
        foreach(env_h.apb_h.apb_agent_h[i])
           begin
           apb_read.start(env_h.apb_h.apb_agent_h[i].sequencer_h,,200);
           end

    end  
    phase.drop_objection(this);
   endtask

 //case 7 cpol_1_cpha_0_lsbfe_0 
   class cpol_1_cpha_0_lsbfe_0_test extends apb_spi_test;
     //factory registration
      `uvm_component_utils(cpol_1_cpha_0_lsbfe_0_test)
     //haldles of apb & spi sequences
      cpol_1_cpha_0_lsbfe_0 apb;
      spi_sequence spi;      
      apb_read_seq apb_read;     

     //extern methods
     extern function new (string name="cpol_1_cpha_0_lsbfe_0_test",uvm_component parent);
     extern function void build_phase(uvm_phase phase);
     extern task run_phase(uvm_phase phase);
   endclass
   //constructor new
    function cpol_1_cpha_0_lsbfe_0_test::new (string name="cpol_1_cpha_0_lsbfe_0_test",uvm_component parent);
     super.new(name,parent);
    endfunction
 //BUILD PHASE
   function void cpol_1_cpha_0_lsbfe_0_test::build_phase(uvm_phase phase);
     //cr1 explicitly mentioned value
     cr1=8'b1111_1010;
     super.build_phase(phase);
   endfunction

   //run_phase
   task cpol_1_cpha_0_lsbfe_0_test::run_phase(uvm_phase phase);
     super.run_phase(phase);
     phase.raise_objection(this);
       apb=cpol_1_cpha_0_lsbfe_0::type_id::create("apb");
       spi=spi_sequence::type_id::create("spi");
       apb_read=apb_read_seq::type_id::create("apb_read");
     begin
       fork
         for(int i=0;i<no_of_apb_agent;i++)         
          begin
          apb.start(env_h.apb_h.apb_agent_h[i].sequencer_h);
          end
        foreach(env_h.spi_h.spi_agent_h[i])
           begin
           spi.start(env_h.spi_h.spi_agent_h[i].sequencer_h);
           end
         #1000;
      join;   
       foreach(env_h.apb_h.apb_agent_h[i])
           begin
           apb_read.start(env_h.apb_h.apb_agent_h[i].sequencer_h,,200);
           end
      end

   phase.drop_objection(this);
   endtask
  
  //case 8 cpol_1_cpha_1_lsbfe_0 
   class cpol_1_cpha_1_lsbfe_0_test extends apb_spi_test;
     //factory registration
      `uvm_component_utils(cpol_1_cpha_1_lsbfe_0_test)
     //haldles of apb & spi sequences
      cpol_1_cpha_1_lsbfe_0 apb;
      spi_sequence spi;
      apb_read_seq apb_read;     

     //extern methods
     extern function new (string name="cpol_1_cpha_1_lsbfe_0_test",uvm_component parent);
     extern function void build_phase(uvm_phase phase);
     extern task run_phase(uvm_phase phase);
   endclass
   //constructor new
    function cpol_1_cpha_1_lsbfe_0_test::new (string name="cpol_1_cpha_1_lsbfe_0_test",uvm_component parent);
     super.new(name,parent);
    endfunction

   //BUILD PHASE
   function void cpol_1_cpha_1_lsbfe_0_test::build_phase(uvm_phase phase);
     //cr1 explicitly mentioned value
     cr1=8'b1111_1110;
     super.build_phase(phase);
   endfunction

   //run_phase
   task cpol_1_cpha_1_lsbfe_0_test::run_phase(uvm_phase phase);
     super.run_phase(phase);
     phase.raise_objection(this);
       apb=cpol_1_cpha_1_lsbfe_0::type_id::create("apb");
       spi=spi_sequence::type_id::create("spi");
       apb_read=apb_read_seq::type_id::create("apb_read");
     begin
       fork
         for(int i=0;i<no_of_apb_agent;i++)          
          begin
          apb.start(env_h.apb_h.apb_agent_h[i].sequencer_h);
          end
         foreach(env_h.spi_h.spi_agent_h[i])
           begin
           spi.start(env_h.spi_h.spi_agent_h[i].sequencer_h);
           end
          #1000;
       join;   
       foreach(env_h.apb_h.apb_agent_h[i])
           begin
           apb_read.start(env_h.apb_h.apb_agent_h[i].sequencer_h,,200);
           end
      end

   phase.drop_objection(this);
   endtask
  
 //case 9:reset  
   class reset_test extends apb_spi_test;
     //factory registration
      `uvm_component_utils(reset_test)
     //haldles of apb & spi sequences
      reset_seq apb;
      spi_sequence spi;      
      apb_read_seq apb_read;     
      
     //extern methods
     extern function new (string name="reset_test",uvm_component parent);
    // extern function void build_phase(uvm_phase phase);
     extern task run_phase(uvm_phase phase);
   endclass
   //constructor new
    function reset_test::new (string name="reset_test",uvm_component parent);
     super.new(name,parent);
    endfunction
   //run_phase
   task reset_test::run_phase(uvm_phase phase);
     super.run_phase(phase);
     phase.raise_objection(this);
       apb=reset_seq::type_id::create("apb");
       spi=spi_sequence::type_id::create("spi");
       apb_read=apb_read_seq::type_id::create("apb_read");
     begin 
       fork
         for(int i=0;i<no_of_apb_agent;i++)          
          begin
          apb.start(env_h.apb_h.apb_agent_h[i].sequencer_h);
          end
         foreach(env_h.spi_h.spi_agent_h[i])
           begin
           spi.start(env_h.spi_h.spi_agent_h[i].sequencer_h);
           end

         #1000;
      join;   
        foreach(env_h.apb_h.apb_agent_h[i])
           begin
           apb_read.start(env_h.apb_h.apb_agent_h[i].sequencer_h,);
           end

    end 
    phase.drop_objection(this);
   endtask
//CASE :10 LOW POWER
 class low_power_test extends apb_spi_test;
     //factory registration
      `uvm_component_utils(low_power_test)
     //haldles of apb & spi sequences
      low_power apb;
      spi_sequence spi;      
       apb_read_seq apb_read;     
      
     //extern methods
     extern function new (string name="low_power_test",uvm_component parent);
     //extern function void build_phase(uvm_phase phase);
     extern task run_phase(uvm_phase phase);
   endclass
   //constructor new
    function low_power_test::new (string name="low_power_test",uvm_component parent);
     super.new(name,parent);
    endfunction
   //run_phase
   task low_power_test::run_phase(uvm_phase phase);
     super.run_phase(phase);
     phase.raise_objection(this);
       apb=low_power::type_id::create("apb");
       spi=spi_sequence::type_id::create("spi");
       apb_read=apb_read_seq::type_id::create("apb_read");
    begin   
       fork
         for(int i=0;i<no_of_apb_agent;i++)          
          begin
          apb.start(env_h.apb_h.apb_agent_h[i].sequencer_h);
          end
         foreach(env_h.spi_h.spi_agent_h[i])
           begin
           spi.start(env_h.spi_h.spi_agent_h[i].sequencer_h);
           end
   
         #1000;
        join;
        foreach(env_h.apb_h.apb_agent_h[i])
           begin
           apb_read.start(env_h.apb_h.apb_agent_h[i].sequencer_h,,200);
           end
      end
   
      phase.drop_objection(this);
  endtask

  
 class short_data_test extends apb_spi_test;
        `uvm_component_utils(short_data_test)
         function new (string name="short_data_test",uvm_component parent);
           super.new(name,parent);
         endfunction
        function void build_phase(uvm_phase phase);
           super.build_phase(phase);
           set_type_override_by_type(spi_transaction::get_type(),
                                     short_data_cover::get_type());
        endfunction
 endclass
  
