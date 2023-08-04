/**********************************************************************************************************************
 *  FILE DESCRIPTION
 *  -------------------------------------------------------------------------------------------------------------------
 *  File:         comp_strg_agent.sv
 *
 *  Description:  
 * 
 *********************************************************************************************************************/

  `ifndef COMP_STRG_AGENT
    `define COMP_STRG_AGENT

    class comp_strg_agent extends uvm_agent;
      `uvm_component_utils (comp_strg_agent)
      
      comp_strg_sequencer m_sequencer;
      comp_strg_driver    m_driver;
      comp_strg_monitor   m_monitor;
      
      comp_strg_agent_config m_cfg;

      uvm_analysis_port #(comp_strg_seq_item) m_in_port;
      uvm_analysis_port #(comp_strg_seq_item) m_out_port; 
      
      function new(string name = "comp_strg_agent", uvm_component parent = null);
        super.new(name, parent);
      endfunction
      
      function void build_phase (uvm_phase phase);
        super.build_phase (phase);

        if(!(uvm_config_db#(comp_strg_agent_config)::get(this,"","comp_strg_agent_cfg",m_cfg)))
          `uvm_fatal(get_full_name(),"Error! comp_strg_agent failed to receive m_cfg.")

        m_monitor   = comp_strg_monitor::type_id::create("m_monitor",this);

        if (m_cfg.get_is_active() == UVM_ACTIVE) begin
          m_sequencer = comp_strg_sequencer::type_id::create("m_sequencer",this);
          m_driver = comp_strg_driver::type_id::create("m_driver",this);
        end
            
        m_in_port = new ("m_in_port",this);
        m_out_port = new ("m_out_port",this);

        `uvm_info("BUILD_PHASE", "comp_strg_agent.", UVM_HIGH)
      endfunction
        
      function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        
        m_monitor.m_in_port.connect(m_in_port);
        m_monitor.m_out_port.connect(m_out_port);

        if (m_cfg.get_is_active() == UVM_ACTIVE) begin
          m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
        end

        `uvm_info("CONNECT_PHASE", "comp_strg_agent.", UVM_HIGH)
      endfunction

      task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("RUN_PHASE", "comp_strg_agent.", UVM_HIGH)
      endtask
    endclass 
  `endif

/**********************************************************************************************************************
*  END OF FILE: comp_strg_agent.sv
*********************************************************************************************************************/