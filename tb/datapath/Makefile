
TOPLEVEL_LANG = verilog

SIM ?= icarus
WAVES ?= 1

COCOTB_HDL_TIMEUNIT = 1ns
COCOTB_HDL_TIMEPRECISION = 1ps

DUT      = datapath
TOPLEVEL = $(DUT)
MODULE   = test_$(DUT)
VERILOG_SOURCES += ../../quartus/$(DUT).v
VERILOG_SOURCES += ../../quartus/register.v
VERILOG_SOURCES += ../../quartus/conff.v
VERILOG_SOURCES += ../../quartus/md_mux.v
VERILOG_SOURCES += ../../quartus/bus.v
VERILOG_SOURCES += ../../quartus/alu.v
VERILOG_SOURCES += ../../quartus/ram.v
VERILOG_SOURCES += ../../quartus/adder.v
VERILOG_SOURCES += ../../quartus/and_module.v
VERILOG_SOURCES += ../../quartus/arith_right_shift.v
VERILOG_SOURCES += ../../quartus/booth_mul.v
VERILOG_SOURCES += ../../quartus/division.v
VERILOG_SOURCES += ../../quartus/left_shift.v
VERILOG_SOURCES += ../../quartus/neg.v
VERILOG_SOURCES += ../../quartus/not_module.v
VERILOG_SOURCES += ../../quartus/or_module.v
VERILOG_SOURCES += ../../quartus/right_shift.v
VERILOG_SOURCES += ../../quartus/rotate_left.v
VERILOG_SOURCES += ../../quartus/rotate_right.v
VERILOG_SOURCES += ../../quartus/select_encode_logic.v
VERILOG_SOURCES += ../../quartus/decoder.v
VERILOG_SOURCES += ../../quartus/control.v

ifeq ($(SIM), icarus)
	PLUSARGS += -fst

	COMPILE_ARGS += $(foreach v,$(filter PARAM_%,$(.VARIABLES)),-P $(TOPLEVEL).$(subst PARAM_,,$(v))=$($(v)))

	ifeq ($(WAVES), 1)
		VERILOG_SOURCES += iverilog_dump.v
		COMPILE_ARGS += -s iverilog_dump
	endif
else ifeq ($(SIM), verilator)
	COMPILE_ARGS += -Wno-SELRANGE -Wno-WIDTH

	COMPILE_ARGS += $(foreach v,$(filter PARAM_%,$(.VARIABLES)),-G$(subst PARAM_,,$(v))=$($(v)))

	ifeq ($(WAVES), 1)
		COMPILE_ARGS += --trace-fst
	endif
endif

include $(shell cocotb-config --makefiles)/Makefile.sim

iverilog_dump.v:
	echo 'module iverilog_dump();' > $@
	echo 'initial begin' >> $@
	echo '    $$dumpfile("$(TOPLEVEL).fst");' >> $@
	echo '    $$dumpvars(0, $(TOPLEVEL));' >> $@
	echo 'end' >> $@
	echo 'endmodule' >> $@

clean::
	@rm -rf iverilog_dump.v
	@rm -rf dump.fst $(TOPLEVEL).fst
