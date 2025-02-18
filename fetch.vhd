library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity fetch is
port (
	PC_out : out STD_LOGIC_VECTOR (31 downto 0);
	instruction : out STD_LOGIC_VECTOR (31 downto 0);
	branch_addr, jump_addr : in STD_LOGIC_VECTOR (31 downto 0);
	branch_decision, jump_decision, reset, clock : in std_logic
);
end fetch;


architecture bhv of fetch is --instruction memory is created as an array of 32bits and has 16 locations
type mem_array is array (0 to 15) of std_logic_vector(31 downto 0);
begin 
process(clock,reset)
--initialize the instruction memory
variable mem: mem_array := (--X"20010001", --ADDI $1,$zero,1
									--X"20040004", --ADDI $4,$zero,4
									--X"20020001", --ADDI $2,$zero,1
									--X"AC210000", --SW $1,0($1)
									--X"AC420000", --SW $2,0($2)
									--X"AC840000", --SW $4,0($4)
									--X"8c220000", --L: lw $2, 0($1) ; $2 <= mem[0+$1] 
									--X"8c640001", -- lw $4, 1($3) ; $4 <= mem[1+$3] 
									--X"00622022", -- sub $4, $3, $2 ; $4 <= $3 - $2 
									--X"ac640000", -- sw $4, 0($3) ; mem[0+$3] <=$4 
									--X"10220003", -- beq $1, $2, L ; if ($1=$2), branch_addr<=L 
									--X"00612064", -- and $4, $3, $1 ; $4 <= $3 and $4
									X"AC210000", --START: SW $1, 0($1)
									X"8C270000", --LW $7, 0($1)
									X"AC450000", --SW $5, 0($2)
									X"8C480000", --LW $8, 0($2)
									X"00E53820", --ADD $7,$7,$5
									X"21080002", --ADDI $8,$8,2
									X"01014022", --SUB $8,$8,$1
									X"10E8FFF8", --LABEL: BEQ $7,$8,LABEL
									X"08000000", --J START 
								
									X"08000000", -- j L ; jump_addr <= L 
									X"00000000",										--7
									X"00E83020",										--8
									X"01FB4820",										--9
									X"1111000E", --beq $8,$17,14					--10
									--X"08000009", --j 9								--11
									X"00020820",										--11
									X"00020820"										--12
									
);
variable PC: std_logic_vector(31 downto 0);
variable index : integer := 0;
begin

	if reset = '1' then
			PC := X"00000000";
			PC_out <= X"00000000";
			instruction <= X"00000000";
	
	elsif (clock'event and clock='1') then
		if (branch_decision = '1') then 
			PC := branch_addr; 
		elsif (jump_decision ='1') then 
			PC := jump_addr;
		
		end if;
		 
		index := conv_integer(PC(3 downto 0));
		
		instruction <= mem (index);
		PC := PC + "1";
		PC_out <= PC;

	end if;
	
	
end process;
end bhv;