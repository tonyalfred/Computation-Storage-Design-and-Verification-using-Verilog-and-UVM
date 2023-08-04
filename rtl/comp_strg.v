/**********************************************************************************************************************
 *  FILE DESCRIPTION
 *  -------------------------------------------------------------------------------------------------------------------
 *  File:         comp_strg.v
 *
 *  Description:  computation storage design module
 * 
 *********************************************************************************************************************/

  module comp_strg #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 10
  )(
    input  wire                  clk,
    input  wire                  rst,

    input  wire                  en,

    input  wire [1:0]            cmd,

    input  wire [ADDR_WIDTH-1:0] addA,
    input  wire [ADDR_WIDTH-1:0] addB,
    input  wire [ADDR_WIDTH-1:0] addC,

    inout  wire [DATA_WIDTH-1:0] DQ,

    output wire                  valid_out
  );

    reg  [DATA_WIDTH-1:0] memory [0:(1 << ADDR_WIDTH)-1];

    reg  [DATA_WIDTH-1:0] DQ_reg;
    wire [DATA_WIDTH-1:0] DQ_read;
    reg                   DQ_en;

    initial begin
      $readmemh("rtl/comp_strg_mem_init.txt", memory);
    end

    assign DQ        = DQ_en ? DQ_reg : 32'hz;
    assign DQ_read   = DQ;

    assign valid_out = DQ_en;

    always @(posedge clk or negedge rst) begin
      if (!rst) begin
        DQ_reg        <= 0;
        DQ_en         <= 0; 
      end else if (en) begin
        case (cmd)
          2'b00: begin
            DQ_reg       <= memory[addA];
            DQ_en        <= 1;
          end
          2'b01: begin
            memory[addC] <= DQ;
            DQ_en        <= 0;
          end
          2'b10: begin
            memory[addC] <= memory[addA] + memory[addB];
            DQ_en        <= 0;
          end
          2'b11: begin
            memory[addC] <= memory[addA] - memory[addB];
            DQ_en        <= 0;
          end
          default: begin
            DQ_reg        <= 0;
            DQ_en         <= 0;
          end
        endcase
      end else begin
        DQ_reg        <= 0;
        DQ_en         <= 0;   
      end
    end
  endmodule

/**********************************************************************************************************************
*  END OF FILE: comp_strg.v
*********************************************************************************************************************/