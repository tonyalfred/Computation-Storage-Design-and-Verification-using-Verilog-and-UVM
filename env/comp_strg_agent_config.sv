/**********************************************************************************************************************
 *  FILE DESCRIPTION
 *  -------------------------------------------------------------------------------------------------------------------
 *  File:         comp_strg_agent_config.sv
 *
 *  Description:  
 * 
 *********************************************************************************************************************/

  `ifndef COMP_STRG_AGENT_CONFIG
    `define COMP_STRG_AGENT_CONFIG

    class comp_strg_agent_config extends uvm_object;
      `uvm_object_utils(comp_strg_agent_config)
      
      virtual comp_strg_if m_vif;
    
      uvm_active_passive_enum is_active;

      function new(string name = "comp_strg_agent_config");
        super.new(name);
      endfunction

      virtual function uvm_active_passive_enum get_is_active();
        return is_active;
      endfunction

      virtual function void set_is_active(uvm_active_passive_enum is_active);
        this.is_active = is_active;
      endfunction
    endclass 
  `endif

/**********************************************************************************************************************
*  END OF FILE: comp_strg_agent_config.sv
*********************************************************************************************************************/