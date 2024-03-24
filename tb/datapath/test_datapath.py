
import cocotb
from cocotb.triggers import Timer, RisingEdge, FallingEdge
from cocotb.clock import Clock

async def reset_dut(dut):

    dut.clear.value = 1
    await Timer(10, 'ns')
    
    dut.clear.value = 0
    await Timer(10, 'ns')

    dut.pci.value = 0
    dut.pco.value = 0
    
    dut.iro.value = 0
    dut.iro.value = 0

    dut.mari.value = 0
    dut.mdri.value = 0

    dut.maro.value = 0
    dut.mdro.value = 0
    
    dut.opi.value = 0
    dut.ipi.value = 0
    dut.ipo.value = 0
    dut.input_unit.value = 0

    dut.pc.value = 0
    dut.pc_immediate.value = 0

    dut.ir.value = 0

    dut.mem_read.value = 0
    dut.mem_write.value = 0

    dut.ryi.value = 0
    dut.ryo.value = 0

    dut.csigno.value = 0
    
    dut.gra.value = 0
    dut.grb.value = 0
    dut.grc.value = 0
    dut.rin.value = 0
    dut.rout.value = 0
    dut.baout.value = 0

    await Timer(5, 'ns')


async def test_load(dut):
    dut.baout.value = 1
    dut.mari.value = 1

    await RisingEdge(dut.clock)
    dut.baout.value = 0
    dut.mari.value = 0

    dut.mem_read.value = 1
    dut.mem_write.value = 0 
    dut.mdri.value = 1

    await RisingEdge(dut.clock)
    dut.mem_read.value = 0
    dut.mdri.value = 0

    dut.mdro.value = 1
    dut.iri.value = 1

    await RisingEdge(dut.clock)
    dut.mdro.value = 0
    dut.iri.value = 0

    dut.csigno.value = 1
    dut.mari.value = 1

    await RisingEdge(dut.clock)
    dut.csigno.value = 0
    dut.mari.value = 0

    dut.mem_read.value = 1
    dut.mem_write.value = 0
    dut.mdri.value = 1

    await RisingEdge(dut.clock)
    dut.mdri.value = 0 
    dut.mem_read.value = 0

    dut.mdro.value = 1
    dut.gra.value = 1
    dut.rin.value = 1

    await RisingEdge(dut.clock)
    dut.mdro.value = 0
    dut.gra.value = 0
    dut.rin.value = 0

    for i in range(5):
        await RisingEdge(dut.clock)
    
    assert dut.busi_r1.value == 0xFFFFFFFF 


async def test_branch(dut):

    # preload R5
    dut.buso.value = 69
    dut.R_IN[5].value = 1
    await RisingEdge(dut.clock)
    dut.buso.value = 0
    dut.R_IN[5].value = 0
     
    dut.baout.value = 1
    dut.mari.value = 1

    await RisingEdge(dut.clock)
    dut.baout.value = 0
    dut.mari.value = 0

    dut.mem_read.value = 1
    dut.mem_write.value = 0 
    dut.mdri.value = 1

    await RisingEdge(dut.clock)
    dut.mem_read.value = 0
    dut.mdri.value = 0

    dut.mdro.value = 1
    dut.iri.value = 1

    await RisingEdge(dut.clock)
    dut.mdro.value = 0
    dut.iri.value = 0

    dut.gra.value = 1
    dut.rout.value = 1

    await RisingEdge(dut.clock)
    dut.gra.value = 0
    dut.rout.value = 0



@cocotb.test()
async def run_test(dut):
    """ Test datapath.v """
    await reset_dut(dut)

    clk = Clock(dut.clock, 10, 'ns')
    await cocotb.start(clk.start())
    
    for i in range(5):
        await RisingEdge(dut.clock) 

    # await test_load(dut)
    await test_branch(dut)

