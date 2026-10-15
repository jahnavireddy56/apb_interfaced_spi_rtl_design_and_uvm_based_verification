//apb driver class
 class apb_driver extends uvm_driver#(apb_transaction);
    //factory registration
    `uvm_component_utils(apb_driver)
    //virtual interface 
    virtual apb_if.md_dr_apb vif;
    //apb config handle
    apb_agent_config apb_h;
    //external methods
    extern function new (string name="apb_driver",uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern task reset_dut();
    extern task send_to_dut(apb_transaction xtn);
 endclass:apb_driver
 
 //constructor new 
 function apb_driver::new (string name="apb_driver",uvm_component parent);
   super.new(name,parent);
 endfunction
  
 //build_phase
 function void apb_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(apb_agent_config)::get(this,"","apb_agent_config",apb_h))
      `uvm_fatal(get_full_name(),"getting failed in a apb driver")
 endfunction

 //connect phase
  function void apb_driver::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif=apb_h.vif;
  endfunction
 // reset dut task
  task apb_driver::reset_dut();
    @(vif.cb_dr_apb);
    vif.cb_dr_apb.presetn<=1'b0;
    @(vif.cb_dr_apb);
    vif.cb_dr_apb.presetn<=1'b1;
  endtask  
 
 
 //run_phase
   task apb_driver::run_phase(uvm_phase phase);
     super.run_phase(phase);
     reset_dut();
     forever
      begin
      seq_item_port.get_next_item(req);
      send_to_dut(req);
      seq_item_port.item_done();
      end
   endtask
 
 //send to dut task
  
 task apb_driver::send_to_dut(apb_transaction xtn);
   //xtn=apb_transaction::type_id::create("xtn");
    //SETUP PHASE
    @(vif.cb_dr_apb);
    vif.cb_dr_apb.penable<=1'b0;
    vif.cb_dr_apb.psel<=1'b1;
    vif.cb_dr_apb.paddr<=xtn.paddr;
    vif.cb_dr_apb.pwrite<=xtn.pwrite;
  
    //ACESSS PHASE
    @(vif.cb_dr_apb);
    if(xtn.pwrite)
      vif.cb_dr_apb.pwdata<=xtn.pwdata;
    
    vif.cb_dr_apb.penable<=1'b1;
    wait(vif.cb_dr_apb.pready)
    if(xtn.pwrite==0)
     xtn.prdata= vif.cb_dr_apb.prdata;

    //IDLE PHASE
    @(vif.cb_dr_apb);
    vif.cb_dr_apb.psel<=1'b0;
    vif.cb_dr_apb.penable<=1'b0;
  
      //printing
    `uvm_info("apb_driver",$sformatf("after driving data %s",xtn.sprint()),UVM_MEDIUM);
 
 endtask

