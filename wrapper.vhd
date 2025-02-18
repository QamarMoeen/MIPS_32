library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.my_components.all;

entity wrapper is
port(
	FPGA_clock : in std_logic;
	TOP_reset : in std_logic;
	leds : out std_logic_vector(3 downto 0);
	opt : in std_logic_vector(2 downto 0);
	hex0: out std_logic_vector(6 downto 0);
	hex1: out std_logic_vector(6 downto 0);
	hex2: out std_logic_vector(6 downto 0);
	hex3: out std_logic_vector(6 downto 0);
	hex4: out std_logic_vector(6 downto 0);
	hex5: out std_logic_vector(6 downto 0);
	hex6: out std_logic_vector(6 downto 0);
	hex7: out std_logic_vector(6 downto 0);
	top_hexout : out std_logic_vector(31 downto 0)
);
end wrapper;


architecture behv of wrapper is

signal TOP_PC : std_logic_vector(31 downto 0);
signal top_instruction : std_logic_vector(31 downto 0);
signal hexout : std_logic_vector(31 downto 0);
signal top_imm,top_jaddr : std_logic_vector(31 downto 0);
signal top_branchaddr : std_logic_vector(31 downto 0);
signal top_branchdecision,top_jumpdecision : std_logic;
signal top_branchcontrol : std_logic;
signal top_rs,top_rt,top_rd : std_logic_vector(31 downto 0);
signal top_RegDst,top_RegWrite,top_MemToReg : std_logic;
signal top_MemRead, top_MemWrite, top_ALUSrc : std_logic;
signal top_ALUOp : std_logic_vector(1 downto 0);
signal top_memory_data : std_logic_vector(31 downto 0);
signal top_result : std_logic_vector(31 downto 0);
signal TOP_clock : std_logic;
signal count : std_logic_vector(31 downto 0);

begin

	process(FPGA_clock)
	begin
	if(FPGA_clock'event and FPGA_clock = '1') then
		count <= count + 1;
	end if;
	end process;
	
	TOP_Clock <= count(29);
	
		Step1: fetch PORT MAP(clock => TOP_clock,
							reset => TOP_reset,
							branch_decision=> top_branchdecision,
							jump_decision=> top_jumpdecision,
							instruction => top_instruction,
							PC_out => TOP_PC,
							branch_addr => top_branchaddr,
							jump_addr => top_jaddr
		);

		leds <= TOP_PC(3 downto 0);
		
		Step2: decode PORT MAP(
										instruction => top_instruction, 
										immediate => top_imm,
										jump_addr => top_jaddr,
										register_rs => top_rs, 
										register_rt => top_rt,
										register_rd => top_rd,
										clock => TOP_clock,
										reset => TOP_reset,
										RegDst => top_RegDst,
										RegWrite => top_RegWrite,
										MemToReg => top_MemToReg,
										memory_data => top_memory_data,
										alu_result => top_result,
										PC => TOP_PC
		);
		
		
		Step3: control port map(
										instruction => top_instruction,
										reset => top_reset,
										jump_desicion => top_jumpdecision,
										branch_decision => top_branchcontrol,
										RegDst => top_RegDst,
										RegWrite => top_RegWrite,
										MemToReg => top_MemToReg,
										MemRead => top_MemRead,
										MemWrite => top_MemWrite,
										ALUSrc => top_ALUSrc,
										ALUOp => top_ALUOp
		);
		
		Step4: execute port map(
										register_rs => top_rs,
										register_rt => top_rt,
										PC4 => top_PC,
										immediate => top_imm,
										ALUOp => top_ALUOp,
										ALUSrc => top_ALUSrc,
										beq_control => top_branchcontrol,
										alu_result => top_result,
										branch_addr => top_branchaddr,
										branch_decision => top_branchdecision
		);
		
		Step5: memory port map(
										reset => top_reset,
										address => top_result,
										write_data => top_rt,
										MemWrite => top_MemWrite,
										MemRead => top_MemRead,
										read_data => top_memory_data
		);
		
		top_hexout <= hexout;
		hexout <= top_instruction  when (opt = "000") else
							top_rs  when (opt = "001") else
							top_rt  when (opt = "010") else
							top_rd  when (opt = "011") else
				 top_branchaddr  when (opt = "100") else
						top_jaddr  when (opt = "101") else
				top_memory_data  when (opt = "110") else
				     top_result  when (opt = "111") ;
		
	
		seg_7(hexout(31 downto 28), hex7);
		seg_7(hexout(27 downto 24), hex6);
		seg_7(hexout(23 downto 20), hex5);
		seg_7(hexout(19 downto 16), hex4);
		seg_7(hexout(15 downto 12), hex3);
		seg_7(hexout(11 downto 8), hex2);
		seg_7(hexout(7 downto 4), hex1);
		seg_7(hexout(3 downto 0), hex0);

end behv;
