
 ##[TAP State Name](http://openocd.org/doc/html/JTAG-Commands.html#JTAG-Commands)

 The tap_state names used by OpenOCD in the drscan, irscan, and pathmove commands are the same as those used in SVF boundary scan documents, except that SVF uses IDLE instead of RUN/IDLE.

    RESET ... stable (with TMS high); acts as if TRST were pulsed
    RUN/IDLE ... stable; don’t assume this always means IDLE
    DRSELECT
    DRCAPTURE
    DRSHIFT ... stable; TDI/TDO shifting through the data register
    DREXIT1
    DRPAUSE ... stable; data register ready for update or more shifting
    DREXIT2
    DRUPDATE
    IRSELECT
    IRCAPTURE
    IRSHIFT ... stable; TDI/TDO shifting through the instruction register
    IREXIT1
    IRPAUSE ... stable; instruction register ready for update or more shifting
    IREXIT2
    IRUPDATE 

Note that only six of those states are fully “stable” in the face of TMS fixed (low except for RESET) and a free-running JTAG clock. For all the others, the next TCK transition changes to a new state.

    From DRSHIFT and IRSHIFT, clock transitions will produce side effects by changing register contents. The values to be latched in upcoming DRUPDATE or IRUPDATE states may not be as expected.
    RUN/IDLE, DRPAUSE, and IRPAUSE are reasonable choices after drscan or irscan commands, since they are free of JTAG side effects.
    RUN/IDLE may have side effects that appear at non-JTAG levels, such as advancing the ARM9E-S instruction pipeline. Consult the documentation for the TAP(s) you are working with. instruction register ready for update or more shifting

##[JTAG - General description of the TAP Controller States](https://www.xilinx.com/support/answers/3203.html)

The TAP controller is a 16-state FSM that responds to the control sequences supplied through the Test Access Port. 

A transition between the states only occurs on the rising edge of TCK, and each state has a different name. 

The two vertical columns with seven states each represent the Instruction Path and the Data Path.

The data registers operate in the states whose names end with "DR" and the instruction register operates in the states whose names end in "IR". The states are otherwise identical.

The operation of each state is described below.

* Test-Logic-Reset

All test logic is disabled in this controller state enabling the normal operation of the IC. The TAP controller state machine is designed so that, no matter what the initial state of the controller is, the Test-Logic-Reset state can be entered by holding TMS at high and pulsing TCK five times. This is why the Test Reset (TRST) pin is optional.

* Run-Test-Idle

In this controller state, the test logic in the IC is active only if certain instructions are present. For example, if an instruction activates the self test, then it is executed when the controller enters this state. The test logic in the IC is idle otherwise.

* Select-DR-Scan

This controller state controls whether to enter the Data Path or the Select-IR-Scan state.

* Select-IR-Scan

This controller state controls whether or not to enter the Instruction Path. The Controller can return to the Test-Logic-Reset state otherwise.

* Capture-IR

In this controller state, the shift register bank in the Instruction Register parallel loads a pattern of fixed values on the rising edge of TCK. The last two significant bits must always be "01".

* Shift-IR

In this controller state, the instruction register gets connected between TDI and TDO, and the captured pattern gets shifted on each rising edge of TCK. The instruction available on the TDI pin is also shifted in to the instruction register.

* Exit1-IR

This controller state controls whether to enter the Pause-IR state or Update-IR state.

* Pause-IR

This state allows the shifting of the instruction register to be temporarily halted.

* Exit2-IR

This controller state controls whether to enter either the Shift-IR state or Update-IR state.

* Update-IR

In this controller state, the instruction in the instruction register is latched to the latch bank of the Instruction Register on every falling edge of TCK. This instruction becomes the current instruction once it is latched.

* Capture-DR

In this controller state, the data is parallel-loaded into the data registers selected by the current instruction on the rising edge of TCK.

* Shift-Dr, Exit1-DR, Pause-DR, Exit2-DR and Update-DR

These controller states are similar to the Shift-IR, Exit1-IR, Pause-IR, Exit2-IR and Update-IR states in the Instruction path.
