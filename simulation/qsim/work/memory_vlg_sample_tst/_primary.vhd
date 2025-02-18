library verilog;
use verilog.vl_types.all;
entity memory_vlg_sample_tst is
    port(
        address         : in     vl_logic_vector(31 downto 0);
        MemRead         : in     vl_logic;
        MemWrite        : in     vl_logic;
        reset           : in     vl_logic;
        write_data      : in     vl_logic_vector(31 downto 0);
        sampler_tx      : out    vl_logic
    );
end memory_vlg_sample_tst;
