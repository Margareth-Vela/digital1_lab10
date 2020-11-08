/* Margareth Vela
Carné: 19458

Módulo del ejercicio 2*/

//Bus Driver
module Buffer(input wire enable, input wire [3:0]A, output wire [3:0] Y);
  assign Y = enable ? A : 4'bz;
endmodule

//Accumulator
module Accumulator(input wire clk, rst, enable, input wire [3:0] d, output reg [3:0] accu);
  always @ (posedge clk, posedge rst, posedge enable) begin
    if(rst) begin
      accu <= 1'b0;
    end
    else if (enable) begin
      accu <= d;
    end
  end
endmodule

//ALU
module alu(input wire [3:0] A, B, input wire [2:0] F, output reg C, Z, output reg [3:0] Y);
  reg [4:0] Y1;

  parameter ST = 3'b000;
  parameter CMPI = 3'b001;
  parameter LIT = 3'b010;
  parameter ADDI = 3'b011;
  parameter NANDI = 3'b100;

  always @(*) begin
    case(F)
      ST:     assign Y1 = A;
      CMPI:   assign Y1 = (A - B);
      LIT:    assign Y1 = B;
      ADDI:   assign Y1 = (A + B);
      NANDI:  assign Y1 = (A ~& B);
      default: Y1 = 5'd0;
    endcase

    assign Y = Y1[3:0];
    assign C = Y1[4];
    assign Z = (Y1[3:0] == 4'b0) ? 1 : 0;

  end
endmodule

module program(input wire clk, rst, enable1, enable2, enable3, input wire [3:0] A,
                input wire [2:0] F, output wire C, Z, output wire [3:0] Y);

  wire [3:0] data_bus, accu, Y1;
  Buffer        U1(enable1, A, data_bus);
  Accumulator   U2(clk, rst, enable2, Y1, accu);
  alu           U3(accu, data_bus, F, C, Z, Y1);
  Buffer        U4(enable3, Y1, Y);

endmodule
