library verilog;
use verilog.vl_types.all;
entity execute_vlg_check_tst is
    port(
        alu_result      : in     vl_logic_vector(31 downto 0);
        branch_addr     : in     vl_logic_vector(31 downto 0);
        branch_decision : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end execute_vlg_check_tst;
