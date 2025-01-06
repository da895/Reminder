
usb2, 每个sof125us， bulk最大数据长度512B，耗时8.5到9.9us（9.9是传输全1，加了NRZI编码的），加上token和ack，毛估估10us一个，为了防止babble出错，sof之前得留一个最大包的时间，所以125us也就够传11到12个数据包（取决于数据里面连续1的个数）。
如果软件做的好，用qtd list的方式传输数据，usb硬件一直不停，理论极限是44到48MBps。

usb3是双向的，只算单向的话，最简单的usb3.0， 物理层5Gbps， 去掉8b/10b编码，还剩500MBps，最大数据包1024， stream模式可以连续传，link层开销很小，理论上450MBps可以有的。
实际上到usb3，瓶颈就不在usb本身了，系统总线带宽，usb硬件FIFO深度，是否使用stream传输，软件协议层开销，另一端的读写速度，都会影响usb带宽。

The SuperSpeed transaction is initiated by a host request, followed by a response from the device. 

The "SuperSpeed" bus provides for a transfer mode at a nominal rate of 5.0 Gbit/s, in addition to the three existing transfer modes. Accounting for the encoding overhead, the raw data throughput is 4 Gbit/s, and the specification considers it reasonable to achieve 3.2 Gbit/s (400 MB/s) or more in practice.

With USB 2.0, the 125 us polling interval was critical to how the bus was time-division multiplexed between devices.


    USB 2.0 transmits SOF/uSOF at fixed 1 ms/125 μs intervals. A device driver may change the interval with small finite adjustments depending on the implementation of host and system software. USB 3.0 adds mechanism for devices to send a Bus Interval Adjustment Message that is used by the host to adjust its 125 μs bus interval up to +/-13.333 μs.

    In addition, the host may send an Isochronous Timestamp Packet (ITP) within a relaxed timing window from a bus interval boundary.
Each USB device has a number of endpoints. Each endpoint is a source or sink of data. A device can have up to 16 OUT and 16 IN endpoints.

OUT always means from host to device.

IN always means from device to host.

## [USB in a Nutshell](https://sge.frba.utn.edu.ar/upload/Materias/95-0435/archivos/usb-in-a-nutshell.pdf)

## [usbmadesimple](https://www.usbmadesimple.co.uk)

## [usbnutshell](https://www.beyondlogic.org/usbnutshell/usb4.shtml)
