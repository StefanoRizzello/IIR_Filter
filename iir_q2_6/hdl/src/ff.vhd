library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity ff is

  port (
    D : in std_logic;

    clock, reset, enable : in std_logic;

    Q : out std_logic);

end ff;

-------------------------------------------------------------------------------

architecture str of ff is

  -----------------------------------------------------------------------------
  -- Internal signal declarations
  -----------------------------------------------------------------------------

begin -- architecture str

  register_proc : process (clock, reset) is
  begin -- process register_proc
    if reset = '0' then -- asynchronous reset (active low)
      Q <= '0';
    elsif clock'event and clock = '1' then -- rising clock edge
      if enable = '1' then
        Q <= D;
      end if;
    end if;
  end process register_proc;

end architecture str;