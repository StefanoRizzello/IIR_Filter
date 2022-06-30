library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity iir_filter is
  port (

    clock : in std_logic;
    rst_n : in std_logic;
    din : in std_logic_vector(8 downto 0);
    a1, a2 : in std_logic_vector(8 downto 0);
    b0, b1, b2 : in std_logic_vector(8 downto 0);
    vin : in std_logic;
    dout : out std_logic_vector(8 downto 0);
    vout : out std_logic
  );
end iir_filter;

architecture arch of iir_filter is
  component reg is
    generic (
      N : integer);
    port (
      D : in std_logic_vector(N - 1 downto 0);
      clock, reset, enable : in std_logic;
      Q : out std_logic_vector(N - 1 downto 0));
  end component reg;

  component ff is
    port (
      D : in std_logic;
      clock, reset, enable : in std_logic;
      Q : out std_logic);
  end component ff;

  signal tmp_a_slv, tmp_b_slv, q_reg1, q_reg2 : std_logic_vector(8 downto 0);
  signal din_s : signed(8 downto 0);
  signal a1_s, a2_s, b0_s, b1_s, b2_s : signed(8 downto 0);
  signal TMPq1_a1 : signed(17 downto 0);
  signal TMPq2_a2 : signed(17 downto 0);
  signal TMPtmpa_b0 : signed(17 downto 0);
  signal TMPq1_b1 : signed(17 downto 0);
  signal TMPq2_b2 : signed(17 downto 0);
  signal TMPa : signed(8 downto 0);
  signal TMPb : signed(8 downto 0);

begin
  TMPq1_a1 <= signed(q_reg1) * a1_s;
  TMPq2_a2 <= signed(q_reg2) * a2_s;
  TMPa <= din_s + (TMPq1_a1(16 downto 8) + TMPq2_a2(16 downto 8));

  TMPtmpa_b0 <= TMPa * b0_s;
  TMPq1_b1 <= signed(q_reg1) * b1_s;
  TMPq2_b2 <= signed(q_reg2) * b2_s;
  TMPb <= TMPtmpa_b0(16 downto 8) + TMPq1_b1(16 downto 8) + TMPq2_b2(16 downto 8);

  -- instance "reg_1"
  reg_1 : reg
  generic map(
    N => 9)
  port map(
    D => tmp_a_slv,
    clock => clock,
    reset => rst_n,
    enable => vin,
    Q => q_reg1);

  -- instance "reg_2"
  reg_2 : reg
  generic map(
    N => 9)
  port map(
    D => q_reg1,
    clock => clock,
    reset => rst_n,
    enable => vin,
    Q => q_reg2);

  -- instance "reg_dout"
  reg_dout : reg
  generic map(
    N => 9)
  port map(
    D => tmp_b_slv,
    clock => clock,
    reset => rst_n,
    enable => vin,
    Q => dout);

    -- instance "ff"
    ff_1 : ff
    port map(
      D => vin,
      clock => clock,
      reset => rst_n,
      enable => '1',
      Q => vout);

  din_s <= signed(din);
  a1_s <= signed(a1);
  a2_s <= signed(a2);
  b0_s <= signed(b0);
  b1_s <= signed(b1);
  b2_s <= signed(b2);
  tmp_a_slv <= std_logic_vector(tmpa);
  tmp_b_slv <= std_logic_vector(tmpb);
end architecture;