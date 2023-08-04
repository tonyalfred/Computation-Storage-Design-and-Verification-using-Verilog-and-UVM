/**********************************************************************************************************************
 *  FILE DESCRIPTION
 *  -------------------------------------------------------------------------------------------------------------------
 *  File:         comp_strg_test.sv
 *
 *  Description:  
 * 
 *********************************************************************************************************************/

  `ifndef COMP_STRG_TEST
    `define COMP_STRG_TEST

    class comp_strg_base_test extends uvm_test;
      `uvm_component_utils(comp_strg_base_test)

      comp_strg_env m_env;
      comp_strg_agent_config m_agt0_cfg;

      function new(string name = "comp_strg_base_test", uvm_component parent = null);
        super.new(name,parent);
      endfunction

      function void build_phase (uvm_phase phase);
        super.build_phase(phase);

        m_env = comp_strg_env::type_id::create("m_env",this);
        m_agt0_cfg = comp_strg_agent_config::type_id::create("m_agt0_cfg");

        if(!(uvm_config_db #(virtual comp_strg_if)::get(this,"","comp_strg_if",m_agt0_cfg.m_vif)))
          `uvm_fatal(get_full_name(),"Error! comp_strg_base_test failed to receive comp_strg_if.")

        m_agt0_cfg.set_is_active(UVM_ACTIVE);

        uvm_config_db #(comp_strg_agent_config)::set(this, "m_env.m_agent0*", "comp_strg_agent_cfg", m_agt0_cfg);
        uvm_config_db #(comp_strg_agent_config)::set(this, "m_env.m_reset_agent0*", "comp_strg_agent_cfg", m_agt0_cfg);

        `uvm_info("BUILD_PHASE", "comp_strg_base_test.", UVM_HIGH)
      endfunction

      function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("CONNECT_PHASE", "comp_strg_base_test.", UVM_HIGH)
      endfunction

      function void init_vseq (comp_strg_base_vseq vseq);
        vseq.m_comp_strg_reset_seqr = m_env.m_reset_agent0.m_sequencer;
        vseq.m_comp_strg_data_seqr  = m_env.m_agent0.m_sequencer;
      endfunction
    endclass
      
    class comp_strg_test extends comp_strg_base_test;
      `uvm_component_utils(comp_strg_test)

      comp_strg_vseq m_vseq;

      function new(string name = "comp_strg_test", uvm_component parent = null);
        super.new(name,parent);
      endfunction

      function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("BUILD_PHASE", "comp_strg_test.", UVM_HIGH)
      endfunction

      function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("CONNECT_PHASE", "comp_strg_test.", UVM_HIGH)
      endfunction    

      task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("RUN_PHASE", "comp_strg_test.", UVM_HIGH)

        m_vseq = comp_strg_vseq::type_id::create("m_vseq");
      
        phase.raise_objection(this);
        init_vseq(m_vseq);
        m_vseq.start(null);
        phase.drop_objection(this);
      endtask
    endclass 
  `endif

/**********************************************************************************************************************
*  END OF FILE: comp_strg_test.sv
*********************************************************************************************************************/