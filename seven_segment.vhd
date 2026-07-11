library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seven_segment is
    Port (
        input_code : in  STD_LOGIC_VECTOR(1 downto 0);
        seg        : out STD_LOGIC_VECTOR(6 downto 0)
    );
end seven_segment;

architecture Behavioral of seven_segment is
begin

process(input_code)
begin

    case input_code is

        when "00" =>
            -- U (Unlocked)
            seg <= "1000001";

        when "01" =>
            -- E (Error)
            seg <= "0000110";

        when "10" =>
            -- A (Alarm)
            seg <= "0001000";

        when others =>
            -- Blank
            seg <= "1111111";

    end case;

end process;

end Behavioral;