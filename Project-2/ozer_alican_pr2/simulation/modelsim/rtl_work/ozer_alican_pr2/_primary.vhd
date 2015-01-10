library verilog;
use verilog.vl_types.all;
entity ozer_alican_pr2 is
    port(
        reg32           : in     vl_logic_vector(31 downto 0);
        result          : out    vl_logic_vector(31 downto 0)
    );
end ozer_alican_pr2;
