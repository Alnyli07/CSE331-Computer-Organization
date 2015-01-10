library verilog;
use verilog.vl_types.all;
entity aluModul is
    port(
        Funct           : in     vl_logic_vector(5 downto 0);
        Shamt           : in     vl_logic_vector(4 downto 0);
        Rs              : in     vl_logic_vector(31 downto 0);
        Rt              : in     vl_logic_vector(31 downto 0);
        Result          : out    vl_logic_vector(31 downto 0);
        carryOut        : out    vl_logic;
        Zero            : out    vl_logic;
        overFlow        : out    vl_logic
    );
end aluModul;
