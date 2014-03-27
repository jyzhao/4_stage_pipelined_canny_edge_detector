library verilog;
use verilog.vl_types.all;
entity magnitude is
    port(
        gx              : in     vl_logic_vector(7 downto 0);
        gy              : in     vl_logic_vector(7 downto 0);
        gmag            : out    vl_logic_vector(7 downto 0)
    );
end magnitude;
