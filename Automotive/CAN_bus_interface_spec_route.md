# CAN总线标准接口与布线规范

随着CAN总线技术的应用愈发广泛，不仅涉及汽车电子和轨道交通，还包括医疗器械、工业控制、智能家居和机器人网络互联等，当然我们的工程师也被各种奇葩的总线问题困扰，与其后期解决问题，不如前期有效规避。

## 一、常见的CAN总线标准接口

CAN总线接口已经在CIA出版的标准CIA 303_1进行明确规定，熟知接口定义有助于提高自身产品和其它设备兼容性。

### 1. DB_9端子

![img](https://www.zlg.cn/tpl/zlg/Public/faq_img/canbus/canjszt2017051101.jpg)

							图1 DB_9接口定义

图1一般工业中最常用的9针D-Sub连接器，分公头和母头，这里值得一提的是引脚6和9在标准中也是定义了功能的，9定义为收发器/光耦合器的正极电源，但在工业领域常常会有所变化，6和9也常用做CAN设备电源电压的输入引脚，但这种技术局限性较大，因为通过引脚运输到的电流非常有限，参考标准CIA 303_1。

### 2. OPEN_5端子

![img](https://www.zlg.cn/tpl/zlg/Public/faq_img/canbus/canjszt2017051102.jpg)

							图 2 Open_5接口定义

图2是Open_5形式的接口定义，如果OPEN_4端子的一般使用1-4pin或2-5pin，如果Open_3端子的一般使用的2-4pin，需根据实际情况选择。

### 3. M12端子

![img](https://www.zlg.cn/tpl/zlg/Public/faq_img/canbus/canjszt2017051103.jpg)

							图 3 M12接口定义

图3是M12形式的接口定义，在这里可能没有什么特别需要注意的点，还有就是除了5pin的接口还有8pin、9pin、10pin和12pin的接口，具体的定义不在赘述，可参考标准CIA 303_1。

如果你是一个CAN总线的入门小白，下面的总线布线规范，你可能得收藏起来，在你组网布线的时候时不时拿出来看看，相信对你会非常有帮助。

### 1. CAN总线布线形式

#### 1) “手牵手”式连接

![img](https://www.zlg.cn/tpl/zlg/Public/faq_img/canbus/canjszt2017051104.jpg)

							图 4 “手牵手”式连接

手牵手布线是最基本的一种方式，需要注意的是在布线的时候电阻和电抗分配必须合理，一般要求在首尾两端各配一个120欧的终端电阻，不可只接单端或不接。

#### 2) “T”型连接

![img](https://www.zlg.cn/tpl/zlg/Public/faq_img/canbus/canjszt2017051105.jpg)

							图 5 “T型”连接

“T型连接”的布线方式需要注意的是分支的长度，一般波特率在1M的情况下，分支长度最好不要超过0.3m,如果需要增加分支长度，可以降低通讯速率或者使用（CANbridge+）中继器延长距离，一般情况分支布线的情况符合图 5即可。

![img](https://www.zlg.cn/tpl/zlg/Public/faq_img/canbus/canjszt2017051106.jpg)

							图 6 分支距离和波特率的关系

#### 3) 星型拓扑结构

![img](https://www.zlg.cn/tpl/zlg/Public/faq_img/canbus/canjszt2017051107.jpg)

							图 7 星型拓扑结构

对于星型拓扑结构来说需要注意的是每个分支的终端电阻的匹配，一般等距离分支终端电阻R=N(分支数)*60即可，如果不等距，需要根据实际情况进行匹配，星型组网一般推荐使用（CANHUB-AS4）集线器，能够有效隔离子网络的干扰，延长通讯距离。

### 2. 组网功能实现

选好组网的形式之后，那么我们就要考虑实际组网后的功能是否能够满足需求，接下来我就通过一个案例来跟大家简单分享一下；

![img](https://www.zlg.cn/tpl/zlg/Public/faq_img/canbus/canjszt2017051108.jpg)

							图 8 组网示意图

上面的案列比较简单，中控室一般采用电脑控制，但是电脑的接口一般是PCI/CPCI/USB接口居多，需要使用相关的接口转换卡引出，接着就是传输距离和传输速率关系，一般遵循【传输距离（km）=（50000/波特率（byte））*0.8】，仅作参考，应视具体情况而定，如果你想要更长的传输距离和传输速率，以下方案可提供参考：

#### 1) 增加中继设备（Can Bridge+），一般传输距离增加一倍；

#### 2) 使用CAN转光纤设备（CANHub-AF2S2）,光纤抗干扰能力强，传输距离一般是CAN传输距离的2倍；

#### 3) 使用CAN转以太网（CANET-XE-U），以太网传输速率一般都是10/100/1000M，减少信号传输时间。

现在我们基本上解决组网形式和传输的问题，可能大家忽略了两个问题，一个是传输线缆的选择，到底是用多粗的线缆、是否屏蔽、双绞线还是平行线呢？

### 3. 总线组网线缆的选择

![img](https://www.zlg.cn/tpl/zlg/Public/faq_img/canbus/canjszt2017051109.jpg)

							图 10 电缆选择和终端电阻匹配

在这里不得不说，同我接触的很多CAN总线的工程师，都会忽略这个电缆选型和终端电阻匹配问题，对于电缆选型很多工程师好像是对线缆的重视程度还不够，一般选择平行线缆带屏蔽的线缆，虽然带屏蔽了，但是CAN_H和CAN_L平行布线并不能很好的抑制共模干扰，导致总线传输总是偶发一些错误帧，导致数据重发，占用总线资源和其它数据传输，造成关键数据传输延迟，对研发工程师造成了极大的困扰，导致项目延迟；

其次就是终端电阻对总线的影响，不能只记着120欧的终端电阻，也应该根据不同长度和电缆的选择合理配。

作为国内CAN总线系统解决方案供应商，同时也是CIA协会在中国最主要的CAN总线技术传播的窗口，目前广州致远电子的产品覆盖了从CAN隔离收发器模块、接口转换卡、总线分析仪和总线记录仪，可以为用户提供完整的CAN总线解决方案；