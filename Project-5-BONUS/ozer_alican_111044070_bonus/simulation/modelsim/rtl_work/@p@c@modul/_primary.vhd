library verilog;
use verilog.vl_types.all;
entity PCModul is
    port(
        PCin            : in     vl_logic_vector(31 downto 0);
        PCOut           : out    vl_logic_vector(31 downto 0)
    );
end PCModul;
