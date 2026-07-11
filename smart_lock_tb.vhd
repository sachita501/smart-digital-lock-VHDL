library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity smart_lock_tb is
end smart_lock_tb;

architecture Behavioral of smart_lock_tb is

    component smart_lock
        Port (
            clk         : in  STD_LOGIC;
            reset       : in  STD_LOGIC;
            enter       : in  STD_LOGIC;
            key_data    : in  STD_LOGIC_VECTOR(3 downto 0);
            unlock_led  : out STD_LOGIC;
            wrong_led   : out STD_LOGIC;
            alarm_led   : out STD_LOGIC;
            display     : out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;

    signal clk        : STD_LOGIC := '0';
    signal reset      : STD_LOGIC := '0';
    signal enter      : STD_LOGIC := '0';
    signal key_data   : STD_LOGIC_VECTOR(3 downto 0) := "0000";

    signal unlock_led : STD_LOGIC;
    signal wrong_led  : STD_LOGIC;
    signal alarm_led  : STD_LOGIC;
    signal display    : STD_LOGIC_VECTOR(6 downto 0);

begin

    uut: smart_lock
        port map (
            clk => clk,
            reset => reset,
            enter => enter,
            key_data => key_data,
            unlock_led => unlock_led,
            wrong_led => wrong_led,
            alarm_led => alarm_led,
            display => display
        );

    -- Clock generation
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- Test sequence
    stim_proc : process
    begin

        -- Reset
        reset <= '1';
        wait for 10 ns;
        reset <= '0';

        -- Wrong Attempt 1
        key_data <= "0001";
        enter <= '1';
        wait for 10 ns;
        enter <= '0';
        wait for 20 ns;

        -- Wrong Attempt 2
        key_data <= "0010";
        enter <= '1';
        wait for 10 ns;
        enter <= '0';
        wait for 20 ns;

        -- Wrong Attempt 3 (Alarm)
        key_data <= "0011";
        enter <= '1';
        wait for 10 ns;
        enter <= '0';
        wait for 20 ns;

        -- Reset
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        wait for 20 ns;

        -- Correct Password
        key_data <= "1010";
        enter <= '1';
        wait for 10 ns;
        enter <= '0';

        wait;

    end process;

end Behavioral;
