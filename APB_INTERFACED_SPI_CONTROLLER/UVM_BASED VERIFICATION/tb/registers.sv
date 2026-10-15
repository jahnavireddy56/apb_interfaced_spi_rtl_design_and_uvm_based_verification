//===========REGISTER FILE==============
//===============CONTROL REGISTER 1=============
  class cr_1 extends uvm_reg;
     //factory registration
    `uvm_object_utils(cr_1)
     //add all reg fields 
      rand uvm_reg_field lsbfe;
      rand uvm_reg_field ssoe;
      rand uvm_reg_field cpha;
      rand uvm_reg_field cpol;
      rand uvm_reg_field mstr;
      rand uvm_reg_field sptie;
      rand uvm_reg_field spe;
      rand uvm_reg_field spie;
    
    //constructor new
    function new (string name="cr_1");
       super.new(name,8,UVM_CVR_ALL);
    endfunction
   
    //build method 
    function void build();
        //creating object/memory to reg_fields
        lsbfe=uvm_reg_field::type_id::create("lsbfe");
        ssoe=uvm_reg_field::type_id::create("ssoe");
        cpha=uvm_reg_field::type_id::create("cpha");
        cpol=uvm_reg_field::type_id::create("cpol");
        mstr=uvm_reg_field::type_id::create("mstr");
        sptie=uvm_reg_field::type_id::create("sptie");
        spe=uvm_reg_field::type_id::create("spe");
        spie=uvm_reg_field::type_id::create("spie");

        //configuring fields
        lsbfe.configure(this,1,0,"RW",0,0,0,1,1);
        ssoe.configure(this,1,1,"RW",0,0,0,1,1);     
        cpha.configure(this,1,2,"RW",0,1,0,1,1);     
        cpol.configure(this,1,3,"RW",0,0,0,1,1);     
        mstr.configure(this,1,4,"RW",0,0,0,1,1);     
        sptie.configure(this,1,5,"RW",0,0,0,1,1);     
        spe.configure(this,1,6,"RW",0,0,0,1,1);     
        spie.configure(this,1,7,"RW",0,0,0,1,1);
     
    endfunction 
endclass

//================CONTROL REGISTER 2================
  class cr_2 extends uvm_reg;
     //factory registration
    `uvm_object_utils(cr_2)
     //add all reg fields 
      rand uvm_reg_field spco;
      rand uvm_reg_field spiswai;
       uvm_reg_field reserved1;
      rand uvm_reg_field bidiroe;
      rand uvm_reg_field modfen;
       uvm_reg_field reserved2;
       uvm_reg_field reserved3;
       uvm_reg_field reserved4;
    
    //constructor new
    function new (string name="cr_2");
       super.new(name,8,UVM_CVR_ALL);
    endfunction
   
    //build method 
    function void build();
        //creating object/memory to reg_fields
        spco=uvm_reg_field::type_id::create("spco");
        spiswai=uvm_reg_field::type_id::create("spiswai");
        reserved1=uvm_reg_field::type_id::create("reserved1");
        bidiroe=uvm_reg_field::type_id::create("bidiroe");
        modfen=uvm_reg_field::type_id::create("modfen");
        reserved2=uvm_reg_field::type_id::create("reserved1");
        reserved3=uvm_reg_field::type_id::create("reserved1");
        reserved4=uvm_reg_field::type_id::create("reserved1");

        //configuring fields
        spco.configure(this,1,0,"RW",0,0,1,1,1);
        spiswai.configure(this,1,1,"RW",0,0,1,1,1);     
        reserved1.configure(this,1,2,"RO",0,0,0,0,0);     
        bidiroe.configure(this,1,3,"RW",0,0,1,1,1);     
        modfen.configure(this,1,4,"RW",0,0,1,1,1);     
        reserved2.configure(this,1,5,"RO",0,0,0,0,0);     
        reserved3.configure(this,1,6,"RO",0,0,0,0,0);     
        reserved4.configure(this,1,7,"RO",0,0,0,0,0);
     
    endfunction 
endclass

//================BAUD_RATE REGISTER============
  class br  extends uvm_reg;
     //factory registration
    `uvm_object_utils(br)
     //add all reg fields 
      rand uvm_reg_field spr0;
      rand uvm_reg_field spr1;
      rand uvm_reg_field spr2;
       uvm_reg_field reserved1;
      rand uvm_reg_field sppr0;
      rand uvm_reg_field sppr1;
      rand uvm_reg_field sppr2;
       uvm_reg_field reserved2;
    
    //constructor new
    function new (string name="br");
       super.new(name,8,UVM_CVR_ALL);
    endfunction
   
    //build method 
    function void build();
        //creating object/memory to reg_fields
        spr0=uvm_reg_field::type_id::create("spr0");
        spr1=uvm_reg_field::type_id::create("spr1");
        spr2=uvm_reg_field::type_id::create("spr2");
        reserved1=uvm_reg_field::type_id::create("reserved1");
        sppr0=uvm_reg_field::type_id::create("sppr0");
        sppr1=uvm_reg_field::type_id::create("sppr1");
        sppr2=uvm_reg_field::type_id::create("sppr2");
        reserved2=uvm_reg_field::type_id::create("reserved2");

        //configuring fields
        spr0.configure(this,1,0,"RW",0,0,1,1,1);
        spr1.configure(this,1,1,"RW",0,0,1,1,1);     
        spr2.configure(this,1,2,"RW",0,0,1,1,1);     
        reserved1.configure(this,1,3,"RO",0,0,1,1,0);     
        sppr0.configure(this,1,4,"RW",0,0,1,1,1);     
        sppr1.configure(this,1,5,"RW",0,0,1,1,1);     
        sppr2.configure(this,1,6,"RW",0,0,1,1,1);     
        reserved2.configure(this,1,7,"RO",0,0,1,1,0);
     
    endfunction 
endclass

//==================STATUS REGISTER=================
  class sr extends uvm_reg;
     //factory registration
    `uvm_object_utils(sr)
     //add all reg fields 
      rand uvm_reg_field reserved1;
      rand uvm_reg_field reserved2;
      rand uvm_reg_field reserved3;
      rand uvm_reg_field reserved4;
      rand uvm_reg_field modf;
      rand uvm_reg_field sptef;
      rand uvm_reg_field reserved5;
      rand uvm_reg_field spif;
    
    //constructor new
    function new (string name="cr_1");
       super.new(name,8,UVM_CVR_ALL);
    endfunction
   
    //build method 
    function void build();
        //creating object/memory to reg_fields
        reserved1=uvm_reg_field::type_id::create("reserved1");
        reserved2=uvm_reg_field::type_id::create("reserved2");
        reserved3=uvm_reg_field::type_id::create("reserved3");
        reserved4=uvm_reg_field::type_id::create("reserved4");
        modf=uvm_reg_field::type_id::create("modf");
        sptef=uvm_reg_field::type_id::create("sptef");
        reserved5=uvm_reg_field::type_id::create("reserved5");
        spif=uvm_reg_field::type_id::create("spif");

        //configuring fields
        reserved1.configure(this,1,0,"RO",0,0,0,1,1);
        reserved2.configure(this,1,1,"RO",0,0,0,1,1);     
        reserved3.configure(this,1,2,"RO",0,0,0,1,1);     
        reserved4.configure(this,1,3,"RO",0,0,0,1,1);     
        modf.configure(this,1,4,"Ro",0,0,0,1,1);     
        sptef.configure(this,1,5,"Ro",0,0,1,1,1);     
        reserved5.configure(this,1,6,"RO",0,0,0,1,0);     
        spif.configure(this,1,7,"Ro",0,0,0,1,1);
     
    endfunction 
endclass

//====================== DATA REGISTER ==================
  class dr extends uvm_reg;
     //factory registration
    `uvm_object_utils(dr)
     //add all reg fields 
      rand uvm_reg_field bit0;
      rand uvm_reg_field bit1;
      rand uvm_reg_field bit2;
      rand uvm_reg_field bit3;
      rand uvm_reg_field bit4;
      rand uvm_reg_field bit5;
      rand uvm_reg_field bit6;
      rand uvm_reg_field bit7;
    
    //constructor new
    function new (string name="dr");
       super.new(name,8,UVM_CVR_ALL);
    endfunction
   
    //build method 
    function void build();
        //creating object/memory to reg_fields
        bit0=uvm_reg_field::type_id::create("bit0");
        bit1=uvm_reg_field::type_id::create("bit1");
        bit2=uvm_reg_field::type_id::create("bit2");
        bit3=uvm_reg_field::type_id::create("bit3");
        bit4=uvm_reg_field::type_id::create("bit4");
        bit5=uvm_reg_field::type_id::create("bit5");
        bit6=uvm_reg_field::type_id::create("bit6");
        bit7=uvm_reg_field::type_id::create("bit7");

        //configuring fields
        bit0.configure(this,1,0,"RW",0,0,1,1,1);
        bit1.configure(this,1,1,"RW",0,0,1,1,1);     
        bit2.configure(this,1,2,"RW",0,0,1,1,1);     
        bit3.configure(this,1,3,"RW",0,0,1,1,1);     
        bit4.configure(this,1,4,"RW",0,0,1,1,1);     
        bit5.configure(this,1,5,"RW",0,0,1,1,1);     
        bit6.configure(this,1,6,"RW",0,0,1,1,1);     
        bit7.configure(this,1,7,"RW",0,0,1,1,1);
     
    endfunction 
endclass


