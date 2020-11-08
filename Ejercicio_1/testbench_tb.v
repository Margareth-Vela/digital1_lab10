//Testbench Ejercicio 1
module testbench();
  reg clk, rst1, rst2, enable1, enable2, Load;
  reg [11:0] Ld;
  wire [7:0] program_byte;
  wire [3:0] instr, oprnd;

  program  G1(clk, rst1, rst2, enable1, enable2, Load, Ld, program_byte, instr, oprnd);

  always
    begin
      clk <= 1;
      #1 clk <= ~clk;
      #1;
  end

  initial begin
    $display("\n");
    $display(" Ejercicio 1");
    $display("\n");
    $display("  clk rst | program_byte instr  oprnd   ");
    $display("--------------------------------------");
    $monitor("%b  %b    |   %b   %b   %b", clk, rst1, program_byte, instr, oprnd);

    rst1 =  1; rst2 = 1;
    #1 rst1 =  0; rst2 = 0;
    #1 enable1 = 1; Load = 0; enable2 = 1;
    #4 Load = 1; Ld = 12'd8;
    #4 Load = 0;
    #4 enable1 = 0; Load = 1; Ld = 12'd4;
    #2 Ld = 12'd3;
    #4 enable1 = 1; Load = 1; Ld = 12'd12; enable2 = 0;
    #1 Load = 0;
    #4 enable2 =1;
    #12 $finish;

  end

  initial begin
        $dumpfile("testbench_tb.vcd");
        $dumpvars(0, testbench);
      end
endmodule
