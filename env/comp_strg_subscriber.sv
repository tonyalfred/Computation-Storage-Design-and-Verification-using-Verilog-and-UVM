/**********************************************************************************************************************
 *  FILE DESCRIPTION
 *  -------------------------------------------------------------------------------------------------------------------
 *  File:         comp_strg_subscriber.sv
 *
 *  Description:  
 * 
 *********************************************************************************************************************/

  `ifndef COMP_STRG_SUBSCRIBER
    `define COMP_STRG_SUBSCRIBER

    class comp_strg_subscriber extends uvm_subscriber #(comp_strg_seq_item);
      `uvm_component_utils(comp_strg_subscriber)

      comp_strg_seq_item m_item;

      covergroup comp_strg_cov_grp;
        cp_cmd     : coverpoint m_item.m_cmd;
        cp_cmd_trns: coverpoint m_item.m_cmd 
                    {bins b1[] = (READ, WRITE, ADD, SUB => 
                                  READ, WRITE, ADD, SUB);}
      endgroup 

      function new(string name = "comp_strg_subscriber", uvm_component parent = null);
        super.new(name,parent);
        comp_strg_cov_grp = new();
      endfunction

      function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("BUILD_PHASE", "comp_strg_subscriber.", UVM_HIGH)
      endfunction

      function void write (comp_strg_seq_item t);
        m_item = t; 
        comp_strg_cov_grp.sample();
      endfunction
    endclass 
  `endif

/**********************************************************************************************************************
*  END OF FILE: comp_strg_subscriber.sv
*********************************************************************************************************************/