library verilog;
use verilog.vl_types.all;
entity wrapper_vlg_sample_tst is
    port(
        opt             : in     vl_logic_vector(2 downto 0);
        TOP_clock       : in     vl_logic;
        TOP_reset       : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end wrapper_vlg_sample_tst;
