library verilog;
use verilog.vl_types.all;
entity dataMemory is
    generic(
        RAMSIZE         : integer := 12
    );
    port(
        address         : in     vl_logic_vector(31 downto 0);
        wrEn            : in     vl_logic;
        clk             : in     vl_logic;
        data_in         : in     vl_logic_vector(31 downto 0);
        data_out        : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of RAMSIZE : constant is 1;
end dataMemory;
