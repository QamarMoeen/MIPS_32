library verilog;
use verilog.vl_types.all;
entity execute_vlg_sample_tst is
    port(
        ALUOp           : in     vl_logic_vector(1 downto 0);
        ALUSrc          : in     vl_logic;
        beq_control     : in     vl_logic;
        clock           : in     vl_logic;
        immediate       : in     vl_logic_vector(31 downto 0);
        PC4             : in     vl_logic_vector(31 downto 0);
        register_rs     : in     vl_logic_vector(31 downto 0);
        register_rt     : in     vl_logic_vector(31 downto 0);
        sampler_tx      : out    vl_logic
    );
end execute_vlg_sample_tst;
