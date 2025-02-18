library ieee;
use ieee.std_logic_1164.all;


entity control is 
port(
		instruction : in std_logic_vector(31 downto 0);
		reset : in std_logic;
		jump_desicion,branch_decision : out std_logic;
		RegDst,RegWrite,MemToReg,MemRead,MemWrite,ALUSrc : out std_logic;
		ALUOp : out std_logic_vector(1 downto 0)
	
);
end control;


architecture behv of control is

begin
	process(instruction,reset)
	variable opcode : std_logic_vector(5 downto 0);
	begin
		if reset = '1' then
			RegDst <= '0';
			ALUSrc <= '0';
			MemToReg <= '0';
			RegWrite <= '0';
			MemRead <= '0';
			MemWrite <= '0';
			ALUOp <= "00";
			jump_desicion <= '0';
			branch_decision <= '0';
		else
			opcode := instruction(31 downto 26);
			
			case opcode is
			
				when "000000" =>   -- R type instruction
					RegDst <= '1';
					ALUSrc <= '0';
					MemToReg <= '0';
					RegWrite <= '1';
					MemRead <= '0';
					MemWrite <= '0';
					ALUOp <= "10";
					jump_desicion <= '0';
					branch_decision <= '0';
					
				when "100011" =>		-- LW 
					RegDst <= '0';
					ALUSrc <= '1';
					MemToReg <= '1';
					RegWrite <= '1';
					MemRead <= '1';
					MemWrite <= '0';
					ALUOp <= "00";
					jump_desicion <= '0';
					branch_decision <= '0';
					
				when "101011" =>	--SW
					RegDst <= '0';
					ALUSrc <= '1';
					MemToReg <= '0';
					RegWrite <= '0';
					MemRead <= '0';
					MemWrite <= '1';
					ALUOp <= "00";
					jump_desicion <= '0';
					branch_decision <= '0';
					
				when "000100" =>	--BEQ
					RegDst <= '0';
					ALUSrc <= '0';
					MemToReg <= '0';
					RegWrite <= '0';
					MemRead <= '0';
					MemWrite <= '0';
					ALUOp <= "01";
					jump_desicion <= '0';
					branch_decision <= '1';
					
				when "000010" =>  --Jump
					RegDst <= '0';
					ALUSrc <= '0';
					MemToReg <= '0';
					RegWrite <= '0';
					MemRead <= '0';
					MemWrite <= '0';
					ALUOp <= "00";
					jump_desicion <= '1';
					branch_decision <= '0';
					
				when "001000" =>  --ADDI
					RegDst <= '0';
					ALUSrc <= '1';
					MemToReg <= '0';
					RegWrite <= '1';
					MemRead <= '0';
					MemWrite <= '0';
					ALUOp <= "00";
					jump_desicion <= '0';
					branch_decision <= '0';
					
				when others =>
					RegDst <= '0';
					ALUSrc <= '0';
					MemToReg <= '0';
					RegWrite <= '0';
					MemRead <= '0';
					MemWrite <= '0';
					ALUOp <= "00";
					jump_desicion <= '0';
					branch_decision <= '0';
			end case;
		end if;
	end process;
end behv;