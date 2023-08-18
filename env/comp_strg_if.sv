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
        output en, cmd, addA, addB, addC, DQ_reg;
      endclocking

      // Assertions
      // Active Low Asynchronous Reset
      property p_1;
        @(posedge clk)
          (!rst -> (valid_out == 0 && DQ === 'bz));
      endproperty 
      a_1: assert property (p_1);

      // at ADD, SUB operations, addA, addB can't be the same.
      property p_2;
        @(posedge clk) disable iff (!rst)
          (((cmd == 2) || (cmd == 3)) -> (!(addA == addB)));
      endproperty 
      a_2: assert property (p_2);

      // if en and cmd = READ, then, output is expected to be valid in 1 clock cycle
      property p_3;
        @(posedge clk) disable iff (!rst)
          (en && (cmd == 0)) |=> valid_out; 
      endproperty 
      a_3: assert property (p_3);
    endinterface 
  `endif

/**********************************************************************************************************************
*  END OF FILE: comp_strg_if.sv
*********************************************************************************************************************/