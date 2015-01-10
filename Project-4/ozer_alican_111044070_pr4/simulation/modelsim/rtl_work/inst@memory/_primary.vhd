library verilog;
use verilog.vl_types.all;
entity instMemory is
    port(
        PC_in           : in     vl_logic_vector(31 downto 0);
        clock           : in     vl_logic;
        instruction     : out    vl_logic_vector(31 downto 0);
        PC_out          : out    vl_logic_vector(31 downto 0)
    );
end instMemory;
