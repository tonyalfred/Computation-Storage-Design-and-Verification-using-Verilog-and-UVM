/**********************************************************************************************************************
 *  FILE DESCRIPTION
 *  -------------------------------------------------------------------------------------------------------------------
 *  File:         comp_strg_driver.sv
 *
 *  Description:  
 * 
 *********************************************************************************************************************/

  `ifndef COMP_STRG_DRIVER
    `define COMP_STRG_DRIVER

    class comp_strg_driver extends uvm_driver #(comp_strg_seq_item);
      `uvm_component_utils(comp_strg_driver)

      comp_strg_seq_item m_item;

      comp_strg_agent_config m_cfg;
      virtual comp_strg_if m_vif;

      function new(string name = "comp_strg_driver", uvm_component parent = null);
        super.new(name,parent);
      endfunction

      function void build_phase (uvm_phase phase);
        super.build_phase(phase);

        if(!(uvm_config_db#(comp_strg_agent_config)::get(this,"","comp_strg_agent_cfg",m_cfg)))
          `uvm_fatal(get_full_name(),"Error! comp_strg_driver failed to receive m_cfg.")
        
        `uvm_info("BUILD_PHASE", "comp_strg_driver.", UVM_HIGH)
      endfunction

      function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);

        m_vif = m_cfg.m_vif;

        `uvm_info("CONNECT_PHASE", "comp_strg_driver.", UVM_HIGH)
      endfunction

      task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("RUN_PHASE", "comp_strg_driver.", UVM_HIGH)

        reset_inputs ();

        forever begin
          seq_item_port.get_next_item(m_item);
          drive_transaction(m_item);
          seq_item_port.item_done();
        end
      endtask

      task drive_transaction(comp_strg_seq_item item);
        @(posedge m_vif.clk)
        case (item.m_cmd)
          READ    : drive_read_cmd  (item);
          WRITE   : drive_write_cmd (item);
          ADD     : drive_add_cmd   (item);
          SUB     : drive_sub_cmd   (item);
          NOP     : reset_inputs    ();
          default : reset_inputs    ();
        endcase
      endtask

      task drive_read_cmd (comp_strg_seq_item item);
        m_vif.en     <= 1'b1;
        m_vif.cmd    <= 2'b00;
        m_vif.addA   <= item.m_addA;
        m_vif.addB   <= `STRG_ADDRESS_WIDTH'd0;
        m_vif.addC   <= `STRG_ADDRESS_WIDTH'd0;
        m_vif.DQ_reg <= `STRG_DATA_WIDTH'dz;
      endtask

      task drive_write_cmd (comp_strg_seq_item item);
        m_vif.en     <= 1'b1;
        m_vif.cmd    <= 2'b01;
        m_vif.addA   <= `STRG_ADDRESS_WIDTH'd0;
        m_vif.addB   <= `STRG_ADDRESS_WIDTH'd0;
        m_vif.addC   <= item.m_addC;
        m_vif.DQ_reg <= item.m_data;
      endtask

      task drive_add_cmd (comp_strg_seq_item item);
        m_vif.en     <= 1'b1;
        m_vif.cmd    <= 2'b10;
        m_vif.addA   <= item.m_addA;
        m_vif.addB   <= item.m_addB;
        m_vif.addC   <= item.m_addC;
        m_vif.DQ_reg <= `STRG_DATA_WIDTH'dz;
      endtask

      task drive_sub_cmd (comp_strg_seq_item item);
        m_vif.en     <= 1'b1;
        m_vif.cmd    <= 2'b11;
        m_vif.addA   <= item.m_addA;
        m_vif.addB   <= item.m_addB;
        m_vif.addC   <= item.m_addC;
        m_vif.DQ_reg <= `STRG_DATA_WIDTH'dz;
      endtask

      task reset_inputs ();
        m_vif.en     <= 1'b0;
        m_vif.cmd    <= 2'b00;
        m_vif.addA   <= `STRG_ADDRESS_WIDTH'd0;
        m_vif.addB   <= `STRG_ADDRESS_WIDTH'd0;
        m_vif.addC   <= `STRG_ADDRESS_WIDTH'd0;
        m_vif.DQ_reg <= `STRG_DATA_WIDTH'dz;
      endtask
    endclass 
  `endif

/**********************************************************************************************************************
*  END OF FILE: comp_strg_driver.sv
*********************************************************************************************************************/