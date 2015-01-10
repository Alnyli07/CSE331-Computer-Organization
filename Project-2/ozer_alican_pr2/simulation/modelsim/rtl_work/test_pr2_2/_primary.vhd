library verilog;
use verilog.vl_types.all;
entity test_pr2_2 is
    generic(
        maxLine         : integer := 11
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of maxLine : constant is 1;
end test_pr2_2;
