library verilog;
use verilog.vl_types.all;
entity wrapper_vlg_check_tst is
    port(
        hex0            : in     vl_logic_vector(6 downto 0);
        hex1            : in     vl_logic_vector(6 downto 0);
        hex2            : in     vl_logic_vector(6 downto 0);
        hex3            : in     vl_logic_vector(6 downto 0);
        hex4            : in     vl_logic_vector(6 downto 0);
        hex5            : in     vl_logic_vector(6 downto 0);
        hex6            : in     vl_logic_vector(6 downto 0);
        hex7            : in     vl_logic_vector(6 downto 0);
        leds            : in     vl_logic_vector(3 downto 0);
        top_hexout      : in     vl_logic_vector(31 downto 0);
        sampler_rx      : in     vl_logic
    );
end wrapper_vlg_check_tst;
