library verilog;
use verilog.vl_types.all;
entity instMemory is
    generic(
        memory_size     : integer := 128
    );
    port(
        PCin            : in     vl_logic_vector(31 downto 0);
        instruction     : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of memory_size : constant is 1;
end instMemory;
