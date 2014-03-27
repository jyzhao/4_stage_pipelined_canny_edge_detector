##############################################################################
# ECE 337 General Project Makefile
# 
# Set tab spacing to 2 spaces per tab for best viewing results
##############################################################################

##############################################################################
# File Related Variables
##############################################################################

# List internal component/block files here (separate the filenames with spaces)
# (do not include the source folder in the name)
# NOTE: YOU WILL NEED TO SET THIS VARIABLE'S VALUE WHEN WORKING WITH HEIRARCHICAL DESIGNS
# AND THE AUTOMATED GRADING SYSTEM
COMPONENT_FILES	:= 

# List all SRAM model files used (do not includ the source folder in the name)
SRAM_FILES	:= on_chip_sram_wrapper.vhd

# Specify the name of the top level file (do not include the source folder in the name)
# NOTE: YOU WILL NEED TO SET THIS VARIABLE'S VALUE WHEN WORKING WITH HEIRARCHICAL DESIGNS
# AND THE AUTOMATED GRADING SYSTEM
TOP_LEVEL_FILE	:= 

# Specify the filepath of the test bench you want to use (ie. source/tb_top_level.svhd)
TEST_BENCH	:= 

# Get the top level design and test_bench module names
TB_MODULE		:= $(notdir $(basename $(TEST_BENCH)))
TOP_MODULE	:= $(notdir $(basename $(TOP_LEVEL_FILE)))

# Create Variables for the needed libraries since verilog doesn't allow you specify directives for what to use
COURSE_LIB	:= /home/ecegrid/a/ece337/Class0.5u/ECE337_IP/vsim
GATE_LIB		:= /package/eda/cells/OSU/v2.7/cadence/lib/ami05/lib/work
GOLD_LIB		:= /home/ecegrid/a/ece337/Class0.5u/GOLD_LIB

S_WORK_LIB := source_work
M_WORK_LIB := mapped_work

# Automatically handle whether to running on the grid or not
ifeq ($(shell hostname),ecegrid-lnx.ecn.purdue.edu)
LIB_CREATE		:= grid vlib
VLOG_COMPILE 	:= grid vlog
VHDL_COMPILE 	:= grid vcom
SIMULATE			:= grid vsim -Lf $(COURSE_LIB) -L $(GATE_LIB) -L $(GOLD_LIB)
DC_SHELL			:= grid dc_shell-t
else
LIB_CREATE		:= vlib
VLOG_COMPILE 	:= vlog
VHDL_COMPILE 	:= vcom
SIMULATE			:= vsim -Lf $(COURSE_LIB) -L $(GATE_LIB) -L $(GOLD_LIB)
DC_SHELL			:= dc_shell-t
endif

##############################################################################
# Designate that all commands for a each target should be run using one shell 
# instance (only supported in versions 3.82+)
##############################################################################
.ONESHELL:

##############################################################################
# Designate that all "intermediate" files created during chaing make rules
# should not be deleted (otherwise automatically compiled or synthesized files
# will be automatically deleted by make after it's done with them).
##############################################################################
.SECONDARY:

##############################################################################
# Designate targets that do not correspond directly to files so that they are
# run every time they are called
##############################################################################
.phony: default clean veryclean
.phony: print_vars
.phony: sim_full_source sim_full_mapped
.phony: syn_mapped

##############################################################################
# Make the default target (the one called when no specific one is invoked) to
# output the proper usage of this makefile
##############################################################################
default:
	@echo "----------------------------------------------------------------"
	@echo "Administrative targets:"
	@echo "  clean         - removes the temporary files"
	@echo	"  very_clean    - removes the mapped files as well"
	@echo	"  print_vars    - prints the contents of the variables"
	@echo
	@echo "Compilation targets:"
	@echo "  source_%     - compiles the source version of an indivudal file"
	@echo "                 with the basename of % and outputs the feedback"
	@echo "                 to the terminal instead of to a log file"
	@echo "  mapped_%     - compiles the mapped version of an indivudal file"
	@echo "                 with the basename of % and outputs the feedback"
	@echo "                 to the terminal instead of to a log file"
	@echo "  mapped_tb_%  - compiles the testbench for an indivudal mapped file"
	@echo "                 with the basename of % and outputs the feedback"
	@echo "                 to the terminal instead of to a log file"
	@echo
	@echo "Simulation targets:"
	@echo "  sim_full_source   - compiles and simulates the source version"
	@echo "                      of a full design including its top level"
	@echo "                      test bench"
	@echo "  sim_full_mapped   - compiles and simulates the mapped version"
	@echo "                      of a full design including its top level"
	@echo "                      test bench"
	@echo "  sim_%_source      - compiles and simulates the source version"
	@echo "                      of an individual file with basename %"
	@echo "                      without a testbench"
	@echo "  sim_%_mapped      - compiles and simulates the mapped version"
	@echo "                      of an individual file with basename %"
	@echo "                      without a testbench"
	@echo "  tbsim_%_source    - compiles and simulates the source version"
	@echo "                      of an individual file with basename %"
	@echo "                      with its testbench"
	@echo "  tbsim_%_mapped    - compiles and simulates the mapped version"
	@echo "                      of an individual file with basename %"
	@echo "                      with its testbench"
	@echo 
	@echo "Synthesis targets:"
	@echo "  mapped/%   - synthesizes the mapped version of an individual file"
	@echo "               additionally the DEP_SUB_FILES variabl can be used "
	@echo "               to define dependant submodule files needed for "
	@echo "               synthesis and the CLOCK_NAME variable can be used"
	@echo "               to define the clock signal name to use for synthesis"
	@echo "               of sequential/clocked designs"
	@echo "----------------------------------------------------------------"

##############################################################################
# Administrative Targets
##############################################################################

clean:
	@echo -e "Removing temporary files"
	@rm -rf *_work
	@rm -rf analyzed/ARCH analyzed/ENTI
	@rm -f analyzed/*
	@rm -f schematic/*
	@rm -f *.wlf *.svf transcript
	@rm -f *.tran
	@rm -f *.scomp *.mcomp
	@echo -e "Done\n\n"
	
veryclean:
	@$(MAKE) --no-print-directory clean
	@echo -e "Removing synthesized files, synthesis logs, and synthesis reports"
	@rm -f mapped/*
	@rm -f reports/*
	@rm -f *.log
	@echo -e "Done\n\n"

print_vars:
	@echo -e "Component Files: \n $(foreach file, $(COMPONENT_FILES), $(file)\n)"
	@echo -e "SRAM Files: \n $(foreach file, $(SRAM_FILES), $(file)\n)"
	@echo -e "Top level File: $(TOP_LEVEL_FILE)"
	@echo -e "Testbench: $(TEST_BENCH)"
	@echo -e "Top level module: $(TOP_MODULE)"
	@echo -e "Testbench module: $(TB_MODULE)"
	@echo -e "Gate Library: '$(GATE_LIB)'"
	@echo -e "Gold Library: '$(GOLD_LIB)'"
	@echo -e "Course Library: '$(COURSE_LIB)'"
	@echo -e "Source work library: '$(S_WORK_LIB)'"
	@echo -e "Mapped work library: '$(M_WORK_LIB)'"
	
##############################################################################
# Compilation Targets
##############################################################################

# Define a pattern rule to automatically create the work library for a design source compile
$(S_WORK_LIB):
	@echo -e "Creating work library: $@"
	@rm -rf $@
	@$(LIB_CREATE) $@

# Define a pattern rule to automatically compile updated source files for a design
# A check for if it could cause multiple grid commands has been added to submit
# the whole rule and all sub-rules/dependency rule as one grid call to keep it
# running on the same backend server to prevent network filesystem latency
# induced errors
ifeq ($(shell hostname),ecegrid-lnx.ecn.purdue.edu)
$(S_WORK_LIB)/%:
	@grid $(MAKE) --no-print-directory $@
else
$(S_WORK_LIB)/%: source/%.sv $(S_WORK_LIB)
	@echo -e "Compiling '$<' into work library '$(word 2, $^)'"
	@rm -rf $@
	@$(VLOG_COMPILE) -work $(word 2, $^) $< > $*.scomp
	@echo -e "Done compiling '$<' into work library '$(word 2, $^)'"
endif

# Define a pattern rule to automatically compile updated source files for a design
# A check for if it could cause multiple grid commands has been added to submit
# the whole rule and all sub-rules/dependency rule as one grid call to keep it
# running on the same backend server to prevent network filesystem latency
# induced errors
ifeq ($(shell hostname),ecegrid-lnx.ecn.purdue.edu)
$(S_WORK_LIB)/%:
	@grid $(MAKE) --no-print-directory $@
else
$(S_WORK_LIB)/%: source/%.vhd $(S_WORK_LIB)
	@echo -e "Compiling '$<' into work library '$(word 2, $^)'"
	@rm -rf $@
	@$(VHDL_COMPILE) -work $(word 2, $^) $< > $*.scomp
	@echo -e "Done compiling '$<' into work library '$(word 2, $^)'"
endif

# Define a pattern rule to for use at commandline to compile source versions and
# send feedback to terminal instead of log file
# A check for if it could cause multiple grid commands has been added to submit
# the whole rule and all sub-rules/dependency rule as one grid call to keep it
# running on the same backend server to prevent network filesystem latency
# induced errors
ifeq ($(shell hostname),ecegrid-lnx.ecn.purdue.edu)
source_%:
	@grid $(MAKE) --no-print-directory $@
else
source_%: source/%.sv $(S_WORK_LIB)
	@echo -e "Compiling '$<' into work library '$(word 2, $^)'"
	@rm -rf $(word 2, $^)/$*
	@$(VLOG_COMPILE) -work $(word 2, $^) $<
	@echo -e "Done compiling '$<' into work library '$(word 2, $^)'"
endif

# Define a pattern rule to for use at commandline to compile source versions and
# send feedback to terminal instead of log file
# A check for if it could cause multiple grid commands has been added to submit
# the whole rule and all sub-rules/dependency rule as one grid call to keep it
# running on the same backend server to prevent network filesystem latency
# induced errors
ifeq ($(shell hostname),ecegrid-lnx.ecn.purdue.edu)
source_%:
	@grid $(MAKE) --no-print-directory $@
else
source_%: source/%.vhd $(S_WORK_LIB)
	@echo -e "Compiling '$<' into work library '$(word 2, $^)'"
	@rm -rf $(word 2, $^)/$*
	@$(VHDL_COMPILE) -work $(word 2, $^) $<
	@echo -e "Done compiling '$<' into work library '$(word 2, $^)'"
endif

# Define a pattern rule to automatically create the work library for a full design mapped compile
$(M_WORK_LIB):
	@echo -e "Creating work library: $@"
	@rm -rf $@
	@$(LIB_CREATE) $@
	
# Define a pattern rule to automatically compile updated mapped design files for a full mapped design
# A check for if it could cause multiple grid commands has been added to submit
# the whole rule and all sub-rules/dependency rule as one grid call to keep it
# running on the same backend server to prevent network filesystem latency
# induced errors
ifeq ($(shell hostname),ecegrid-lnx.ecn.purdue.edu)
$(M_WORK_LIB)/%:
	@grid $(MAKE) --no-print-directory $@
else
$(M_WORK_LIB)/%: mapped/%.v $(M_WORK_LIB)
	@echo -e "Compiling '$<' into work library '$(word 2, $^)'"
	@rm -rf $@
	@$(VLOG_COMPILE) -work $(word 2, $^) $< > $*.mcomp
	@echo -e "Done compiling '$<' into work library '$(word 2, $^)'"
endif

# Define a pattern rule to automatically compile updated mapped design files for a full mapped design
# A check for if it could cause multiple grid commands has been added to submit
# the whole rule and all sub-rules/dependency rule as one grid call to keep it
# running on the same backend server to prevent network filesystem latency
# induced errors
ifeq ($(shell hostname),ecegrid-lnx.ecn.purdue.edu)
$(M_WORK_LIB)/%:
	@grid $(MAKE) --no-print-directory $@
else
$(M_WORK_LIB)/%: source/%.vhd $(M_WORK_LIB)
	@echo -e "Compiling '$<' into work library '$(word 2, $^)'"
	@rm -rf $@
	@$(VHDL_COMPILE) -work $(word 2, $^) $< > $*.mcomp
	@echo -e "Done compiling '$<' into work library '$(word 2, $^)'"
endif

# Define a pattern rule to automatically compile updated test bench files for a full mapped design
# A check for if it could cause multiple grid commands has been added to submit
# the whole rule and all sub-rules/dependency rule as one grid call to keep it
# running on the same backend server to prevent network filesystem latency
# induced errors
ifeq ($(shell hostname),ecegrid-lnx.ecn.purdue.edu)
$(M_WORK_LIB)/tb_%:
	@grid $(MAKE) --no-print-directory $@
else
$(M_WORK_LIB)/tb_%: source/tb_%.sv $(M_WORK_LIB)
	@echo -e "Compiling '$<' into work library '$(word 2, $^)'"
	@rm -rf $@
	@$(VLOG_COMPILE) -work $(word 2, $^) $< > $*.mcomp
	@echo -e "Done compiling '$<' into work library '$(word 2, $^)'"
endif

# Define a pattern rule to for use at commandline to compile mapped versions and
# send feedback to terminal instead of log file
# A check for if it could cause multiple grid commands has been added to submit
# the whole rule and all sub-rules/dependency rule as one grid call to keep it
# running on the same backend server to prevent network filesystem latency
# induced errors
ifeq ($(shell hostname),ecegrid-lnx.ecn.purdue.edu)
mapped_%:
	@grid $(MAKE) --no-print-directory $@
else
mapped_%: mapped/%.v $(M_WORK_LIB)
	@echo -e "Compiling '$<' into work library '$(word 2, $^)'"
	@rm -rf $(word 2, $^)/$*
	@$(VLOG_COMPILE) -work $(word 2, $^) $<
	@echo -e "Done compiling '$<' into work library '$(word 2, $^)'"
endif

# Define a pattern rule to for use at commandline to compile testbenches for mapped
# versions and send feedback to terminal instead of log file
# A check for if it could cause multiple grid commands has been added to submit
# the whole rule and all sub-rules/dependency rule as one grid call to keep it
# running on the same backend server to prevent network filesystem latency
# induced errors
ifeq ($(shell hostname),ecegrid-lnx.ecn.purdue.edu)
mapped_tb_%.sv:
	@grid $(MAKE) --no-print-directory $@
else
mapped_tb_%.sv: source/tb_%.sv $(M_WORK_LIB)
	@echo -e "Compiling '$<' into work library '$(word 2, $^)'"
	@rm -rf $(word 2, $^)/tb_$*
	@$(VLOG_COMPILE) -work $(word 2, $^) $<
	@echo -e "Done compiling '$<' into work library '$(word 2, $^)'"
endif

##############################################################################
# Simulation Targets
##############################################################################
define CONSOLE_SIM_CMDS
"run 15 us;	\
 quit -f"
endef

# This rule defines how to simulate the source form of the full design
# A check for if it could cause multiple grid commands has been added to submit
# the whole rule and all sub-rules/dependency rule as one grid call to keep it
# running on the same backend server to prevent network filesystem latency
# induced errors
ifeq ($(shell hostname),ecegrid-lnx.ecn.purdue.edu)
sim_full_source:
	@grid $(MAKE) --no-print-directory $@
else
sim_full_source: $(addprefix $(S_WORK_LIB)/, $(basename $(TOP_LEVEL_FILE) $(TEST_BENCH) $(COMPONENT_FILES) $(SRAM_FILES)))
	@echo -e "Simulating Source Design"
# Uncomment below if you want to just run the simulation as a console command
# using the commands listed in the CONSOLE_SIM_CMDS definition above instead of 
# .do file and have the transcript contents to be saved to a file
#	@$(SIMULATE) -c -t ps -do $(CONSOLE_SIM_CMDS) $(S_WORK_LIB).$(TB_MODULE) > source.tran

# Uncomment below if you want run the simulation the normal way and have it
# run the specified .do file
#	@$(SIMULATE) -t ps -do s_waves.do $(S_WORK_LIB).$(TB_MODULE)

# This way just runs it like normal and only sets up the simulation but doesn't
# run it or add any waveforms
	@$(SIMULATE) -i -t ps $(S_WORK_LIB).$(TB_MODULE)
	@echo -e "Done simulating the source design\n\n"
endif

# This rule defines how to simulate the mapped form of the full design
# A check for if it could cause multiple grid commands has been added to submit
# the whole rule and all sub-rules/dependency rule as one grid call to keep it
# running on the same backend server to prevent network filesystem latency
# induced errors
ifeq ($(shell hostname),ecegrid-lnx.ecn.purdue.edu)
sim_full_mapped:
	@grid $(MAKE) --no-print-directory $@
else
sim_full_mapped: $(addprefix $(M_WORK_LIB)/, $(basename $(TOP_LEVEL_FILE) $(TEST_BENCH) $(SRAM_FILES)))
	@echo -e "Simulating Mapped Design"
# Uncomment below if you want to just run the simulation as a console command
# using the commands listed in the CONSOLE_SIM_CMDS definition above instead of 
# .do file and have the transcript contents to be saved to a file
#	@$(SIMULATE) -c -t ps -do $(CONSOLE_SIM_CMDS) $(M_WORK_LIB).$(TB_MODULE) > mapped.tran

# Uncomment below if you want run the simulation the normal way and have it
# run the specified .do file
#	@$(SIMULATE) -t ps -do s_waves.do $(M_WORK_LIB).$(TB_MODULE)

# This way just runs it like normal and only sets up the simulation but doesn't
# run it or add any waveforms
	@$(SIMULATE) -i -t ps $(M_WORK_LIB).$(TB_MODULE)
	@echo -e "Done simulating the mapped design\n\n"
endif

# Define a pattern rule for simulating the source version of individual files	without a testbench
# A check for if it could cause multiple grid commands has been added to submit
# the whole rule and all sub-rules/dependency rule as one grid call to keep it
# running on the same backend server to prevent network filesystem latency
# induced errors
ifeq ($(shell hostname),ecegrid-lnx.ecn.purdue.edu)
sim_%_source:
	@grid $(MAKE) --no-print-directory $@
else
sim_%_source: $(S_WORK_LIB)/%
	@$(SIMULATE) -i -t ps $(S_WORK_LIB).$*
endif
	
# Define a pattern rule for simulating the mapped version of individual files	without a testbench
# A check for if it could cause multiple grid commands has been added to submit
# the whole rule and all sub-rules/dependency rule as one grid call to keep it
# running on the same backend server to prevent network filesystem latency
# induced errors
ifeq ($(shell hostname),ecegrid-lnx.ecn.purdue.edu)
sim_%_mapped:
	@grid $(MAKE) --no-print-directory $@
else
sim_%_mapped: $(M_WORK_LIB)/%
	@$(SIMULATE) -i -t ps $(M_WORK_LIB).$*
endif
	
# Define a pattern rule for simulating the source version of individual files	with a testbench
# A check for if it could cause multiple grid commands has been added to submit
# the whole rule and all sub-rules/dependency rule as one grid call to keep it
# running on the same backend server to prevent network filesystem latency
# induced errors
ifeq ($(shell hostname),ecegrid-lnx.ecn.purdue.edu)
tbsim_%_source:
	@grid $(MAKE) --no-print-directory $@
else
tbsim_%_source: $(S_WORK_LIB)/% $(S_WORK_LIB)/tb_%
	@$(SIMULATE) -i -t ps $(S_WORK_LIB).tb_$*
endif

# Define a pattern rule for simulating the mapped version of individual files	with a testbench
# A check for if it could cause multiple grid commands has been added to submit
# the whole rule and all sub-rules/dependency rule as one grid call to keep it
# running on the same backend server to prevent network filesystem latency
# induced errors
ifeq ($(shell hostname),ecegrid-lnx.ecn.purdue.edu)
tbsim_%_mapped:
	@grid $(MAKE) --no-print-directory $@
else
tbsim_%_mapped: $(M_WORK_LIB)/% $(M_WORK_LIB)/tb_%
	@$(SIMULATE) -i -t ps $(M_WORK_LIB).tb_$*
endif

##############################################################################
# Define the synthesis target specific variables to use
##############################################################################

# Set the default value of the clock name and clock period to an empty string so that clock timing will
# only be activated in the SYN_CMDS definition if they were overwritten at invocation
CLOCK_NAME 		:=
CLOCK_PERIOD	:=

# Set the default value of the source files for sub modules to be an empty string so that
# it will only be used if overwritten at invocation
DEP_SUB_FILES :=

# Set the default value of the main source file to an empty string since it will be
# overwritten by each rule where it is used anyways
MAIN_FILE :=

# Set the module's name to always be the same as the basename of the file
# (a.k.a. the file name without the file extension)
MOD_NAME := $(basename $(MAIN_FILE))

##############################################################################
# Synthesis Targets
##############################################################################

# A customized make target for the top level file for complex designs
# Note: The CLOCK_NAME variable override below will need to be set to the actual
# clock signal name for sequential/clocked designs.
# A check for if it could cause multiple grid commands has been added to submit
# the whole rule and all sub-rules/dependency rule as one grid call to keep it
# running on the same backend server to prevent network filesystem latency
# induced errors
# Also have to specify to run with the c shell to be able to have it use the course config (.cshrc) and call course scripts 
ifeq ($(shell hostname),ecegrid-lnx.ecn.purdue.edu)
mapped/$(TOP_MODULE).v:
	@grid $(MAKE) --no-print-directory $@
else
mapped/$(TOP_MODULE).v: SHELL := /usr/local/bin/tcsh
mapped/$(TOP_MODULE).v: source/$(TOP_LEVEL_FILE) $(addprefix source/,$(COMPONENT_FILES))
	@echo "Synthesizing design: $@\n"
	@$(MAKE) --no-print-directory syn_mapped MAIN_FILE='$(TOP_LEVEL_FILE)' DEP_SUB_FILES='$(COMPONENT_FILES)' CLOCK_NAME='clk' CLOCK_PERIOD='2' > $(TOP_MODULE).log
	@echo "Synthesis run attempt for $@ complete"
	@echo "Checking synthesis attempt for errors"
	@syschk -w $(TOP_MODULE)
	@echo "\nCheck for synthesis attempt errors complete, open $(TOP_MODULE).log for details if errors were found"
	@echo "\nRemember to check $(TOP_MODULE).log for latches and timing arcs"
	@echo "Synthesis run complete for design: $@\n\n"
endif

# A pattern rule target to synthesize any design that does not already have one defined earlier,
# as long as the desired mapped file has a corresponding source file with the same basename,
# (which is grabbed by the '%' and accessed via the $* automatic variable).
# Additionally it will include any specified dependant submodule source files in the target's
# dependencies and thus will resynthesize if any of them are newer as well.
# It will pass on any of the related variables values if they were overwritten at runtime.
# A check for if it could cause multiple grid commands has been added to submit
# the whole rule and all sub-rules/dependency rule as one grid call to keep it
# running on the same backend server to prevent network filesystem latency
# induced errors
# Also have to specify to run with the c shell to be able to have it use the course config (.cshrc) and call course scripts 
ifeq ($(shell hostname),ecegrid-lnx.ecn.purdue.edu)
mapped/%.v:
	@grid $(MAKE) --no-print-directory $@
else
mapped/%.v: SHELL := /usr/local/bin/tcsh
mapped/%.v: source/%.sv $(addprefix source/,$(DEP_SUB_FILES))
	@echo "Synthesizing design: $@\n"
	@$(MAKE) --no-print-directory syn_mapped MAIN_FILE='$*.sv' DEP_SUB_FILES='$(DEP_SUB_FILES)' CLOCK_NAME='$(CLOCK_NAME)' CLOCK_PERIOD='$(CLOCK_PERIOD)' > $*.log
	@echo "Synthesis run attempt for $@ complete"
	@echo "Checking synthesis attempt for errors"
	@syschk -w $*
	@echo "\nCheck for synthesis attempt errors complete, open $*.log for details if errors were found"
	@echo "\nRemember to check $*.log for latches and timing arcs"
	@echo "Synthesis run complete for design: $@\n\n"
endif

##############################################################################
# Define the synthesis commands to use
##############################################################################
	
define SYN_CMDS
'# Step 1:  Read in the source file                                                     \n\
analyze -format sverilog -lib WORK {$(DEP_SUB_FILES) $(MAIN_FILE)}        						  \n\
elaborate $(MOD_NAME) -lib WORK -update                       										  		\n\
                                                                                        \n\
uniquify                                                                                \n\
# Step 2: Set design constraints                                                        \n\
# Uncomment below to set timing, area, power, etc. constraints                          \n\
# set_max_delay <delay> -from "<input>" -to "<output>"                                  \n\
# set_max_area <area>                                                                   \n\
# set_max_total_power <power> mW                                                        \n\
$(if $(and $(CLOCK_NAME), $(CLOCK_PERIOD)), create_clock "$(CLOCK_NAME)" -name "$(CLOCK_NAME)" -period $(CLOCK_PERIOD)) \n\
                                                                                        \n\
# Step 3: Compile the design                                                            \n\
compile -map_effort medium                                                              \n\
                                                                                        \n\
# Step 4: Output reports                                                                \n\
report_timing -path full -delay max -max_paths 1 -nworst 1 > reports/$(MOD_NAME).rep    \n\
report_area >> reports/$(MOD_NAME).rep                                                  \n\
report_power -hier >> reports/$(MOD_NAME).rep                                           \n\
                                                                                        \n\
# Step 5: Output final VHDL and Verilog files                                           \n\
write -format verilog -hierarchy -output "mapped/$(MOD_NAME).v"                         \n\
echo "\\nScript Done\\n"                                                                \n\
echo "\\nChecking Design\\n"                                                            \n\
check_design                                                                            \n\
exit'
endef

# Define the target that will actuall invoke the synthesis commands through design compiler
# Use of the .ONESHELL will cause all of the lines after the DC_SHELL invocation line to be
# run on the design compiler shell instance created by the DC_SHELL invocation line.
syn_mapped:
	@echo -e "Synthesizing design: $(MAIN_FILE)"
	@echo -e $(SYN_CMDS) | $(DC_SHELL)
	@echo -e "Done\n\n"


