# ISA_Lab1
# GR15

First practical activity of the course "Integrated System Architecture"

This laboratory was focused on the development of a FIR filter characterized by:
- Order 10;
- 8 bits.

# FIRST PART
In the first part (directory FIR_filter) we described the direct form of the FIR
- We wrote the vhd source file and we simulate its behaviour with the relative testbench;
- We synthesized it by the Synopsys environment and we performed some statistics;
- We completed the "Place & route" phase with Innovus.

# SECOND PART
We optimized the filter in terms of throughtput; we implemented a 3 branches parallelization (unfolding) and we added the pipeline registers.
We repeated all the analysis of the first part.
