/**********************************************************************************************************************
 *  FILE DESCRIPTION
 *  -------------------------------------------------------------------------------------------------------------------
 *  File:         comp_strg_scoreboard.sv
 *
 *  Description:  
 * 
 *********************************************************************************************************************/

  `ifndef COMP_STRG_SCOREBOARD
    `define COMP_STRG_SCOREBOARD

    class comp_strg_scoreboard extends uvm_scoreboard;
      `uvm_component_utils(comp_strg_scoreboard)

      comp_strg_seq_item m_in_item;
      comp_strg_seq_item m_out_item;

      uvm_analysis_export #(comp_strg_seq_item) m_in_export;
      uvm_analysis_export #(comp_strg_seq_item) m_out_export;

      uvm_tlm_analysis_fifo #(comp_strg_seq_item) m_in_fifo; 
      uvm_tlm_analysis_fifo #(comp_strg_seq_item) m_out_fifo; 

      logic  [`STRG_DATA_WIDTH-1:0] storage [0:(1 << `STRG_ADDRESS_WIDTH)-1];

      function new(string name = "comp_strg_scoreboard", uvm_component parent = null);
        super.new(name,parent);
      endfunction

      function void build_phase (uvm_phase phase);
        super.build_phase(phase);

        m_in_export = new ("m_in_export",this);
        m_out_export = new ("m_out_export",this);
        
        m_in_fifo   = new ("m_in_fifo",this);
        m_out_fifo   = new ("m_out_fifo",this);

        `uvm_info("BUILD_PHASE", "comp_strg_scoreboard.", UVM_HIGH)
      endfunction

      function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);

        m_in_export.connect(m_in_fifo.analysis_export);
        m_out_export.connect(m_out_fifo.analysis_export);

        `uvm_info("CONNECT_PHASE", "comp_strg_scoreboard.", UVM_HIGH)
      endfunction

      task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("RUN_PHASE", "comp_strg_scoreboard.", UVM_HIGH)

        init_storage_ref_model ();

        forever begin 
          m_in_fifo.get(m_in_item);
          storage_ref_model ();
        end
      endtask

      function void init_storage_ref_model ();
        $readmemh("/rtl/comp_strg_mem_init.txt", storage);
      endfunction

      task storage_ref_model ();
        case (m_in_item.m_cmd)
          READ    : 
            begin
              m_out_fifo.get(m_out_item);
              if (storage[m_in_item.m_addA] != m_out_item.m_data)
                `uvm_error("SCB_ERR_READ", "Error!")
              else  
                `uvm_info("SCB_PSS_READ", "Pass!", UVM_HIGH)
            end
          WRITE   : storage[m_in_item.m_addC] = m_in_item.m_data;
          ADD     : storage[m_in_item.m_addC] = storage[m_in_item.m_addA] + storage[m_in_item.m_addB];
          SUB     : storage[m_in_item.m_addC] = storage[m_in_item.m_addA] - storage[m_in_item.m_addB];
          default : begin end
        endcase      
      endtask
    endclass 
  `endif

/**********************************************************************************************************************
*  END OF FILE: comp_strg_scoreboard.sv
*********************************************************************************************************************/