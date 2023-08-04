/**********************************************************************************************************************
 *  FILE DESCRIPTION
 *  -------------------------------------------------------------------------------------------------------------------
 *  File:         comp_strg_pkg.sv
 *
 *  Description:  
 * 
 *********************************************************************************************************************/

    `include "comp_strg_defines.sv"
    `include "comp_strg_if.sv"

    package comp_strg_pkg;
        import uvm_pkg::*;
        `include "uvm_macros.svh"

        `include "comp_strg_types.sv"
        `include "comp_strg_seq_item.sv"
        `include "comp_strg_reset_item.sv"
        `include "comp_strg_seq_lib.sv"
        `include "comp_strg_virtual_seq.sv"

        `include "comp_strg_agent_config.sv"
        `include "comp_strg_sequencer.sv"
        `include "comp_strg_driver.sv"
        `include "comp_strg_monitor.sv"
        `include "comp_strg_agent.sv"

        `include "comp_strg_reset_sequencer.sv"
        `include "comp_strg_reset_driver.sv"
        `include "comp_strg_reset_agent.sv"

        `include "comp_strg_scoreboard.sv"
        `include "comp_strg_subscriber.sv"
        `include "comp_strg_env.sv"
        `include "comp_strg_test.sv"
    endpackage

/**********************************************************************************************************************
*  END OF FILE: comp_strg_pkg.sv
*********************************************************************************************************************/