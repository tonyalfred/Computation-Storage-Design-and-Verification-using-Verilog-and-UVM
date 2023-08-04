/**********************************************************************************************************************
 *  FILE DESCRIPTION
 *  -------------------------------------------------------------------------------------------------------------------
 *  File:         comp_strg_env.sv
 *
 *  Description:  
 * 
 *********************************************************************************************************************/

  `ifndef COMP_STRG_ENV
    `define COMP_STRG_ENV

    class comp_strg_env extends uvm_env;
      `uvm_component_utils(comp_strg_env)

      comp_strg_agent       m_agent0;
      comp_strg_reset_agent m_reset_agent0;
      comp_strg_scoreboard  m_scb;
      comp_strg_subscriber  m_sub;

      virtual comp_strg_if m_vif;

      function new(string name = "comp_strg_env", uvm_component parent = null);
        super.new(name,parent);
      endfunction

      function void build_phase (uvm_phase phase);
        super.build_phase(phase);

        m_agent0 = comp_strg_agent::type_id::create("m_agent0",this);
        m_reset_agent0 = comp_strg_reset_agent::type_id::create("m_reset_agent0",this);
        m_scb = comp_strg_scoreboard::type_id::create("m_scb",this);
        m_sub = comp_strg_subscriber::type_id::create("m_sub",this);

        `uvm_info("BUILD_PHASE", "comp_strg_env.", UVM_HIGH)
      endfunction
      
      function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);

        m_agent0.m_in_port.connect(m_scb.m_in_export);
        m_agent0.m_out_port.connect(m_scb.m_out_export);
        m_agent0.m_in_port.connect(m_sub.analysis_export);

        `uvm_info("CONNECT_PHASE", "comp_strg_env.", UVM_HIGH)
      endfunction
    endclass 
  `endif

/**********************************************************************************************************************
*  END OF FILE: comp_strg_env.sv
*********************************************************************************************************************/