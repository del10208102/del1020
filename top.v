module top_module(
  // your other ports here
);

  reg clk;
  reg rst_n;
  wire beep;

  // Instantiate beep_music module
  beep_music beep_player(
    .clk(clk),
    .rst_n(rst_n),
    .beep(beep)
  );

  // Your other code here

  // System initialization
  initial begin
    // Initialize clock and reset
    clk = 0;
    rst_n = 0;
    #5 rst_n = 1;  // Release reset after 5 time units

    // Provide a clock signal
    forever #5 clk = ~clk;  // Toggle the clock every 5 time units
  end

  // Your simulation or synthesis code here

endmodule
