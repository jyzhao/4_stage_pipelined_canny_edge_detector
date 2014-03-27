library verilog;
use verilog.vl_types.all;
entity Sobel is
    generic(
        X1              : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1);
        X2              : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        X3              : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1);
        X4              : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0);
        X5              : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        X6              : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0);
        X7              : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1);
        X8              : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        X9              : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1);
        Y1              : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1);
        Y2              : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0);
        Y3              : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1);
        Y4              : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        Y5              : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        Y6              : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        Y7              : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1);
        Y8              : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0);
        Y9              : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1)
    );
    port(
        iCLK            : in     vl_logic;
        iRST_N          : in     vl_logic;
        iTHRESHOLD      : in     vl_logic_vector(7 downto 0);
        iDVAL           : in     vl_logic;
        iDATA           : in     vl_logic_vector(9 downto 0);
        oDVAL           : out    vl_logic;
        oDATA           : out    vl_logic_vector(9 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of X1 : constant is 1;
    attribute mti_svvh_generic_type of X2 : constant is 1;
    attribute mti_svvh_generic_type of X3 : constant is 1;
    attribute mti_svvh_generic_type of X4 : constant is 1;
    attribute mti_svvh_generic_type of X5 : constant is 1;
    attribute mti_svvh_generic_type of X6 : constant is 1;
    attribute mti_svvh_generic_type of X7 : constant is 1;
    attribute mti_svvh_generic_type of X8 : constant is 1;
    attribute mti_svvh_generic_type of X9 : constant is 1;
    attribute mti_svvh_generic_type of Y1 : constant is 1;
    attribute mti_svvh_generic_type of Y2 : constant is 1;
    attribute mti_svvh_generic_type of Y3 : constant is 1;
    attribute mti_svvh_generic_type of Y4 : constant is 1;
    attribute mti_svvh_generic_type of Y5 : constant is 1;
    attribute mti_svvh_generic_type of Y6 : constant is 1;
    attribute mti_svvh_generic_type of Y7 : constant is 1;
    attribute mti_svvh_generic_type of Y8 : constant is 1;
    attribute mti_svvh_generic_type of Y9 : constant is 1;
end Sobel;
