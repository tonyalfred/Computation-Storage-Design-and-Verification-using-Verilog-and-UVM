/**********************************************************************************************************************
 *  FILE DESCRIPTION
 *  -------------------------------------------------------------------------------------------------------------------
 *  File:         comp_strg_seq_lib.sv
 *
 *  Description:  
 * 
 *********************************************************************************************************************/

  `ifndef COMP_STRG_SEQUENCE_LIB
    `define COMP_STRG_SEQUENCE_LIB

    ///////////////////////////////////////////////////////////////
    ////////////////// RESET AGENT SEQUENCES //////////////////////
    ///////////////////////////////////////////////////////////////

    class comp_strg_reset_seq extends uvm_sequence;
      `uvm_object_utils(comp_strg_reset_seq)

      comp_strg_reset_item m_item;

      function new (string name = "comp_strg_reset_seq");
        super.new(name);
      endfunction

      task body;
        m_item = comp_strg_reset_item::type_id::create("m_item");
        start_item(m_item);

        assert (m_item.randomize())
        else `uvm_fatal("RESET SEQUENCE", "randomization failed.");

        finish_item(m_item);
      endtask

      task post_body;
        `uvm_info("RESET SEQUENCE", "sequence finished.", UVM_HIGH)
      endtask
    endclass     

    ///////////////////////////////////////////////////////////////
    /////////////////// DATA AGENT SEQUENCES //////////////////////
    ///////////////////////////////////////////////////////////////
    
    class comp_strg_base_seq extends uvm_sequence;
      `uvm_object_utils(comp_strg_base_seq)

      comp_strg_seq_item m_item;

      function new (string name = "comp_strg_base_seq");
        super.new(name);
      endfunction

      task post_body;
        `uvm_info("SEQUENCE", "sequence finished.", UVM_HIGH)
      endtask
    endclass

    class comp_strg_directed_seq extends comp_strg_base_seq;
      `uvm_object_utils(comp_strg_directed_seq)

      function new (string name = "comp_strg_directed_seq");
        super.new(name);
      endfunction

      task body; 
        m_item = comp_strg_seq_item::type_id::create("m_item");

        for (int i = 0; i < 20; i++) begin
          
          /*
            1. ADD   at 0, 1 -> 2
            2. READ  at 2
            3. SUB   at 0, 1 -> 2
            4. READ  at 2
            5. NOP
            6. WRITE at 2
            7. READ  at 2
          */
          
          // 1. ADD   at 0, 1 -> 2
          start_item(m_item);
          assert (m_item.randomize() with {
                  m_cmd == ADD; m_addA == 0; m_addB == 1; m_addC == 2;
          })
          else `uvm_fatal("SEQUENCE", "randomization failed.");
          finish_item(m_item);

          // 2. READ  at 2
          start_item(m_item);
          assert (m_item.randomize() with {
                  m_cmd == READ; m_addA == 2;  
          })
          else `uvm_fatal("SEQUENCE", "randomization failed.");
          finish_item(m_item);

          // 3. SUB   at 0, 1 -> 2
          start_item(m_item);
          assert (m_item.randomize() with {
                  m_cmd == SUB; m_addA == 0; m_addB == 1; m_addC == 2;
          })
          else `uvm_fatal("SEQUENCE", "randomization failed.");
          finish_item(m_item);

          // 4. READ  at 2
          start_item(m_item);
          assert (m_item.randomize() with {
                  m_cmd == READ; m_addA == 2;  
          })
          else `uvm_fatal("SEQUENCE", "randomization failed.");
          finish_item(m_item);

          // 5. NOP
          start_item(m_item);
          assert (m_item.randomize() with {
                  m_cmd == NOP;
          })
          else `uvm_fatal("SEQUENCE", "randomization failed.");
          finish_item(m_item);

          // 6. WRITE at 2
          start_item(m_item);
          assert (m_item.randomize() with {
                  m_cmd == WRITE; m_addA == 2;  
          })
          else `uvm_fatal("SEQUENCE", "randomization failed.");
          finish_item(m_item);

          // 7. READ  at 2
          start_item(m_item);
          assert (m_item.randomize() with {
                  m_cmd == READ; m_addA == 2;  
          })
          else `uvm_fatal("SEQUENCE", "randomization failed.");
          finish_item(m_item);
        end 
      endtask
    endclass   

    class comp_strg_rand_seq extends comp_strg_base_seq;
      `uvm_object_utils(comp_strg_rand_seq)

      function new (string name = "comp_strg_rand_seq");
        super.new(name);
      endfunction

      task body; 
        m_item = comp_strg_seq_item::type_id::create("m_item");
        for (int i = 0; i < 100; i++) begin  
          start_item(m_item);

          assert (m_item.randomize())
          else `uvm_fatal("SEQUENCE", "randomization failed.");

          finish_item(m_item);
        end 
      endtask
    endclass   
  `endif

/**********************************************************************************************************************
*  END OF FILE: comp_strg_seq_lib.sv
*********************************************************************************************************************/