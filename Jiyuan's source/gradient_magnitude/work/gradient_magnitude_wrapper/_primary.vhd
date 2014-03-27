library verilog;
use verilog.vl_types.all;
entity gradient_magnitude_wrapper is
    port(
        wrapper_p2      : in     vl_logic_vector(7 downto 0);
        wrapper_p5      : in     vl_logic_vector(7 downto 0);
        wrapper_p8      : in     vl_logic_vector(7 downto 0);
        wrapper_p4      : in     vl_logic_vector(7 downto 0);
        wrapper_p6      : in     vl_logic_vector(7 downto 0);
        wrapper_gx      : out    vl_logic_vector(7 downto 0);
        wrapper_gy      : out    vl_logic_vector(7 downto 0);
        wrapper_gmag    : out    vl_logic_vector(7 downto 0)
    );
end gradient_magnitude_wrapper;
