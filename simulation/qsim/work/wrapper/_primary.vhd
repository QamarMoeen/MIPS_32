library verilog;
use verilog.vl_types.all;
entity wrapper is
    port(
        TOP_clock       : in     vl_logic;
        TOP_reset       : in     vl_logic;
        leds            : out    vl_logic_vector(3 downto 0);
        opt             : in     vl_logic_vector(2 downto 0);
        hex0            : out    vl_logic_vector(6 downto 0);
        hex1            : out    vl_logic_vector(6 downto 0);
        hex2            : out    vl_logic_vector(6 downto 0);
        hex3            : out    vl_logic_vector(6 downto 0);
        hex4            : out    vl_logic_vector(6 downto 0);
        hex5            : out    vl_logic_vector(6 downto 0);
        hex6            : out    vl_logic_vector(6 downto 0);
        hex7            : out    vl_logic_vector(6 downto 0);
        top_hexout      : out    vl_logic_vector(31 downto 0)
    );
end wrapper;
