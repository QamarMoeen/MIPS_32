library ieee;
use ieee.std_logic_1164.all;

Package my_components is

		Procedure seg_7 (signal sin: in std_logic_vector(3 downto 0);
							  signal sout: out std_logic_vector(6 downto 0));
		component fetch is
				port (
						PC_out : out STD_LOGIC_VECTOR (31 downto 0);
						instruction : out STD_LOGIC_VECTOR (31 downto 0);
						branch_addr, jump_addr : in STD_LOGIC_VECTOR (31 downto 0);
						branch_decision, jump_decision, reset, clock : in std_logic
						);
		end component;
		
		component decode is 
				port (
						instruction : in STD_LOGIC_VECTOR (31 downto 0);
						immediate,jump_addr : out STD_LOGIC_VECTOR (31 downto 0);
						register_rs, register_rt,register_rd : out STD_LOGIC_VECTOR(31 downto 0); 
						clock,reset : in STD_LOGIC;
						RegDst,RegWrite,MemToReg : in STD_LOGIC;
						memory_data,alu_result : in STD_LOGIC_VECTOR(31 downto 0);
						PC : in std_LOGIC_VECTOR(31 downto 0)
						);
		end component;
		
		
		component control is 
				port(
						instruction : in std_logic_vector(31 downto 0);
						reset : in std_logic;
						jump_desicion,branch_decision : out std_logic;
						RegDst,RegWrite,MemToReg,MemRead,MemWrite,ALUSrc : out std_logic;
						ALUOp : out std_logic_vector(1 downto 0)
	
		);
		end component;
		
		
		component memory is
				port(
						reset : in std_logic;
						address : in std_logic_vector(31 downto 0);
						write_data : in std_logic_vector(31 downto 0);
						MemWrite, MemRead : in std_logic;
						read_data : out std_logic_vector(31 downto 0)
				);
		end component;
		
		
		
		component execute is
					port(
						register_rs : in std_logic_vector(31 downto 0);
						register_rt : in std_logic_vector(31 downto 0);
						PC4,immediate : in std_logic_vector(31 downto 0);
						ALUOp : in std_logic_vector(1 downto 0);
						ALUSrc : in std_logic;
						beq_control : in std_logic;
						alu_result : out std_logic_vector(31 downto 0);
						branch_addr : out std_logic_vector(31 downto 0);
						branch_decision : out std_logic
					);
		end component;


end Package;

Package Body my_components is

	Procedure seg_7(signal sin: in std_logic_vector(3 downto 0); signal sout: out std_logic_vector(6 downto 0)) is
	BEGIN
	
		case sin is
			when "0000" => sout <= "1000000" ;
			when "0001" => sout <= "1111001" ;
			when "0010" => sout <= "0100100" ;
			when "0011" => sout <= "0110000" ;
			when "0100" => sout <= "0011001" ;
			when "0101" => sout <= "0010010" ;
			when "0110" => sout <= "0000010" ;
			when "0111" => sout <= "1111000" ;
			when "1000" => sout <= "0000000" ;
			when "1001" => sout <= "0011000" ;
			when "1010" => sout <= "0001000" ;
			when "1011" => sout <= "0000011" ;
			when "1100" => sout <= "1000110" ;
			when "1101" => sout <= "0100001" ;
			when "1110" => sout <= "0000110" ;
			when "1111" => sout <= "0001110" ;
		end case;
	end procedure seg_7;
end package body;
