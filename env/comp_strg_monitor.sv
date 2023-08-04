/**********************************************************************************************************************
 *  FILE DESCRIPTION
 *  -------------------------------------------------------------------------------------------------------------------
 *  File:         comp_strg_monitor.sv
 *
 *  Description:  
 * 
 *********************************************************************************************************************/

  `ifndef COMP_STRG_MONITOR
    `define COMP_STRG_MONITOR
    
    class comp_strg_monitor extends uvm_monitor;
      `uvm_component_utils(comp_strg_monitor)

      comp_strg_seq_item m_in_item, m_out_item;
      comp_strg_seq_item m_in_cloned_item, m_out_cloned_item;

      comp_strg_agent_config m_cfg;

      virtual comp_strg_if m_vif;

      uvm_analysis_port #(comp_strg_seq_item) m_in_port; 
      uvm_analysis_port #(comp_strg_seq_item) m_out_port; 
      
      function new(string name = "comp_strg_monitor", uvm_component parent = null);
        super.new(name,parent);
      endfunction

      function void build_phase (uvm_phase phase);
        super.build_phase(phase);

        if(!(uvm_config_db#(comp_strg_agent_config)::get(this,"","comp_strg_agent_cfg",m_cfg)))
          `uvm_fatal(get_full_name(),"Error! comp_strg_monitor failed to receive m_cfg.")

        m_in_port  = new("m_in_port",this);
        m_out_port = new("m_out_port",this);

        `uvm_info("BUILD_PHASE", "comp_strg_monitor.", UVM_HIGH)
      endfunction
      
      function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);

        m_vif = m_cfg.m_vif;

        `uvm_info("CONNECT_PHASE", "comp_strg_monitor.", UVM_HIGH)
      endfunction

      task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("RUN_PHASE", "comp_strg_monitor.", UVM_HIGH)

        forever begin
          fork 
            collect_input  ();
            collect_output ();
          join
        end
      endtask

      task collect_input ();
        forever begin
          @ (posedge m_vif.clk)
          if (m_vif.en) begin
            m_in_item  = comp_strg_seq_item::type_id::create("m_in_item");
            $cast (m_in_item.m_cmd, m_vif.cmd);
            m_in_item.m_addA = m_vif.addA; 
            m_in_item.m_addB = m_vif.addB; 
            m_in_item.m_addC = m_vif.addC; 
            m_in_item.m_data = m_vif.DQ_mon;
          end else continue;
          
          $cast(m_in_cloned_item, m_in_item.clone());
          m_in_port.write(m_in_cloned_item);
        end
      endtask

      task collect_output ();
        forever begin
          @ (posedge m_vif.clk)
          if (m_vif.valid_out) begin
            m_out_item  = comp_strg_seq_item::type_id::create("m_out_item");
            m_out_item.m_data = m_vif.DQ_mon;
          end else continue;

          $cast(m_out_cloned_item, m_out_item.clone());
          m_out_port.write(m_out_cloned_item);
        end
      endtask
    endclass 
  `endif

/**********************************************************************************************************************
*  END OF FILE: comp_strg_monitor.sv
*********************************************************************************************************************/