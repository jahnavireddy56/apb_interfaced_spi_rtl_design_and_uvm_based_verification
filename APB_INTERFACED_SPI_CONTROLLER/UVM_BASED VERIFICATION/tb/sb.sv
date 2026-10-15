
// apb_spi score board 
 class apb_spi_scoreboard extends uvm_scoreboard;
   //factory registration
   `uvm_component_utils(apb_spi_scoreboard)
   //analysis fifo to connect apb and spi monitor
    uvm_tlm_analysis_fifo#(apb_transaction) fifo_apb[];
    uvm_tlm_analysis_fifo#(spi_transaction) fifo_spi[];
   //apb and spi trasaction to get data
    apb_transaction apb_xtn;
    spi_transaction spi_xtn;
   // apb and spi transaction for to give cov data
   apb_transaction apb_cov_data;
   spi_transaction spi_cov_data;
   //apb_spi config 0bandle
   apb_spi_config e_cfg;
   //reg block 0bandle
    reg_block reg_model;
    uvm_status_e  status_e;
    bit[7:0]  ctr1_reg;
    bit[7:0]  ctr2_reg;
    bit[7:0]  br_reg;
    bit[7:0]  sr_reg;
    bit[7:0]  dr_reg;
   //intergers to count data matc0bed and mismac0bed
   int data_matched;
   int data_not_matched;
  //covergroups 
    //APB COVERGROUP 
     covergroup apb_cov;
       option.per_instance=1;
       PRESET_N :coverpoint apb_cov_data.presetn{bins rst={0,1};}
       PENABLE  :coverpoint apb_cov_data.penable{bins enb={0,1};}
       PADDR    :coverpoint apb_cov_data.paddr  {bins addr={0,1,2,3,5};}
       PSEL     :coverpoint apb_cov_data.psel   {bins sel={0,1};}
       PWRITE   :coverpoint apb_cov_data.pwrite {bins wrt={0,1};}
       PREADY   :coverpoint apb_cov_data.pready {bins rdy={0,1};}
       P_SLV_ERR:coverpoint apb_cov_data.p_slv_err{bins p_slv_err={0,1};}
       PWDATA   :coverpoint apb_cov_data.pwdata {bins w_low_data={[8'h 00:8'h 0e]};
                                                 bins w_big_data={[8'h 0f:8'h ff]};
                                                }
       PRDATA   :coverpoint apb_cov_data.prdata {bins r_low_data={[8'h 00:8'h 0f]};
                                                 bins r_big_data={[8'h 0f:8'h ff]};
                                                  }
      PSELXPENABLE:cross  PSEL ,PENABLE;
      PSELXPENABLEXPREADY :cross PSEL,PENABLE,PREADY;
    endgroup
   

   //SPI COVERGROUP
     covergroup spi_cov;
       option.per_instance=1;
       SS   :coverpoint spi_cov_data.ss{bins ss_bin={0,1};}
       MISO :coverpoint spi_cov_data.miso{bins w_low_data={[8'h 00:8'h 0f]};
                                          bins w_0big0b_data={[8'h 0f:8'h ff]};}
       MOSI :coverpoint spi_cov_data.mosi{bins r_low_data={[8'h 00:8'h 0f]};
                                          bins w_0big0b_data={[8'h 0f:8'h ff]};}
       SPI_I_ERR:coverpoint spi_cov_data.spi_interrupt_error {bins interupt={0,1};}
     endgroup 
      
   //extern met0bods 
   extern function new(string name="apb_spi_scoreboard",uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern task ral();
   extern task run_phase(uvm_phase phase);
  // extern task compare_data(apb_transaction apb_xtn,spi_transaction spi_xtn);
   extern task compare_data();
   
 endclass
 
 //constructor new met0bod
   function apb_spi_scoreboard::new(string name="apb_spi_scoreboard",uvm_component parent);
   super.new(name,parent);
   //creating instances for analysis fifos
  // fifo_apb=new("fifo_apb",this);
  // fifo_spi=new("fifo_spi",this);
   //creating instances for t0be covergroups
   apb_cov=new();
   spi_cov=new();
   endfunction
 
 //build p0base
  function void apb_spi_scoreboard::build_phase(uvm_phase phase);
     super.build_phase(phase);

  //get env_config from t0be test
    if(!uvm_config_db#(apb_spi_config)::get(this,"*","apb_spi_config",e_cfg))
      `uvm_fatal(get_full_name,"geting of config failed in ascoreboard")

  //creating analysis fifo apb&spi based on t0be no of apbs and spi
   fifo_apb=new[e_cfg.no_of_apb_agent];
   fifo_spi=new[e_cfg.no_of_spi_agent];
   for(int i=0;i<(e_cfg.no_of_apb_agent);i++)
    fifo_apb[i]=new($sformatf("fifo_apb[%0d]",i),this);
   for(int i=0;i<(e_cfg.no_of_spi_agent);i++)
    fifo_spi[i]=new($sformatf("fifo_spi[%0d]",i),this);

  //ASSIGNING REQ MODEL 
    reg_model=e_cfg.reg_model;
  endfunction
 
 //RAL TASK 
  task apb_spi_scoreboard::ral();
    reg_model.cr1_reg.read(status_e,ctr1_reg,UVM_BACKDOOR,.map(reg_model.spi_reg_map));
     `uvm_info("score_board-REGISTER1",$sformatf("CRT1_REG %b ",ctr1_reg),UVM_LOW)
    reg_model.cr2_reg.read(status_e,ctr2_reg,UVM_BACKDOOR,.map(reg_model.spi_reg_map));
     `uvm_info("score_board-REGISTER2",$sformatf("CRT2_REG %b ",ctr2_reg),UVM_LOW)
    reg_model.br_reg.read(status_e,br_reg,UVM_BACKDOOR,.map(reg_model.spi_reg_map));
     `uvm_info("score_board-REGISTER3",$sformatf("BR_REG %b ",br_reg),UVM_LOW)
    reg_model.sr_reg.read(status_e,sr_reg,UVM_BACKDOOR,.map(reg_model.spi_reg_map));
     `uvm_info("score_board-REGISTER4",$sformatf("SR_REG %b ",sr_reg),UVM_LOW)
    reg_model.dr_reg.read(status_e,dr_reg,UVM_BACKDOOR,.map(reg_model.spi_reg_map));
     `uvm_info("score_board-REGISTER5",$sformatf("DR_REG %b ",dr_reg),UVM_LOW)

  endtask
 //run_p0base
 task apb_spi_scoreboard::run_phase(uvm_phase phase);
   super.run_phase(phase);
   //forever
     //begin
         fork
          for(int i=0;i<(e_cfg.no_of_apb_agent);i++)
            forever         
              begin
               fifo_apb[i].get(apb_xtn);
               //   $display("not getting apb trasactions");
              `uvm_info(get_type_name(),$sformatf("geting from t0be apb monitor in score board %s",apb_xtn.sprint()),UVM_MEDIUM)
               apb_cov_data=apb_xtn;
               apb_cov.sample();
               //calling ral
               ral();
               //put bot0b trasaction into a comapte logic
               compare_data();
              end
          for(int i=0;i<(e_cfg.no_of_apb_agent);i++)   
           forever  
             begin
              fifo_spi[i].get(spi_xtn);
              `uvm_info(get_type_name(),$sformatf("geting from t0be spi monitor in score board %s",spi_xtn.sprint()),UVM_MEDIUM)   
              spi_cov_data=spi_xtn;
              spi_cov.sample();
              //calling ral
              ral();
              //put bot0b trasaction into a comapte logic
              compare_data();
             end
         join
  endtask
 
 //COMPARE DATA LOGIC
   task apb_spi_scoreboard::compare_data();
      wait(apb_xtn!=null);
      wait(spi_xtn!=null);
           //COMPARISON LOGIC FOR MISO AND MOSI
           begin
             if (apb_xtn.pwrite && apb_xtn.paddr==5)
                 begin
                        if (apb_xtn.pwdata[7:0] == spi_xtn.mosi[7:0]) 
                         begin
                         data_matched++;                         
                         $display("==========SCORE BOARD COMPARE=========");
                         $display(" pwdata matc0bes mosi");
                         $display("pwdata=%b, mosi=%b,data_matched=%0d", apb_xtn.pwdata, spi_xtn.mosi,data_matched);
                         $display("======================================");
                         end
                       else
                         begin
                         data_not_matched++;                        
                         $display("SCORE BOARD CASE NOT MATCHED: pwdata=%b, mosi=%d ,data_not_matched=%0d,on", apb_xtn.pwdata, spi_xtn.mosi,data_not_matched,);
                          end
                  end 
              else 
                 begin
                  if((!apb_xtn.pwrite)&&(apb_xtn.paddr==5))
                   begin
                      if (apb_xtn.prdata[7:0] == spi_xtn.miso[7:0]) 
                        begin
                        data_matched++;                        
                        $display("==========SCORE BOARD COMPARE=========");
                        $display("prdata matches miso");
                        $display("prdata=%b, miso=%b,data_matched=%0d", apb_xtn.prdata, spi_xtn.miso,data_matched);
                        $display("======================================");
                        end
                      else
                        begin
                        data_not_matched++;                         
                        $display("SCORE BOARD CASE NOT MATCHED: prdata=%b, miso=%b ,data_not_matched=%0d ", apb_xtn.prdata, spi_xtn.miso,
                               data_not_matched);
                        end
                   end
                end
        end

        //COMPARING LOGICS FOR THE REGISTERS 
        //================CR1=============== 
        if((apb_xtn.paddr==0)&&(apb_xtn.pwrite==1))
          begin
              if(apb_xtn.pwdata==ctr1_reg)
                begin
                    $display("=============== CR1 REGISTER COMPARED====================");
                    $display("CR1 DATA=%0b ,apb_xtn=%0b ",ctr1_reg,apb_xtn.pwdata);
                    $display("====================================================");
                end
              else
                begin
                   $display("=====================CR1 NOT COMPARED======================");
                   $display("CR1 DATA=%0b ,apb_xtn=%0b ",ctr1_reg,apb_xtn.pwdata);
                   $display("====================================================");
                end
          end

        //================CR2=============== 
        if((apb_xtn.paddr==1)&&(apb_xtn.pwrite==1))
          begin
              if(apb_xtn.pwdata==ctr2_reg)
                begin
                    $display("=============== CR2 REGISTER COMPARED====================");
                    $display("CR2 DATA=%0b ,apb_xtn=%0b ",ctr2_reg,apb_xtn.pwdata);
                    $display("====================================================");
                end
              else
                begin
                   $display("=====================CR2 NOT COMPARED======================");
                   $display("CR2 DATA=%0b ,apb_xtn=%0b ",ctr2_reg,apb_xtn.pwdata);
                   $display("====================================================");
                end

          end

       //================BR=============== 
        if((apb_xtn.paddr==2)&&(apb_xtn.pwrite==1))
          begin
              if(apb_xtn.pwdata==br_reg)
                begin
                    $display("=============== BR REGISTER COMPARED====================");
                    $display("BR DATA=%0b ,apb_xtn.pwdata=%0b ",br_reg,apb_xtn.pwdata);
                    $display("====================================================");
                end
             else
                begin
                   $display("====================BR  NOT COMPARED======================");
                   $display("BR DATA=%0b ,apb_xtn=%0b ",br_reg,apb_xtn.pwdata);
                   $display("====================================================");
                end

          end

      //================SR=============== 
        if((apb_xtn.paddr==3)&&(apb_xtn.pwrite==0))
          begin
              if(apb_xtn.prdata==sr_reg)
                begin
                    $display("=============== SR REGISTER COMPARED====================");
                    $display("SR DATA=%0b ,apb_xtn=%0b ",sr_reg,apb_xtn.prdata);
                    $display("====================================================");
                end
              else
                begin
                   $display("=====================SR NOT COMPARED======================");
                   $display("SR DATA=%0b ,apb_xtn=%0b ",sr_reg,apb_xtn.prdata);
                   $display("====================================================");
                end
          end

      //================DR=============== 
        if((apb_xtn.paddr==5)&&(apb_xtn.pwrite==1))
          begin
              if(apb_xtn.pwdata==dr_reg)
                begin
                    $display("=============== DR REGISTER COMPARED====================");
                    $display("DR DATA=%0b ,apb_xtn=%0b ",dr_reg,apb_xtn.pwdata);
                    $display("====================================================");
                end
              else
                begin
                   $display("=====================DR NOT COMPARED======================");
                   $display("DR DATA=%0b ,apb_xtn=%0b ",dr_reg,apb_xtn.pwdata);
                   $display("====================================================");
                end

          end
    //================DR=============== 
        if((apb_xtn.paddr==5)&&(apb_xtn.pwrite==0))
          begin
              if(apb_xtn.prdata==dr_reg)
                begin
                    $display("=============== MISO=DR REGISTER COMPARED====================");
                    $display("DR DATA=%0b ,apb_xtn=%0b ",dr_reg,apb_xtn.prdata);
                    $display("====================================================");
                end
              else
                begin
                   $display("=====================MISO=DR NOT COMPARED======================");
                   $display("DR DATA=%0b ,apb_xtn=%0b ",dr_reg,apb_xtn.prdata);
                   $display("====================================================");
                end

          end

 endtask

