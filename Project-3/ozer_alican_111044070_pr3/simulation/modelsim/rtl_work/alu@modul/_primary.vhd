library verilog;
use verilog.vl_types.all;
entity aluModul is
    generic(
        ADDI            : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi1, Hi0, Hi0, Hi0);
        ADDIU           : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi1, Hi0, Hi0, Hi1);
        ANDI            : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi1, Hi1, Hi0, Hi0);
        ORI             : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi1, Hi1, Hi0, Hi1);
        LUI             : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi1, Hi1, Hi1, Hi1);
        SLTIU           : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi1, Hi0, Hi1, Hi1);
        SLTI            : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi1, Hi0, Hi1, Hi0);
        BEQ             : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi0, Hi1, Hi0, Hi0);
        BNE             : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi0, Hi1, Hi0, Hi1)
    );
    port(
        OPCode          : in     vl_logic_vector(5 downto 0);
        Rs              : in     vl_logic_vector(31 downto 0);
        Rt              : in     vl_logic_vector(31 downto 0);
        Immediate       : in     vl_logic_vector(31 downto 0);
        Result          : out    vl_logic_vector(31 downto 0);
        carryOut        : out    vl_logic;
        Zero            : out    vl_logic;
        overFlow        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ADDI : constant is 1;
    attribute mti_svvh_generic_type of ADDIU : constant is 1;
    attribute mti_svvh_generic_type of ANDI : constant is 1;
    attribute mti_svvh_generic_type of ORI : constant is 1;
    attribute mti_svvh_generic_type of LUI : constant is 1;
    attribute mti_svvh_generic_type of SLTIU : constant is 1;
    attribute mti_svvh_generic_type of SLTI : constant is 1;
    attribute mti_svvh_generic_type of BEQ : constant is 1;
    attribute mti_svvh_generic_type of BNE : constant is 1;
end aluModul;
