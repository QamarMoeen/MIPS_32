library verilog;
use verilog.vl_types.all;
entity memory_vlg_check_tst is
    port(
        read_data       : in     vl_logic_vector(31 downto 0);
        sampler_rx      : in     vl_logic
    );
end memory_vlg_check_tst;
