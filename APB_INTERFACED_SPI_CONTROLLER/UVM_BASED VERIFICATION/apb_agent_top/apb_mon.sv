//apb monitor class
 class apb_monitor extends uvm_monitor;
    //factory registration
    `uvm_component_utils(apb_monitor)
    //analysis port handle for the sb connection
    uvm_analysis_port#(apb_transaction) m_ap;
    //virtual interface
    virtual apb_if.ms_mon_apb vif;
    //apb_config handle
    apb_agent_config apb_h;
    //apb_trasaction handle
    apb_transaction transaction;
    //external methods
    extern function new (string name="apb_monitor",uvm_component parent);
    extern function void build_phase(uvm_phase phase);    
    extern function void connect_phase(uvm_phase phase);
    extern task collect_data();
    extern task run_phase(uvm_phase phase);
 endclass:apb_monitor
 //constructor new
 function apb_monitor::new (string name="apb_monitor",uvm_component parent);
   super.new(name,parent);
   m_ap=new("m_ap",this);
 endfunction
  
 //build_phase
  function void apb_monitor::build_phase(uvm_phase phase);    
    super.build_phase(phase);
    if(!uvm_config_db#(apb_agent_config)::get(this,"","apb_agent_config",apb_h))
      `uvm_fatal(get_full_name(),"getting failed in a apb driver")
  endfunction

 //connect_phase
  function void apb_monitor::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif=apb_h.vif;
  endfunction
 //collect_data
   task apb_monitor::collect_data();
     apb_transaction xtn;
     xtn=apb_transaction::type_id::create("xtn");

     @(vif.cb_mon_apb);
     wait(vif.cb_mon_apb.penable && vif.cb_mon_apb.pready)

     xtn.psel=vif.cb_mon_apb.psel;
     xtn.penable=vif.cb_mon_apb.penable;
     xtn.paddr=vif.cb_mon_apb.paddr;
     xtn.pwrite=vif.cb_mon_apb.pwrite;
     xtn.presetn=vif.cb_mon_apb.presetn;
     xtn.pready=vif.cb_mon_apb.pready;

  //  @(vif.cb_mon_apb);
     if(xtn.pwrite)
               begin
                xtn.pwdata=vif.cb_mon_apb.pwdata;     
        	xtn.pready=vif.cb_mon_apb.pready;
		xtn.p_slv_err=vif.cb_mon_apb.p_slv_err;
               end
   
     //if(!xtn.pwrite)    
     else 
       begin
             xtn.prdata=vif.cb_mon_apb.prdata;
     	     xtn.pready=vif.cb_mon_apb.pready;
	     xtn.p_slv_err=vif.cb_mon_apb.p_slv_err;
        end
     //@(vif.cb_mon_apb);

    //put into a analalysis port
      m_ap.write(xtn);
   //printing
     `uvm_info("apb_monitor",$sformatf("monitorin apb sequence %s",xtn.sprint()),UVM_MEDIUM);
    //put into a analalysis port
   // m_ap.write(xtn);
 endtask 
 //run_phase
  task apb_monitor::run_phase(uvm_phase phase);
    super.run_phase(phase);
	forever
		begin
     			//transaction=apb_transaction::type_id::create("transaction");
    
   			 collect_data();
		end
  endtask

