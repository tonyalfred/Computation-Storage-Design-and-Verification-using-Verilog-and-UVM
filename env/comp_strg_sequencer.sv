/**********************************************************************************************************************
 *  FILE DESCRIPTION
 *  -------------------------------------------------------------------------------------------------------------------
 *  File:         comp_strg_sequencer.sv
 *
 *  Description:  
 * 
 *********************************************************************************************************************/

  `ifndef COMP_STRG_SEQUENCER
    `define COMP_STRG_SEQUENCER

    class comp_strg_sequencer extends uvm_sequencer #(comp_strg_seq_item);
      `uvm_component_utils(comp_strg_sequencer)

      function new(string name = "comp_strg_sequencer", uvm_component parent = null);
        super.new(name,parent);
      endfunction
      
      function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("BUILD_PHASE", "comp_strg_sequencer.", UVM_HIGH)
      endfunction

      function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("CONNECT_PHASE", "comp_strg_sequencer.", UVM_HIGH)
      endfunction

      task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("RUN_PHASE", "comp_strg_sequencer.", UVM_HIGH)
      endtask
    endclass 
  `endif

/**********************************************************************************************************************
*  END OF FILE: comp_strg_sequencer.sv
*********************************************************************************************************************/