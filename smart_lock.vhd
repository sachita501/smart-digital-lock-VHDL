library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity smart_lock is
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
end smart_lock;

architecture Behavioral of smart_lock is

    constant PASSWORD : STD_LOGIC_VECTOR(3 downto 0) := "1010";

    signal attempts : integer range 0 to 3 := 0;

begin

process(clk, reset)

begin

    if reset='1' then

        attempts <= 0;

        unlock_led <= '0';
        wrong_led  <= '0';
        alarm_led  <= '0';

        display <= "1111111";

    elsif rising_edge(clk) then

        unlock_led <= '0';
        wrong_led  <= '0';

        if enter='1' then

            if key_data = PASSWORD then

                unlock_led <= '1';
                alarm_led  <= '0';
                attempts <= 0;

                -- U (Unlocked)
                display <= "1000001";

            else

                wrong_led <= '1';

                if attempts < 3 then
                    attempts <= attempts + 1;
                end if;

                if attempts = 2 then
                    alarm_led <= '1';

                    -- A (Alarm)
                    display <= "0001000";

                else

                    -- E (Error)
                    display <= "0000110";

                end if;

            end if;

        end if;

    end if;

end process;

end Behavioral;