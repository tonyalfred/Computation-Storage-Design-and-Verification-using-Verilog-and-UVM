/**********************************************************************************************************************
 *  FILE DESCRIPTION
 *  -------------------------------------------------------------------------------------------------------------------
 *  File:         comp_strg_seq_item.sv
 *
 *  Description:  
 * 
 *********************************************************************************************************************/

  `ifndef COMP_STRG_SEQ_ITEM
    `define COMP_STRG_SEQ_ITEM

    class comp_strg_seq_item extends uvm_sequence_item;
      `uvm_object_utils(comp_strg_seq_item)

      rand comp_strg_transaction_type_t m_cmd;
      static comp_strg_transaction_type_t m_cmd_s;

      rand logic [`STRG_DATA_WIDTH-1:0]    m_data;

      rand logic [`STRG_ADDRESS_WIDTH-1:0] m_addA;
      rand logic [`STRG_ADDRESS_WIDTH-1:0] m_addB;
      rand logic [`STRG_ADDRESS_WIDTH-1:0] m_addC;

      constraint c_no_write_after_read {if (m_cmd_s == READ) m_cmd != WRITE;}
      constraint c_different_addA_addB_for_ADD_SUB_cmd {if ((m_cmd == ADD) || (m_cmd == SUB)) unique {m_addA, m_addB};}

      function void post_randomize ();
        m_cmd_s = m_cmd;
      endfunction

      function new(string name = "");
        super.new(name);
      endfunction

      function void do_copy(uvm_object rhs);
        comp_strg_seq_item lhs;
        $cast(lhs, rhs);
        super.do_copy(rhs);
        m_cmd  = lhs.m_cmd;
        m_data = lhs.m_data;
        m_addA = lhs.m_addA;
        m_addB = lhs.m_addB;
        m_addC = lhs.m_addC;
      endfunction
    endclass 
  `endif

/**********************************************************************************************************************
*  END OF FILE: comp_strg_seq_item.sv
*********************************************************************************************************************/