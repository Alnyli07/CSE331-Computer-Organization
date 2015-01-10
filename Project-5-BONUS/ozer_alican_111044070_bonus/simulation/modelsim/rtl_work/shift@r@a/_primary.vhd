library verilog;
use verilog.vl_types.all;
entity shiftRA is
    port(
        inner           : in     vl_logic_vector(31 downto 0);
        shamt           : in     vl_logic_vector(4 downto 0);
        result          : out    vl_logic_vector(31 downto 0)
    );
end shiftRA;
