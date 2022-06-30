library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity reg is

  generic (N : integer := 5);

  port (
    D : in std_logic_vector(N - 1 downto 0);

    clock, reset, enable : in std_logic;

    Q : out std_logic_vector(N - 1 downto 0));

end reg;

-------------------------------------------------------------------------------

architecture str of reg is

  -----------------------------------------------------------------------------
  -- Internal signal declarations
  -----------------------------------------------------------------------------

begin -- architecture str

  register_proc : process (clock, reset) is
  begin -- process register_proc
    if reset = '0' then -- asynchronous reset (active low)
      Q <= (others => '0');
    elsif clock'event and clock = '1' then -- rising clock edge
      if enable = '1' then
        Q <= D;
      end if;
    end if;
  end process register_proc;

end architecture str;