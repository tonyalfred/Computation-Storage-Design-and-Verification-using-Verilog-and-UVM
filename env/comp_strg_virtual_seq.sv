/**********************************************************************************************************************
 *  FILE DESCRIPTION
 *  -------------------------------------------------------------------------------------------------------------------
 *  File:         comp_strg_virtual_seq.sv
 *
 *  Description:  
 * 
 *********************************************************************************************************************/

  `ifndef COMP_STRG_VIRTUAL_SEQ
    `define COMP_STRG_VIRTUAL_SEQ

    class comp_strg_base_vseq extends uvm_sequence #(uvm_sequence_item);
      `uvm_object_utils(comp_strg_base_vseq)

      uvm_sequencer #(comp_strg_seq_item)   m_comp_strg_data_seqr;
      uvm_sequencer #(comp_strg_reset_item) m_comp_strg_reset_seqr;

      function new (string name = "comp_strg_base_vseq");
        super.new(name);
      endfunction
    endclass

    class comp_strg_vseq extends comp_strg_base_vseq;
      `uvm_object_utils(comp_strg_vseq)

      function new (string name = "comp_strg_vseq");
        super.new(name);
      endfunction
      
      task body ();
        comp_strg_reset_seq m_reset_seq = comp_strg_reset_seq::type_id::create("m_reset_seq");
        comp_strg_directed_seq m_direct_seq = comp_strg_directed_seq::type_id::create("m_direct_seq");
        comp_strg_rand_seq m_rand_seq = comp_strg_rand_seq::type_id::create("m_rand_seq");

        m_reset_seq.start(m_comp_strg_reset_seqr); 
        m_direct_seq.start(m_comp_strg_data_seqr);
        m_rand_seq.start(m_comp_strg_data_seqr);
      endtask
    endclass
  `endif

/**********************************************************************************************************************
*  END OF FILE: comp_strg_virtual_seq.sv
*********************************************************************************************************************/