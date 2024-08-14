
```
I have upgraded to the latest FW and still see the following issue when using the l-link commander window. When I use wjraw to shift 8 bits, I'm getting a 4 bit answer back if the upper 4 bits are 0. This also happens when I ask for 32 bits back and this data is in the middle. Please see the log below:

J-Link>rtap
J-Link>wjraw 4,2,0
TDO: F
J-Link>wjraw 8,00,00
TDO: 77
J-Link>wjraw 8,00,00
TDO: 4 <--- 4 bits only
J-Link>wjraw 8,00,00
TDO: A0
J-Link>wjraw 8,00,00
TDO: 4B
J-Link>
J-Link>
J-Link>
J-Link>rtap
J-Link>wjraw 4,2,0
TDO: F
J-Link>wjraw 32,00000000,00000000
TDO: 4BA0477 <--- missing bits
J-Link>
```

```
SEGGER J-Link Commander V4.64a ('?' for help)
Compiled Feb 25 2013 18:27:24
Can not connect to J-Link via USB.
J-Link>?

Available commands are:
----------------------
f          Firmware info
h          halt
g          go
Sleep      Waits the given time (in milliseconds). Syntax: Sleep <delay>
s          Single step the target chip
st         Show hardware status
hwinfo     Show hardware info
mem        Read memory. Syntax: mem  <Addr>, <NumBytes> (hex)
mem8       Read  8-bit items. Syntax: mem8  <Addr>, <NumBytes> (hex)
mem16      Read 16-bit items. Syntax: mem16 <Addr>, <NumItems> (hex)
mem32      Read 32-bit items. Syntax: mem32 <Addr>, <NumItems> (hex)
w1         Write  8-bit items. Syntax: w1 <Addr>, <Data> (hex)
w2         Write 16-bit items. Syntax: w2 <Addr>, <Data> (hex)
w4         Write 32-bit items. Syntax: w4 <Addr>, <Data> (hex)
wm         Write test words. Syntax: wm <NumWords>
is         Identify length of scan chain select register
ms         Measure length of scan chain. Syntax: ms <Scan chain>
mr         Measure RTCK react time. Syntax: mr
q          Quit
qc         Close JLink connection and quit
r          Reset target         (RESET)
rx         Reset target         (RESET). Syntax: rx <DelayAfterReset>
RSetType   Set the current reset type. Syntax: RSetType <type>
Regs       Display contents of registers
wreg       Write register.   Syntax: wreg <RegName>, <Value>
SetBP      Set breakpoint.   Syntax: SetBP <addr> [A/T] [S/H]
SetWP      Set Watchpoint. Syntax: <Addr> [R/W] [<Data> [<D-Mask>] [A-Mask]]
ClrBP      Clear breakpoint. Syntax: ClrBP  <BP_Handle>
ClrWP      Clear watchpoint. Syntax: ClrWP  <WP_Handle>
VCatch     Write vector catch. Syntax: VCatch <Value>
loadbin    Load binary file into target memory.
             Syntax: loadbin <filename>, <addr>
savebin    Saves target memory into binary file.
             Syntax: savebin <filename>, <addr>, <NumBytes>
verifybin  Verfies if the specified binary is already in the target memory at th
e specified address.
             Syntax: verifybin <filename>, <addr>
SetPC      Set the PC to specified value. Syntax: SetPC <Addr>
le         Change to little endian mode
be         Change to big endian mode
log        Enables log to file.  Syntax: log <filename>
unlock     Unlocks a device. Syntax: unlock <DeviceName>
           Type unlock without <DeviceName> to get a list
           of supported device names.
           nRESET has to be connected
term       Test command to visualize printf output from the target device,
           using DCC (SEGGER DCC handler running on target)
ReadAP     Reads a CoreSight AP register.
           Note: First read returns the data of the previous read.
           An additional read of DP reg 3 is necessary to get the data.
ReadDP     Reads a CoreSight DP register.
           Note: For SWD data is returned immediately.
           For JTAG the data of the previous read is returned.
           An additional read of DP reg 3 is necessary to get the data.
WriteAP    Writes a CoreSight AP register.
WriteDP    Writes a CoreSight DP register.
SWDSelect  Selects SWD as interface and outputs
           the JTAG -> SWD swichting sequence.
SWDReadAP  Reads a CoreSight AP register via SWD.
           Note: First read returns the data of the previous read.
           An additional read of DP reg 3 is necessary to get the data.
SWDReadDP  Reads a CoreSight DP register via SWD.
           Note: Correct data is returned immediately.
SWDWriteAP Writes a CoreSight AP register via SWD.
SWDWriteDP Writes a CoreSight DP register via SWD.
Device     Selects a specific device J-Link shall connect to
           and performs a reconnect.
           In most cases explicit selection of the device is not necessary.
           Selecting a device enables the user to make use of the J-Link
           flash programming functionality as well as using unlimited
           breakpoints in flash memory.
           For some devices explicit device selection is mandatory in order
           to allow the DLL to perform special handling needed by the device.
ExpDevList Exports the device names from the DLL internal
           device list to a text file
             Syntax: ExpDevList <Filename>
---- CP15 ------------
rce        Read CP15.  Syntax: rce <Op1>, <CRn>, <CRm>, <Op2>
wce        Write CP15. Syntax: wce <Op1>, <CRn>, <CRm>, <Op2>, <Data>
---- ICE -------------
Ice        Show state of the embedded ice macrocell (ICE breaker)
ri         Read Ice reg.  Syntax: ri <RegIndex>(hex)
wi         Write Ice reg. Syntax: wi <RegIndex>, <Data>(hex)
---- ETM -------------
etm        Show ETM status
re         Read ETM reg.  Syntax: re <RegIndex>
we         Write ETM reg. Syntax: we <RegIndex>, <Data>(hex)
es         Start trace
---- ETB -------------
etb        Show ETB status
rb         Read ETB register.  Syntax: rb <RegIndex>
wb         Write ETB register. Syntax: wb <RegIndex>, <Data>(hex)
---- TRACE -----------
TAddBranch TRACE - Add branch instruction to trace buffer. Paras:<Addr>,<BAddr>
TAddInst   TRACE - Add (non-branch) instruction to trace buffer. Syntax: <Addr>
TClear     TRACE - Clear buffer
TSetSize   TRACE - Set Size of trace buffer
TSetFormat TRACE - SetFormat
TSR        TRACE - Show Regions (and analyze trace buffer)
TStart     TRACE - Start
TStop      TRACE - Stop
---- SWO -------------
SWOSpeed   SWO - Show supported speeds
SWOStart   SWO - Start
SWOStop    SWO - Stop
SWOStat    SWO - Display SWO status
SWORead    SWO - Read and display SWO data
SWOShow    SWO - Read and analyze SWO data
SWOFlush   SWO - Flush data
SWOView    SWO - View terminal data
---- PERIODIC --------
PERConf    PERIODIC - Configure
PERStart   PERIODIC - Start
PERStop    PERIODIC - Stop
PERStat    PERIODIC - Display status
PERRead    PERIODIC - Read and display data
PERShow    PERIODIC - Read and analyze data
---- File I/O --------
fwrite     Write file to emulator
fread      Read file from emulator
fshow      Read and display file from emulator
fdelete    Delete file on emulator
fsize      Display size of file on emulator
---- Test ------------
TestHaltGo   Run go/halt 1000 times
TestStep     Run step 1000 times
TestCSpeed   Measure CPU speed.
             Parameters: [<RAMAddr>]
TestWSpeed   Measure download speed into target memory.
             Parameters:  [<Addr> [<Size>]]
TestRSpeed   Measure upload speed from target memory.
             Parameters: [<Addr> [<Size>] [<NumBlocks>]]
TestNWSpeed  Measure network download speed.
             Parameters: [<NumBytes> [<NumReps>]]
TestNRSpeed  Measure network upload speed.
             Parameters: [<NumBytes> [<NumReps>]]
---- JTAG ------------
Config     Set number of IR/DR bits before ARM device.
             Syntax: Config <IRpre>, <DRpre>
speed      Set JTAG speed. Syntax: speed <freq>|auto|adaptive, e.g. speed 2000,
speed a
i          Read JTAG Id (Host CPU)
wjc        Write JTAG command (IR). Syntax: wjc <Data>(hex)
wjd        Write JTAG data (DR). Syntax: wjd <Data64>(hex), <NumBits>(dec)
RTAP       Reset TAP Controller using state machine (111110)
wjraw      Write Raw JTAG data. Syntax: wjraw <NumBits(dec)>, <tms>, <tdi>
rt         Reset TAP Controller (nTRST)
---- JTAG-Hardware ---
c00        Create clock with TDI = TMS = 0
c          Clock
tck0       Clear TCK
tck1       Set   TCK
0          Clear TDI
1          Set   TDI
t0         Clear TMS
t1         Set   TMS
trst0      Clear TRST
trst1      Set   TRST
r0         Clear RESET
r1         Set   RESET
---- Connection ------
usb        Connect to J-Link via USB.  Syntax: usb <port>, where port is 0..3
ip         Connect to J-Link ARM Pro or J-Link TCP/IP Server via TCP/IP.
           Syntax: ip <ip_addr>
---- Configuration ---
si         Select target interface. Syntax: si <Interface>,
           where 0=JTAG and 1=SWD.
power      Switch power supply for target. Syntax: power <State> [perm],
           where State is either On or Off. Example: power on perm
wconf      Write configuration byte. Syntax: wconf <offset>, <data>
rconf      Read configuration bytes. Syntax: rconf
usbaddr    Assign usb address to the connected J-Link: Syntax: usbaddr = <addr>
ipaddr     Show/Assign IP address and subnetmask of/to the connected J-Link.
gwaddr     Show/Assign network gateway address of/to the connected J-Link.
dnsaddr    Show/Assign network DNS server address of/to the connected J-Link.
conf       Show configuration of the connected J-Link.
ecp        Enable the  J-Link control panel.
calibrate  Calibrate the target current measurement.
selemu     Select a emulator to communicate with,
           from a list of all emulators which are connected to the host
           The interfaces to search on, can be specified
             Syntax: selemu [<Interface0> <Interface1> ...]
ShowEmuList Shows a list of all emulators which are connected to the host.
            The interfaces to search on, can be specified.
             Syntax: ShowEmuList [<Interface0> <Interface1> ...]
----------------------
NOTE: Specifying a filename in command line
will start J-Link Commander in script mode.

J-Link>SEGGER J-Link Commander V4.64a ('?' for help)
Compiled Feb 25 2013 18:27:24
Can not connect to J-Link via USB.
J-Link>?

Available commands are:
----------------------
f          Firmware info
h          halt
g          go
Sleep      Waits the given time (in milliseconds). Syntax: Sleep <delay>
s          Single step the target chip
st         Show hardware status
hwinfo     Show hardware info
mem        Read memory. Syntax: mem  <Addr>, <NumBytes> (hex)
mem8       Read  8-bit items. Syntax: mem8  <Addr>, <NumBytes> (hex)
mem16      Read 16-bit items. Syntax: mem16 <Addr>, <NumItems> (hex)
mem32      Read 32-bit items. Syntax: mem32 <Addr>, <NumItems> (hex)
w1         Write  8-bit items. Syntax: w1 <Addr>, <Data> (hex)
w2         Write 16-bit items. Syntax: w2 <Addr>, <Data> (hex)
w4         Write 32-bit items. Syntax: w4 <Addr>, <Data> (hex)
wm         Write test words. Syntax: wm <NumWords>
is         Identify length of scan chain select register
ms         Measure length of scan chain. Syntax: ms <Scan chain>
mr         Measure RTCK react time. Syntax: mr
q          Quit
qc         Close JLink connection and quit
r          Reset target         (RESET)
rx         Reset target         (RESET). Syntax: rx <DelayAfterReset>
RSetType   Set the current reset type. Syntax: RSetType <type>
Regs       Display contents of registers
wreg       Write register.   Syntax: wreg <RegName>, <Value>
SetBP      Set breakpoint.   Syntax: SetBP <addr> [A/T] [S/H]
SetWP      Set Watchpoint. Syntax: <Addr> [R/W] [<Data> [<D-Mask>] [A-Mask]]
ClrBP      Clear breakpoint. Syntax: ClrBP  <BP_Handle>
ClrWP      Clear watchpoint. Syntax: ClrWP  <WP_Handle>
VCatch     Write vector catch. Syntax: VCatch <Value>
loadbin    Load binary file into target memory.
             Syntax: loadbin <filename>, <addr>
savebin    Saves target memory into binary file.
             Syntax: savebin <filename>, <addr>, <NumBytes>
verifybin  Verfies if the specified binary is already in the target memory at th
e specified address.
             Syntax: verifybin <filename>, <addr>
SetPC      Set the PC to specified value. Syntax: SetPC <Addr>
le         Change to little endian mode
be         Change to big endian mode
log        Enables log to file.  Syntax: log <filename>
unlock     Unlocks a device. Syntax: unlock <DeviceName>
           Type unlock without <DeviceName> to get a list
           of supported device names.
           nRESET has to be connected
term       Test command to visualize printf output from the target device,
           using DCC (SEGGER DCC handler running on target)
ReadAP     Reads a CoreSight AP register.
           Note: First read returns the data of the previous read.
           An additional read of DP reg 3 is necessary to get the data.
ReadDP     Reads a CoreSight DP register.
           Note: For SWD data is returned immediately.
           For JTAG the data of the previous read is returned.
           An additional read of DP reg 3 is necessary to get the data.
WriteAP    Writes a CoreSight AP register.
WriteDP    Writes a CoreSight DP register.
SWDSelect  Selects SWD as interface and outputs
           the JTAG -> SWD swichting sequence.
SWDReadAP  Reads a CoreSight AP register via SWD.
           Note: First read returns the data of the previous read.
           An additional read of DP reg 3 is necessary to get the data.
SWDReadDP  Reads a CoreSight DP register via SWD.
           Note: Correct data is returned immediately.
SWDWriteAP Writes a CoreSight AP register via SWD.
SWDWriteDP Writes a CoreSight DP register via SWD.
Device     Selects a specific device J-Link shall connect to
           and performs a reconnect.
           In most cases explicit selection of the device is not necessary.
           Selecting a device enables the user to make use of the J-Link
           flash programming functionality as well as using unlimited
           breakpoints in flash memory.
           For some devices explicit device selection is mandatory in order
           to allow the DLL to perform special handling needed by the device.
ExpDevList Exports the device names from the DLL internal
           device list to a text file
             Syntax: ExpDevList <Filename>
---- CP15 ------------
rce        Read CP15.  Syntax: rce <Op1>, <CRn>, <CRm>, <Op2>
wce        Write CP15. Syntax: wce <Op1>, <CRn>, <CRm>, <Op2>, <Data>
---- ICE -------------
Ice        Show state of the embedded ice macrocell (ICE breaker)
ri         Read Ice reg.  Syntax: ri <RegIndex>(hex)
wi         Write Ice reg. Syntax: wi <RegIndex>, <Data>(hex)
---- ETM -------------
etm        Show ETM status
re         Read ETM reg.  Syntax: re <RegIndex>
we         Write ETM reg. Syntax: we <RegIndex>, <Data>(hex)
es         Start trace
---- ETB -------------
etb        Show ETB status
rb         Read ETB register.  Syntax: rb <RegIndex>
wb         Write ETB register. Syntax: wb <RegIndex>, <Data>(hex)
---- TRACE -----------
TAddBranch TRACE - Add branch instruction to trace buffer. Paras:<Addr>,<BAddr>
TAddInst   TRACE - Add (non-branch) instruction to trace buffer. Syntax: <Addr>
TClear     TRACE - Clear buffer
TSetSize   TRACE - Set Size of trace buffer
TSetFormat TRACE - SetFormat
TSR        TRACE - Show Regions (and analyze trace buffer)
TStart     TRACE - Start
TStop      TRACE - Stop
---- SWO -------------
SWOSpeed   SWO - Show supported speeds
SWOStart   SWO - Start
SWOStop    SWO - Stop
SWOStat    SWO - Display SWO status
SWORead    SWO - Read and display SWO data
SWOShow    SWO - Read and analyze SWO data
SWOFlush   SWO - Flush data
SWOView    SWO - View terminal data
---- PERIODIC --------
PERConf    PERIODIC - Configure
PERStart   PERIODIC - Start
PERStop    PERIODIC - Stop
PERStat    PERIODIC - Display status
PERRead    PERIODIC - Read and display data
PERShow    PERIODIC - Read and analyze data
---- File I/O --------
fwrite     Write file to emulator
fread      Read file from emulator
fshow      Read and display file from emulator
fdelete    Delete file on emulator
fsize      Display size of file on emulator
---- Test ------------
TestHaltGo   Run go/halt 1000 times
TestStep     Run step 1000 times
TestCSpeed   Measure CPU speed.
             Parameters: [<RAMAddr>]
TestWSpeed   Measure download speed into target memory.
             Parameters:  [<Addr> [<Size>]]
TestRSpeed   Measure upload speed from target memory.
             Parameters: [<Addr> [<Size>] [<NumBlocks>]]
TestNWSpeed  Measure network download speed.
             Parameters: [<NumBytes> [<NumReps>]]
TestNRSpeed  Measure network upload speed.
             Parameters: [<NumBytes> [<NumReps>]]
---- JTAG ------------
Config     Set number of IR/DR bits before ARM device.
             Syntax: Config <IRpre>, <DRpre>
speed      Set JTAG speed. Syntax: speed <freq>|auto|adaptive, e.g. speed 2000,
speed a
i          Read JTAG Id (Host CPU)
wjc        Write JTAG command (IR). Syntax: wjc <Data>(hex)
wjd        Write JTAG data (DR). Syntax: wjd <Data64>(hex), <NumBits>(dec)
RTAP       Reset TAP Controller using state machine (111110)
wjraw      Write Raw JTAG data. Syntax: wjraw <NumBits(dec)>, <tms>, <tdi>
rt         Reset TAP Controller (nTRST)
---- JTAG-Hardware ---
c00        Create clock with TDI = TMS = 0
c          Clock
tck0       Clear TCK
tck1       Set   TCK
0          Clear TDI
1          Set   TDI
t0         Clear TMS
t1         Set   TMS
trst0      Clear TRST
trst1      Set   TRST
r0         Clear RESET
r1         Set   RESET
---- Connection ------
usb        Connect to J-Link via USB.  Syntax: usb <port>, where port is 0..3
ip         Connect to J-Link ARM Pro or J-Link TCP/IP Server via TCP/IP.
           Syntax: ip <ip_addr>
---- Configuration ---
si         Select target interface. Syntax: si <Interface>,
           where 0=JTAG and 1=SWD.
power      Switch power supply for target. Syntax: power <State> [perm],
           where State is either On or Off. Example: power on perm
wconf      Write configuration byte. Syntax: wconf <offset>, <data>
rconf      Read configuration bytes. Syntax: rconf
usbaddr    Assign usb address to the connected J-Link: Syntax: usbaddr = <addr>
ipaddr     Show/Assign IP address and subnetmask of/to the connected J-Link.
gwaddr     Show/Assign network gateway address of/to the connected J-Link.
dnsaddr    Show/Assign network DNS server address of/to the connected J-Link.
conf       Show configuration of the connected J-Link.
ecp        Enable the  J-Link control panel.
calibrate  Calibrate the target current measurement.
selemu     Select a emulator to communicate with,
           from a list of all emulators which are connected to the host
           The interfaces to search on, can be specified
             Syntax: selemu [<Interface0> <Interface1> ...]
ShowEmuList Shows a list of all emulators which are connected to the host.
            The interfaces to search on, can be specified.
             Syntax: ShowEmuList [<Interface0> <Interface1> ...]
----------------------
NOTE: Specifying a filename in command line
will start J-Link Commander in script mode.

J-Link>
```
