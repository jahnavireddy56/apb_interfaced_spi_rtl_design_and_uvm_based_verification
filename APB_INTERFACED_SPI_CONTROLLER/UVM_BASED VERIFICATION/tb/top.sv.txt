//top module
  module apb_spi;
  
   import apb_spi_pkg::*;
   import uvm_pkg::*;

   bit clock;
   always #5 clock=~clock;
    //INSTANTIATE INTERFACE
    apb_if in0(clock);
    spi_if in1(clock);
    //instantiate of disign of a rtl with pin to pin connecction
   top_module_spi DUV(.pclk(in0.pclk),
			.presetn(in0.presetn),
			.paddr_i(in0.paddr),
			.pwrite_i(in0.pwrite),
			.psel_i(in0.psel),
			.penable_i(in0.penable),
			.pwdata_i(in0.pwdata),
			.miso_i(in1.miso),
			.ss_o(in1.ss),
			.sclk_o(in1.sclk),
			.spi_interrupt_request_o(in1.spi_interrupt_error),
			.mosi_o(in1.mosi),
			.prdata_o(in0.prdata),
			.pready_o(in0.pready),
			.pslverr_o(in0.p_slv_err));	


    initial
         begin
          // clock=0;
           	`ifdef VCS
         	 $fsdbDumpvars(0, apb_spi);
        	`endif
           
	   uvm_config_db #(virtual apb_if)::set(null,"*","vif_0",in0);
	   uvm_config_db #(virtual spi_if)::set(null,"*","vif_1",in1);
           
           run_test();
          end
 
    //=======================================//
    //            APB ASSERTIONS             //
    //======================================//

    //=======PROPERTY 1==================
    property signal_stable;
    @(posedge clock) $rose(in0.psel) |->($stable(in0.pwdata)&&$stable(in0.pwrite)&&$stable(in0.paddr)) until (in0.pready)[->1];
    endproperty
    SIGNAL_STABLE:assert property(signal_stable)
                      $info("signal stability is verified");
                  else
                      $error("signal stability is not verified");

    //===========PROPERTY 2===============
    property penable_stable;
     @(posedge clock) $rose(in0.penable) |->($stable(in0.psel)&&$stable(in0.penable)) until in0.pready[->1];
   endproperty
    PENABLE_STABLE:assert property(penable_stable);

   //===========PROPERTY 3============
    property psel_to_pready;
      @(posedge clock) (in0.psel&&in0.penable)|->##[0:$] in0.pready;
    endproperty
   PSEL_TO_PREADY:assert property(psel_to_pready);

  //===========PROPERTY 4============
   property address_reserved;
     @(posedge clock) in0.psel|->((in0.paddr!=3'b100)||(in0.paddr!=3'b110)||(in0.paddr==3'b111));
   endproperty
   ADDRESSED_RESERVED:assert property (address_reserved);

  //===========PROPERTY 5==========
   property penable_deasserted;
    @(posedge clock) (!in0.psel)|->(!in0.penable);
   endproperty


 
  //===========PROPERTY 6==========
  property valid_write_data_transfer;
   @(posedge clock)(in0.psel&&in0.penable&&(in0.pwrite))|->(in0.pwdata!==8'hxx);
  endproperty
  VALID_WRITE_DATA_TRANSFER:assert property (valid_write_data_transfer);

  //============PROPERTY 7==========
  property valid_read_data_transfer;
    @(posedge clock)(in0.psel&&in0.penable&&(!in0.pwrite))|->(in0.prdata!==8'hxx);
  endproperty
  VALID_READ_DATA_TRANSFER:assert property (valid_read_data_transfer);

  //==========PROPERT 8==========
  property pready_low_at_start;
   @(posedge clock)(in0.psel&&(!in0.penable))|->(!in0.pready);
  endproperty
  PREADT_LOW_AT_START:assert property (pready_low_at_start);

  //============PROPERTY 9=========
   property pready_deasserted;
    @(posedge clock)(!in0.psel)|->(!in0.pready);
   endproperty
   PREADY_DEASSERTED:assert property(pready_deasserted);
 
  //========================================//
  //          spi ASSERTIONS               //
  //=======================================//
  
   //==========PROPERTY 1==================
   property valid_sclk;
    @(posedge clock) $rose(in1.ss)|=> $stable(in1.sclk);
   endproperty
   VALID_SCLK :assert property (valid_sclk)
                 $info("sclk is verified");
                 else
                  $error("sclk is not verified");

  //===========PROPERTY 2==================
  
              
 endmodule
