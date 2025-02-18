library verilog;
use verilog.vl_types.all;
entity execute is
    port(
        register_rs     : in     vl_logic_vector(31 downto 0);
        register_rt     : in     vl_logic_vector(31 downto 0);
        PC4             : in     vl_logic_vector(31 downto 0);
        immediate       : in     vl_logic_vector(31 downto 0);
        ALUOp           : in     vl_logic_vector(1 downto 0);
        ALUSrc          : in     vl_logic;
        beq_control     : in     vl_logic;
        clock           : in     vl_logic;
        alu_result      : out    vl_logic_vector(31 downto 0);
        branch_addr     : out    vl_logic_vector(31 downto 0);
        branch_decision : out    vl_logic
    );
end execute;
