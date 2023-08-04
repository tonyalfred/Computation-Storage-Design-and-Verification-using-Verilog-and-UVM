/**********************************************************************************************************************
 *  FILE DESCRIPTION
 *  -------------------------------------------------------------------------------------------------------------------
 *  File:         comp_strg_tb_top.sv
 *
 *  Description:  
 * 
 *********************************************************************************************************************/
  
  `include "uvm_macros.svh"
  `include "comp_strg_pkg.sv"

  module tb_top;
    import uvm_pkg::*;
    import comp_strg_pkg::*;

    localparam CLK_PERIOD = 5;
    bit        clk;

    comp_strg_if if0 (clk);

    comp_strg #
    (
      .DATA_WIDTH (`STRG_DATA_WIDTH),
      .ADDR_WIDTH (`STRG_ADDRESS_WIDTH)
    ) dut (
      .clk        (clk),
      .rst        (if0.rst),
      .addA       (if0.addA),
      .addB       (if0.addB),
      .addC       (if0.addC),
      .cmd        (if0.cmd),
      .en         (if0.en),
      .DQ         (if0.DQ),
      .valid_out  (if0.valid_out)
    );

    initial begin
        clk = 1;
        forever #(CLK_PERIOD/2) clk = ~ clk;
    end

    initial begin 
      uvm_config_db #(virtual comp_strg_if)::set(null,"uvm_test_top","comp_strg_if",if0);
      run_test("comp_strg_test");
    end 
  endmodule 

/**********************************************************************************************************************
*  END OF FILE: comp_strg_tb_top.sv
*********************************************************************************************************************/