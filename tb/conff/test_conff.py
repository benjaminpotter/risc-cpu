
import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def run_test(dut):
    """ Test conff.v """

    dut.clock.value = 0    

    # test not equal to zero
    dut.bus.value = 10
    dut.ir.value = 0b01 << 19
    dut.con_in.value = 1

    await Timer(5, units="ns")

    dut.clock.value = 1
    await Timer(5, units="ns")

    dut.clock.value = 0
    await Timer(5, units="ns")

    # test equal to zero
    dut.bus.value = 10
    dut.ir.value = 0b00 << 19
    dut.con_in.value = 1

    await Timer(5, units="ns")

    dut.clock.value = 1
    await Timer(5, units="ns")

    dut.clock.value = 0
    await Timer(5, units="ns")

    # test greater than zero
    dut.bus.value = 10
    dut.ir.value = 0b10 << 19
    dut.con_in.value = 1

    await Timer(5, units="ns")

    dut.clock.value = 1
    await Timer(5, units="ns")

    dut.clock.value = 0
    await Timer(5, units="ns")

    # test less than zero
    dut.bus.value = 10
    dut.ir.value = 0b11 << 19
    dut.con_in.value = 1

    await Timer(5, units="ns")

    dut.clock.value = 1
    await Timer(5, units="ns")

    dut.clock.value = 0
    await Timer(5, units="ns")


    

