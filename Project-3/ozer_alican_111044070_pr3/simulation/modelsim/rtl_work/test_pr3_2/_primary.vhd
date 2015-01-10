library verilog;
use verilog.vl_types.all;
entity test_pr3_2 is
    generic(
        numOfInstruction: integer := 128;
        delayTime       : vl_notype
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of numOfInstruction : constant is 1;
    attribute mti_svvh_generic_type of delayTime : constant is 3;
end test_pr3_2;
