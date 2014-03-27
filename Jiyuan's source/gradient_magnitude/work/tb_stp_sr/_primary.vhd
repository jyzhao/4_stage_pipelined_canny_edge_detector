library verilog;
use verilog.vl_types.all;
entity tb_stp_sr is
    generic(
        PERIOD          : real    := 2.500000e+00
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of PERIOD : constant is 1;
end tb_stp_sr;
