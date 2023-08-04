/**********************************************************************************************************************
 *  FILE DESCRIPTION
 *  -------------------------------------------------------------------------------------------------------------------
 *  File:         comp_strg_reset_item.sv
 *
 *  Description:  
 * 
 *********************************************************************************************************************/

  `ifndef COMP_STRG_RESET_ITEM
    `define COMP_STRG_RESET_ITEM

    class comp_strg_reset_item extends uvm_sequence_item;
      `uvm_object_utils(comp_strg_reset_item)

      rand logic [7:0] cycles;

      constraint c_clock_cycles {cycles inside {[2:5]};}

      function new(string name = "comp_strg_reset_item");
        super.new(name);
      endfunction
    endclass 
  `endif

/**********************************************************************************************************************
*  END OF FILE: comp_strg_reset_item.sv
*********************************************************************************************************************/