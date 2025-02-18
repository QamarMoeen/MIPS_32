library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity memory is
generic (module_delay : time := 10 ns);
port(
		reset : in std_logic;
		address : in std_logic_vector(31 downto 0);
		write_data : in std_logic_vector(31 downto 0);
		MemWrite, MemRead : in std_logic;
		read_data : out std_logic_vector(31 downto 0)
);
end memory;

architecture behv of memory is

type mem_array is array (0 to 31) of std_logic_vector(31 downto 0);
shared variable data_memory: mem_array;
begin
	datamem_Write:process(address,MemWrite)
	begin
	
	if (MemWrite = '1') then
		data_memory(conv_integer(address(3 downto 0))) := write_data;
	end if;
	end process;
	
	
	datamem_Read:process(address,MemRead)
	variable readData : std_logic_vector(31 downto 0); 
	variable index : integer;
	begin
		if (MemRead = '1') then
			index := conv_integer(address(3 downto 0));
			readData := data_memory(index);
		end if;
			read_data <= readData;
	end process;
	
	
	
end behv;