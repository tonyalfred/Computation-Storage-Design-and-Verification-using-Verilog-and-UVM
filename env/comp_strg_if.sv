/**********************************************************************************************************************
 *  FILE DESCRIPTION
 *  -------------------------------------------------------------------------------------------------------------------
 *  File:         comp_strg_if.sv
 *
 *  Description:  
 * 
 *********************************************************************************************************************/

  `ifndef COMP_STRG_IF
    `define COMP_STRG_IF

    interface comp_strg_if (input clk);
      logic                           rst; 

      logic                           en;

      logic [1:0]                     cmd;

      logic [`STRG_ADDRESS_WIDTH-1:0] addA; 
      logic [`STRG_ADDRESS_WIDTH-1:0] addB; 
      logic [`STRG_ADDRESS_WIDTH-1:0] addC; 

      logic                           valid_out;

      wire  [`STRG_DATA_WIDTH-1:0]    DQ; 

      logic [`STRG_DATA_WIDTH-1:0]    DQ_reg; 
      logic [`STRG_DATA_WIDTH-1:0]    DQ_mon; 

      assign DQ = DQ_reg;
      assign DQ_mon = DQ;

      clocking cb_tb @(posedge clk);
        default input #1step output #0;
        inout DQ;
        input valid_out, DQ_mon;
        inout en, cmd, addA, addB, addC, DQ_reg;
      endclocking
    endinterface 
  `endif

/**********************************************************************************************************************
*  END OF FILE: comp_strg_if.sv
*********************************************************************************************************************/