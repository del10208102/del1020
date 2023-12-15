module top_module(
  // your other ports here
);

  reg clk;
  reg rst_n;
  wire beep;
  wire [639:0][479:0] screen; // 640x480 screen represented by a 2D array

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

    // Initialize screen to all zeros (black)
    for (int i = 0; i < 640; i = i + 1) begin
      for (int j = 0; j < 480; j = j + 1) begin
        screen[i][j] = 0;
      end
    end

    // Example: Draw a white rectangle on the screen
    for (int i = 100; i < 200; i = i + 1) begin
      for (int j = 100; j < 200; j = j + 1) begin
        screen[i][j] = 1; // 1 represents white color
      end
    end

    // Provide a clock signal
    forever #5 clk = ~clk;  // Toggle the clock every 5 time units
  end
end

  // Your simulation or synthesis code here

endmodule
