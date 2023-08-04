/**********************************************************************************************************************
 *  FILE DESCRIPTION
 *  -------------------------------------------------------------------------------------------------------------------
 *  File:         comp_strg_reset_driver.sv
 *
 *  Description:  
 * 
 *********************************************************************************************************************/

  `ifndef COMP_STRG_RESET_DRIVER
    `define COMP_STRG_RESET_DRIVER

    class comp_strg_reset_driver extends uvm_driver #(comp_strg_reset_item);
      `uvm_component_utils(comp_strg_reset_driver)

      comp_strg_reset_item m_item;

      comp_strg_agent_config m_cfg;
      virtual comp_strg_if m_vif;

      function new(string name = "comp_strg_reset_driver", uvm_component parent = null);
        super.new(name,parent);
      endfunction

      function void build_phase (uvm_phase phase);
        super.build_phase(phase);

        if(!(uvm_config_db#(comp_strg_agent_config)::get(this,"","comp_strg_agent_cfg",m_cfg)))
          `uvm_fatal(get_full_name(),"Error! comp_strg_reset_driver failed to receive m_cfg.")
        
        `uvm_info("BUILD_PHASE", "comp_strg_reset_driver.", UVM_HIGH)
      endfunction

      function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);

        m_vif = m_cfg.m_vif;

        `uvm_info("CONNECT_PHASE", "comp_strg_reset_driver.", UVM_HIGH)
      endfunction

      task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("RUN_PHASE", "comp_strg_reset_driver.", UVM_HIGH)

        forever begin
          seq_item_port.get_next_item(m_item);
          reset (m_item);
          seq_item_port.item_done();
        end
      endtask

      task reset(comp_strg_reset_item item);
        m_vif.rst <= 1'b1;
        @ (posedge m_vif.clk);
        m_vif.rst <= 1'b0;
        repeat (item.cycles) @ (posedge m_vif.clk);
        m_vif.rst <= 1'b1;
      endtask
    endclass 
  `endif

/**********************************************************************************************************************
*  END OF FILE: comp_strg_reset_driver.sv
*********************************************************************************************************************/