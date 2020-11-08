//Testbench Ejercicio 2

module testbench();

    reg clk, rst, enable1, enable2, enable3;
    reg [3:0] B;
    reg [2:0] F;
    wire C, Z;
    wire [3:0] Y;

    program   G1(clk, rst, enable1, enable2, enable3, B, F, C, Z, Y);

    always
      begin
        clk <= 1;
        #1 clk <= ~clk;
        #1;
    end

    initial begin
      $display("\n");
      $display(" Ejercicio 2");
      $display("\n");
      $display("  clk rst |   A     F  |  C Z  Y   ");
      $display("-----------------------------------");
      $monitor("%b    %b  | %b   %b |  %b %b %b", clk, rst, B, F, C, Z, Y);

      rst = 1;
      #2 rst = 0; enable1 = 0; enable2 = 0; enable3 = 0;
      #2 enable1 = 1; enable2 = 1; enable3 = 1; B = 4'd10;
      #2 F = 4'd2;
      #1 B = 4'd5;
      #2 F = 4'd1;
      #2 F = 4'd0;
      #1 B = 4'd15;
      #2 F = 4'd3;
      #1 B = 4'd6;
      #2 F = 4'd2;
      #2 F = 4'd1; B = 4'd4;
      #2 F = 4'd2; B = 4'd6;
      #2 F = 4'd4;
      #5 $finish;

    end

    initial begin
          $dumpfile("testbench_tb.vcd");
          $dumpvars(0, testbench);
        end
  endmodule
