library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_maker is
  port (
    CLK        : in  std_logic;
    RST_n      : in  std_logic;
    VOUT       : out std_logic;
    DOUT       : out std_logic_vector(8 downto 0);
    a1, c2, c3 : out std_logic_vector(8 downto 0);
    b0, b1, b2 : out std_logic_vector(8 downto 0);
    END_SIM    : out std_logic);
end data_maker;

architecture beh of data_maker is

  constant tco     : time    := 1 ns;
  signal i         : integer := 0;
  signal sEndSim   : std_logic;
  signal END_SIM_i : std_logic_vector(0 to 10);

begin  -- beh

  a1 <= conv_std_logic_vector(95, 9);
  c2 <= conv_std_logic_vector(-15, 9);
  c3 <= conv_std_logic_vector(-19, 9);
  b0 <= conv_std_logic_vector(52, 9);
  b1 <= conv_std_logic_vector(105, 9);
  b2 <= conv_std_logic_vector(52, 9);

  process (CLK, RST_n, i)               --modify path
    file fp_in       : text open read_mode is "../samples.txt";
    variable line_in : line;
    variable x       : integer;
  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      DOUT    <= (others => '0') after tco;
      VOUT    <= '0'             after tco;
      sEndSim <= '0'             after tco;
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      if not endfile(fp_in) then
        if i = 15 then
          VOUT <= '0' after tco;
          i    <= i+1;
        else
          readline(fp_in, line_in);
          read(line_in, x);
          DOUT    <= conv_std_logic_vector(x, 9) after tco;
          VOUT    <= '1'                         after tco;
          sEndSim <= '0'                         after tco;
          i       <= i+1;
        end if;
      else
        VOUT    <= '0' after tco;
        sEndSim <= '1' after tco;
      end if;
    end if;
  end process;

  process (CLK, RST_n)
  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      END_SIM_i <= (others => '0') after tco;
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      END_SIM_i(0)       <= sEndSim           after tco;
      END_SIM_i(1 to 10) <= END_SIM_i(0 to 9) after tco;
    end if;
  end process;

  END_SIM <= END_SIM_i(10);

end beh;
