library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity iir_filter is
  port (
    clock : in std_logic;
    rst_n : in std_logic;
    din : in std_logic_vector(8 downto 0);
    a1, c2, c3 : in std_logic_vector(8 downto 0); -- c1=a1*a1-a2, c2=-a1*a2
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

  -- signal decl
  signal tmp_a_slv, q_reg1, q_reg2, q_reg3, q_reg4, q_reg5, q_reg6, q_reg7, q_reg8, q_reg12, q_reg13 : std_logic_vector (7 downto 0);
  signal q_reg3_s, q_reg4_s, q_reg2_s, q_reg1_s, q_reg5_s, q_reg6_s, q_reg7_s, q_reg8_s, q_reg12_s, q_reg13_s : signed (7 downto 0);
  signal din_s, TMPa, TMP_reg1 : signed (7 downto 0);
  signal a1_s, c2_s, c3_s, b0_s, b1_s, b2_s : signed (7 downto 0);
  signal TMPq2_c2, TMPq4_c3, TMP_a1 : signed(15 downto 0);
  signal TMPq8_b0, TMPq7_b1, TMPq5_b2 : signed(15 downto 0);
  signal TMPb : signed (7 downto 0);
  signal tmp_b_slv, dout_pad: std_logic_vector(7 downto 0);
  signal vout_ff1, vout_ff2, vout_ff3 : std_logic;
  signal q_reg9, q_reg10, q_reg11 : std_logic_vector (7 downto 0);
  signal q_reg9_s, q_reg10_s, q_reg11_s : signed (7 downto 0);

begin
  TMP_a1 <= din_s * a1_s;
  TMPq4_c3 <= q_reg4_s * c3_s;
  TMPq2_c2 <= q_reg4_s * c2_s;
  TMP_reg1 <= q_reg13_s + q_reg3_s;
  TMPa <= q_reg12_s + q_reg1_s + q_reg2_s;

  TMPq8_b0 <= q_reg8_s * b0_s;
  TMPq7_b1 <= q_reg7_s * b1_s;
  TMPq5_b2 <= q_reg5_s * b2_s;
  TMPb <= q_reg11_s + q_reg10_s + q_reg9_s;
 
  -- instance reg 
  reg_1 : reg 
  generic map(
    N => 8)
  port map(
    D => std_logic_vector(TMP_reg1),
    clock => clock,
    reset => rst_n,
    enable => vin,
    Q => q_reg1);

  reg_2 : reg
  generic map(
    N => 8)
  port map(
    D => std_logic_vector(TMPq2_c2(13 downto 6)),
    clock => clock,
    reset => rst_n,
    enable => vin,
    Q => q_reg2);

  reg_3 : reg
  generic map(
    N => 8)
  port map(
    D => std_logic_vector(TMPq4_c3 (13 downto 6)),
    clock => clock,
    reset => rst_n,
    enable => vin,
    Q => q_reg3);
    
  reg_4 : reg
  generic map(
    N => 8)
  port map(
    D => tmp_a_slv,
    clock => clock,
    reset => rst_n,
    enable => vin,
    Q => q_reg4);

  reg_p2_c : reg
  generic map(
    N => 8)
  port map(
    D => q_reg6,
    clock => clock,
    reset => rst_n,
    enable => vout_ff1,
    Q => q_reg5);

  reg_5 : reg
  generic map(
    N => 8)
  port map(
    D => q_reg4,
    clock => clock,
    reset => rst_n,
    enable => vin,
    Q => q_reg6);

  reg_p2_b : reg
  generic map(
    N => 8)
  port map(
    D => q_reg4,
    clock => clock,
    reset => rst_n,
    enable => vout_ff1,
    Q => q_reg7);

  reg_p2_a : reg
  generic map(
    N => 8)
  port map(
    D => tmp_a_slv,
    clock => clock,
    reset => rst_n,
    enable => vout_ff1,
    Q => q_reg8);

  reg_p3_c : reg
  generic map(
    N => 8)
  port map(
    D => std_logic_vector(TMPq5_b2(13 downto 6)),
    clock => clock,
    reset => rst_n,
    enable => vout_ff2,
    Q => q_reg9);

  reg_p3_b : reg
  generic map(
    N => 8)
  port map(
    D => std_logic_vector(TMPq7_b1(13 downto 6)),
    clock => clock,
    reset => rst_n,
    enable => vout_ff2,
    Q => q_reg10);

  reg_p3_a : reg
  generic map(
    N => 8)
  port map(
    D => std_logic_vector(tmpq8_b0(13 downto 6)),
    clock => clock,
    reset => rst_n,
    enable => vout_ff2,
    Q => q_reg11);

  reg_p1_a : reg
  generic map(
    N => 8)
  port map(
    D => std_logic_vector(din_s),
    clock => clock,
    reset => rst_n,
    enable => vin,
    Q => q_reg12);

  reg_p1_b : reg
  generic map(
    N => 8)
  port map(
    D => std_logic_vector(TMP_a1(13 downto 6)),
    clock => clock,
    reset => rst_n,
    enable => vin,
    Q => q_reg13);

  -- instance "ff"
  ff_1 : ff
    port map(
      D      => vin,
      clock  => clock,
      reset  => rst_n,
      enable => '1',
      Q      => vout_ff1);

  -- instance "ff"
  ff_2 : ff
    port map(
      D      => vout_ff1,
      clock  => clock,
      reset  => rst_n,
      enable => '1',
      Q      => vout_ff2);

  -- instance "ff"
  ff_3 : ff
    port map(
      D      => vout_ff2,
      clock  => clock,
      reset  => rst_n,
      enable => '1',
      Q      => vout_ff3);

  -- instance "ff"
  ff_4 : ff
    port map(
      D      => vout_ff3,
      clock  => clock,
      reset  => rst_n,
      enable => '1',
      Q      => vout);


    -- instance "reg_dout"
    reg_dout : reg
    generic map(
      N => 8)
    port map(
      D      => tmp_b_slv,
      clock  => clock,
      reset  => rst_n,
      enable => vout_ff3,
      Q      => dout_pad);

  din_s <= signed(din(8) & din(8 downto 2));
  a1_s <= signed(a1(8) & a1(8 downto 2));
  c2_s <= signed(c2(8) & c2(8 downto 2));
  c3_s <= signed(c3(8) & c3(8 downto 2));
  b0_s      <= signed(b0(8) & b0(8 downto 2));
  b1_s      <= signed(b1(8) & b1(8 downto 2));
  b2_s      <= signed(b2(8) & b2(8 downto 2));
  q_reg1_s <= signed(q_reg1);
  q_reg2_s <= signed(q_reg2);
  q_reg3_s <= signed(q_reg3);
  q_reg4_s <= signed(q_reg4);
  q_reg5_s <= signed(q_reg5);
  q_reg6_s <= signed(q_reg6);
  q_reg7_s <= signed(q_reg7);
  q_reg8_s <= signed(q_reg8);
  q_reg9_s <= signed(q_reg9);
  q_reg10_s <= signed(q_reg10);
  q_reg11_s <= signed(q_reg11);
  q_reg12_s <= signed(q_reg12);
  q_reg13_s <= signed(q_reg13);  
  tmp_a_slv <= std_logic_vector(TMPa);
  tmp_b_slv <= std_logic_vector(tmpb);
  dout      <= dout_pad & '0';
end architecture;
