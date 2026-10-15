//=============REGISTER BLOCK================
 class reg_block extends uvm_reg_block;
     //factory registration
     `uvm_object_utils(reg_block)
     //all registers handle
     cr_1 cr1_reg;
     cr_2 cr2_reg;
     br   br_reg;
     sr   sr_reg;
     dr   dr_reg;
     //reg map 
     uvm_reg_map spi_reg_map;
    
      //construnctor new 
     function new(string name="reg_block");
       super.new(name);
     endfunction
     
     //builg method
     virtual function void build();
        //cr1 configuring
           cr1_reg=cr_1::type_id::create("cr1_reg");
           cr1_reg.configure(this,null,"");
           cr1_reg.build();
           cr1_reg.add_hdl_path_slice("spi_cr1",0,8);

       //cr2 configuring
           cr2_reg=cr_2::type_id::create("cr2_reg");
           cr2_reg.configure(this,null,"");
           cr2_reg.build();
           cr2_reg.add_hdl_path_slice("spi_cr2",0,8);

        //br configuring
           br_reg=br::type_id::create("br_reg");
           br_reg.configure(this,null,"");
           br_reg.build();
           br_reg.add_hdl_path_slice("spi_br",0,8);

       //Sr configuring
           sr_reg=sr::type_id::create("sr_reg");
           sr_reg.configure(this,null,"");
           sr_reg.build();
           sr_reg.add_hdl_path_slice("spi_sr",0,8);

       //DR configuring
           dr_reg=dr::type_id::create("dr_reg");
           dr_reg.configure(this,null,"");
           dr_reg.build();
           dr_reg.add_hdl_path_slice("spi_dr",0,8);

      //create reg map and cinfig it
        spi_reg_map=create_map("spi_reg_map",'h0,4,UVM_LITTLE_ENDIAN,0);

       //add all reg into a reg map with unique offset adress x4
       spi_reg_map.add_reg(cr1_reg,32'h00000000,"RW");
       spi_reg_map.add_reg(cr2_reg,32'h00000004,"RW");
       spi_reg_map.add_reg(br_reg,32'h00000008,"RW");
       spi_reg_map.add_reg(sr_reg,32'd 12,"RO");
       spi_reg_map.add_reg(dr_reg,32'd 20,"RW");

      //add hdl path slice
      add_hdl_path("apb_spi.DUV.APB_INTERFACE","RTL");
     
      lock_model();
     endfunction
endclass



