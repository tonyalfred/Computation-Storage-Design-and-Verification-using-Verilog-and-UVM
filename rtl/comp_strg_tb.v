/**********************************************************************************************************************
 *  FILE DESCRIPTION
 *  -------------------------------------------------------------------------------------------------------------------
 *  File:         comp_strg_tb.v
 *
 *  Description:  computation storage direct testbench
 * 
 *********************************************************************************************************************/

  module comp_strg_tb;
    // Parameters //
    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 10;

    // Inputs //
    reg clk;
    reg rst;
    reg [ADDR_WIDTH-1:0] addA;
    reg [ADDR_WIDTH-1:0] addB;
    reg [ADDR_WIDTH-1:0] addC;
    reg [1:0] cmd;
    reg en;

    // Outputs //
    wire valid_out;
    wire [DATA_WIDTH-1:0] DQ;
    wire [DATA_WIDTH-1:0] DQ_mon;
    reg  [DATA_WIDTH-1:0] DQ_drv;
    reg                   DQ_tb_en;

    reg [DATA_WIDTH-1:0] memory_data [0:1023];

    assign DQ     = DQ_tb_en ? DQ_drv : 32'hz;
    assign DQ_mon = DQ;

    // Design under Test //
    comp_strg #(
      .DATA_WIDTH (DATA_WIDTH),
      .ADDR_WIDTH (ADDR_WIDTH)
    ) dut (
      .clk        (clk),
      .rst        (rst),
      .addA       (addA),
      .addB       (addB),
      .addC       (addC),
      .cmd        (cmd),
      .en         (en),
      .DQ         (DQ),
      .valid_out  (valid_out)
    );

    // Read Memory
    initial begin
      $readmemh("rtl/comp_strg_mem_init.txt", memory_data);
    end

    // Clock Generation
    always begin
      clk = 1'b0; #5; clk = 1'b1; #5;
    end

    // Reset and Stimulus Generation
    initial begin
      // reset
      rst = 1'b1; en = 1'b0; addA = 10'd0; addB = 10'd0; addC = 10'd0; cmd = 2'b00; DQ_tb_en = 0; 
      #2 
      rst = 1'b0; 
      #3; 
      
      // Test case 1: Read Command
      rst = 1'b1; en = 1'b1; addA = 10'd0; addB = 10'd0; addC = 10'd0; cmd = 2'b00; DQ_tb_en = 0; 
      #10; 

      // Test case 20: Reset Interface
      rst = 1'b1; en = 1'b0; addA = 10'd0; addB = 10'd0; addC = 10'd0; cmd = 2'b00; DQ_tb_en = 0; 
      #10; 

      // Test case 2A: Write Command
      rst = 1'b1; en = 1'b1; addA = 10'd0; addB = 10'd0; addC = 10'd0; cmd = 2'b01; DQ_tb_en = 1; DQ_drv = 32'hAAAA;
      #5; 

      // Test case 2B: Read after Write Command
      rst = 1'b1; en = 1'b1; addA = 10'd0; addB = 10'd0; addC = 10'd0; cmd = 2'b00; DQ_tb_en = 0; 
      #10;

      // Test case 3A: Addition Command
      rst = 1'b1; en = 1'b1; addA = 10'd1; addB = 10'd2; addC = 10'd3; cmd = 2'b10; DQ_tb_en = 0;
      #10; 

      // Test case 3B: Read after Addition Command
      rst = 1'b1; en = 1'b1; addA = 10'd3; addB = 10'd0; addC = 10'd0; cmd = 2'b00; DQ_tb_en = 0;
      #10; 

      // Test case 4A: Subtraction Command
      rst = 1'b1; en = 1'b1; addA = 10'd1; addB = 10'd2; addC = 10'd3; cmd = 2'b11; DQ_tb_en = 0;
      #10; 

      // Test case 4B: Read after Subtraction Command
      rst = 1'b1; en = 1'b1; addA = 10'd3; addB = 10'd0; addC = 10'd0; cmd = 2'b00; DQ_tb_en = 0;
      #15;
      $finish;
    end
  endmodule

/**********************************************************************************************************************
*  END OF FILE: comp_strg_tb.v
*********************************************************************************************************************/