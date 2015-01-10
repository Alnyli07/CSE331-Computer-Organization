library verilog;
use verilog.vl_types.all;
entity DATAMemory is
    generic(
        RAMSIZE         : integer := 12
    );
    port(
        Address         : in     vl_logic_vector(31 downto 0);
        WriteData       : in     vl_logic_vector(31 downto 0);
        WrEn            : in     vl_logic;
        ReadData        : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of RAMSIZE : constant is 1;
end DATAMemory;
