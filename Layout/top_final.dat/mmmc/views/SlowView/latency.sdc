set_clock_latency -source -early -max -rise  -1.30727 [get_pins {I5/CIN}] -clock clk 
set_clock_latency -source -early -max -fall  -1.2912 [get_pins {I5/CIN}] -clock clk 
set_clock_latency -source -late -max -rise  -1.30727 [get_pins {I5/CIN}] -clock clk 
set_clock_latency -source -late -max -fall  -1.2912 [get_pins {I5/CIN}] -clock clk 
