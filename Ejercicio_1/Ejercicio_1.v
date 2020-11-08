/* Margareth Vela
Carné: 19458

Módulo del ejercicio 1*/

//Program counter
module counter(input wire clk, rst, enable, Load, input wire [11:0] Ld, output reg [11:0] Y);

  always @ (posedge clk or posedge rst or posedge enable) begin
    if (rst) begin
      Y <= 12'b0;
    end
    else if (enable) begin
        if (Load == 1) begin
          Y <= Ld;
        end
        else if (Load == 0) begin
          Y <= Y + 1;
        end
    end
  end
endmodule

//Program ROM
module ROM(input wire [11:0] Address, output wire [7:0] word);
  reg [7:0] memory [0:4095];
  initial begin
      $readmemb("memory.list", memory);
  end
  assign word = memory[Address];
endmodule

//Fetch
module FETCH(input wire clk, rst, enable, input wire [7:0] program_byte, output reg [3:0] instr, oprnd);
  always @ (posedge clk, posedge rst, posedge enable) begin
    if(rst) begin
      {instr, oprnd} <= 8'b0;
    end
    else if (enable) begin
      {instr, oprnd} <= program_byte;
    end
  end
endmodule

module program(input wire clk, rst1, rst2, enable1, enable2, Load, input wire [11:0] Ld, output wire [7:0] program_byte,output wire [3:0] instr, oprnd);
  wire [11:0] PC;
  counter U1(clk, rst1, enable1, Load, Ld, PC);
  ROM     U2(PC, program_byte);
  FETCH   U3(clk, rst2, enable2, program_byte, instr, oprnd);
endmodule
