
import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def run_test(dut):
    """ Test adder.v """

    dut.A.value = 10
    dut.B.value = 11

    await Timer(5, units="ns")

    assert dut.Result.value == 0x15
    

