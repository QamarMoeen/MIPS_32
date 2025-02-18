library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity execute is
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
end entity;


architecture behv of execute is

BEGIN

	process(PC4)
	variable alu_output,branch_offset,temp_branch_addr : std_logic_vector(31 downto 0);
	variable zero : std_logic;
	variable operand2 : std_logic_vector(31 downto 0);
	BEGIN
			if(ALUSrc = '0') then
				operand2 := register_rt;
			else
				operand2 := immediate;
			end if;
		
	
			case ALUOp is
				when "00" =>  -- LOAD and STORE and ADDI
					alu_output := register_rs + operand2;
					zero := '0';
				
				when "01" =>  --Branch
					alu_output := register_rs - register_rt;
					
					if(alu_output = X"00000000") then
						zero := '1';
					else 
						zero := '0';
					end if;
				
				when "10" =>   --R-TYPE
					case immediate(5 downto 0) is
						when "100000" => --ADD
							alu_output := register_rs + operand2;
						when "100010" => --SUBTRACT
							alu_output := register_rs - register_rt;
						when others =>
							alu_output := X"FFFFFFFF";
					end case;
				
				when others =>
					alu_output := X"FFDEFEAF";
					
			end case;
			
			branch_offset := immediate;
			temp_branch_addr := PC4 + branch_offset;
			branch_decision <= (beq_control and zero);
			branch_addr <= temp_branch_addr;
			alu_result <= alu_output;
		
	
	END process;

END behv;