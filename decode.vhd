library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity decode is port (
instruction : in STD_LOGIC_VECTOR (31 downto 0);
immediate,jump_addr : out STD_LOGIC_VECTOR (31 downto 0);
register_rs, register_rt,register_rd : out STD_LOGIC_VECTOR(31 downto 0); 
clock,reset : in STD_LOGIC;
RegDst,RegWrite,MemToReg : in STD_LOGIC;
memory_data,alu_result : in STD_LOGIC_VECTOR(31 downto 0);
PC : in std_LOGIC_VECTOR(31 downto 0)
);
end decode;



architecture Behavioral of decode is
type reg_array is array (0 to 31) of std_logic_vector (31 downto 0);
shared variable RegFile: reg_array := (--initialize the Register File
						X"00000000",--Register ZERO Register One
						X"00000001",
						X"00000002",
						X"00000003",
						X"00000004",
						X"00000005",
						X"00000006",
						X"00000007",
						X"00000008",
						X"00000009",
						X"0000000A",
						X"0000000B",
						X"0000000C",
						X"0000000D",
						X"0000000E",
						X"0000000F",
						X"00000010",
						X"00000011",
						X"00000012",
						X"00000013",
						X"00000014",
						X"00000015",
						X"00000016",
						X"00000017",
						X"00000018",
						X"00000019",
						X"0000001A",
						X"0000001B",
						X"0000001C",
						X"0000001D",
						X"0000001E",
						X"0000001F",
					others =>
						X"01010101");
begin

	--Process to write the register file when required
	reg_write: process (reset, memory_data, alu_result, clock)
	variable write_value: std_logic_vector (31 downto 0);
	--variable addrl, addr2, addr3: std_logic_vector(4 downto 0);
	variable write_register: std_LOGIC_VECTOR(4 downto 0);
	variable index: integer := 0;
	begin
	--on reset initialize the registers
		if (reset = '1') then
			RegFile := (
				X"00000000",--Register ZERO Register One
						X"00000001",
						X"00000002",
						X"00000003",
						X"00000004",
						X"00000005",
						X"00000006",
						X"00000007",
						X"00000008",
						X"00000009",
						X"0000000A",
						X"0000000B",
						X"0000000C",
						X"0000000D",
						X"0000000E",
						X"0000000F",
						X"00000010",
						X"00000011",
						X"00000012",
						X"00000013",
						X"00000014",
						X"00000015",
						X"00000016",
						X"00000017",
						X"00000018",
						X"00000019",
						X"0000001A",
						X"0000001B",
						X"0000001C",
						X"0000001D",
						X"0000001E",
						X"0000001F",
					others =>
						X"01010101");

		elsif(clock'event and clock='1') then
			--determine the address of the register to be written, use Figure 8-3 to implement
				if (RegDst = '0') then
			--value should be written to register number availble at instruction (20 downto 16)
					write_register := instruction(20 downto 16);
				else
			--value should be written to register number availble at instruction instruction (15 downto 11)
					write_register := instruction(15 downto 11);
				end if;
			--Remember for Approach 1, we need to have the integer index to access our Register File, use conv_integer
			--to convert std logic vector to integer value
			index := conv_integer(write_register);
			--Determine the source operand to be written, i.e., memory or alu result
			if (RegWrite = '1') then
				if (MemToReg = '1') then
					write_value := memory_data;
				else
					write_value := alu_result;
				end if;
				
				RegFile(index) := write_value;
			end if;
			
			
		end if;
	end process;
	--- Store write value to the destination register 
	---(need to disable this when you test other functions)
	
	
	
	--Process to read register file and pass the operands to the execute module
	reg_read: process(instruction)
	variable rt, rs, imm, rd: std_logic_vector(31 downto 0);
	variable addr1, addr2: integer := 0;
	variable addr_rd: integer := 0;
	begin
		--register addresses for reading the registers
		--addrl will contain the index for Register File to read register rs, availabe at instruction (25 downto 21)
			addr1 := conv_integer(instruction(25 downto 21));
		--addr2 will contain the index for Register File to read register rt, availabe at instruction (20 downto 16)); 
			addr2 := conv_integer(instruction(20 downto 16));
		--addr_rd will contain the index for Register File to read register rd, availabe at instruction (15 downto 11));
			addr_rd := conv_integer(instruction(15 downto 11));
		--read the register
		rs:= RegFile (addr1);
		rt:= RegFile (addr2);
		rd:= RegFile (addr_rd);

		--access immediate from instruction and perform sign extension
		imm (15 downto 0) := instruction (15 downto 0);
		if (instruction (15) = '1') then
			imm (31 downto 16):=x"ffff";
		else
			imm( 31 downto 16) := X"0000";
		end if;
		--compute the jump address.
		jump_addr (31 downto 0) <= "000000" & instruction(25 downto 0);
		--bring out signals to the ports of the module
		register_rs <= rs ;
		register_rt <= rt;
		register_rd <= rd;
		immediate <= imm;
		--you may add rd as well for testing
	end process reg_read;
end Behavioral;