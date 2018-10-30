---
title: 一文总结计算机网络
date: 2018-04-10 20:24:59
updates: 2018-04-10 20:24:59
categories: 网络
tags: 网络
---

> 最近一直在看网络编程的东西，不管是看书、还是一些博客，或者是自己的一些编程，都觉得写的有点乱，有点杂。虽然这也比较符合网络方面的特点，零碎的知识点，有些人觉得重要就写上了，另一些就没有写。想到将来可能跟网络编程接触很多，也觉得最近的学习就是缺少一些总结。就在这里站在大佬的肩膀上整理一下吧。   
    
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/350px-UDP_encapsulation.svg.png" /> </div><br>

<!--more-->
# 计算机网络体系结构（TCP/IP四层模型）
一般所说的计算机体系结构分为三种，其中TCP/IP体系结构是实际应用较多的。
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/001.png" width="500"/> </div><br>
## 各层的作用以及协议
### OSI七层协议
表示层和会话层用途如下：
1. 表示层：信息的语法、语义以及它们的关联，如加密解密、转换翻译、压缩解压缩；
2. 会话层：不同机器上的用户之间建立及管理会话。

### 五层模型
1. 应用层：为特定应用程序提供数据传输服务，例如 HTTP、DNS 等。数据单位为报文。
2. 运输层：提供的是进程间的通用数据传输服务。由于应用层协议很多，定义通用的运输层协议就可以支持不断增多的应用层协议。运输层包括两种协议：传输控制协议 TCP，提供面向连接、可靠的数据传输服务，数据单位为报文段；用户数据报协议 UDP，提供无连接、尽最大努力的数据传输服务，数据单位为用户数据报。TCP 主要提供完整性服务，UDP 主要提供及时性服务。
3. 网络层：为主机之间提供数据传输服务，而运输层协议是为主机中的进程提供服务。网络层把运输层传递下来的报文段或者用户数据报封装成分组。
4. 数据链路层：网络层针对的还是主机之间的数据传输服务，而主机之间可以有很多链路，链路层协议就是为同一链路的结点提供服务。数据链路层把网络层传来的分组封装成帧。
5. 物理层：考虑的是怎样在传输媒体上传输数据比特流，而不是指具体的传输媒体。物理层的作用是尽可能屏蔽传输媒体和通信手段的差异，使数据链路层感觉不到这些差异。

### TCP/IP四层模型
它只有四层，相当于五层协议中数据链路层和物理层合并为网络接口层。
现在的 TCP/IP 体系结构不严格遵循 OSI 分层概念，应用层可能会直接使用 IP 层或者网络接口层。
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/010.png" width="400"/> </div><br>
TCP/IP 协议族是一种沙漏形状，中间小两边大，IP 协议在其中占用举足轻重的地位。
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/011.png" width="400"/> </div><br>
### 数据在各层之间的传递过程
在向下的过程中，需要添加下层协议所需要的首部或者尾部，而在向上的过程中不断拆开首部和尾部。
路由器只有下面三层协议，因为路由器位于网络核心中，不需要为进程或者应用程序提供服务，因此也就不需要运输层和应用层。
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/012.jpg" width="600"/> </div><br>
# 网络接口层（TCP/IP）
对应OSI七层协议的数据链路层和物理层。在实际的编程中，一般对底层关注的更少，作为长期从事物理层和数据链路层相关工作的通信工程本来觉得可以稍微发挥一下的，咳咳。
## 物理层
* 传输数据的单位--比特
* 数据传输系统：源系统（源点、发送器） --> 传输系统 --> 目的系统（接收器、终点）

通道：
* 单向通道（单工通道）：只有一个方向通信，没有反方向交互，如广播
* 双向交替通行（半双工通信）：通信双方都可发消息，但不能同时发送或接收
* 双向同时通信（全双工通信）：通信双方可以同时发送和接收信息

通道复用技术：
* 频分复用（FDM，Frequency Division Multiplexing）：不同用户在不同频带，所用用户在同样时间占用不同带宽资源
* 时分复用（TDM，Time Division Multiplexing）：不同用户在同一时间段的不同时间片，所有用户在不同时间占用同样的频带宽度
* 波分复用（WDM，Wavelength Division Multiplexing）：光的频分复用
* 码分复用（CDM，Code Division Multiplexing）：不同用户使用不同的码，可以在同样时间使用同样频带通信

## 数据链路层

### 主要信道：
* 点对点信道
* 广播信道

#### 点对点信道
* 数据单元--帧

点对点协议（Point-to-Point Protocol）：用户计算机和 ISP 通信时所使用的协议

#### 广播信道
广播通信：
* 硬件地址（物理地址、MAC 地址）
* 单播（unicast）帧（一对一）：收到的帧的 MAC 地址与本站的硬件地址相同
* 广播（broadcast）帧（一对全体）：发送给本局域网上所有站点的帧
* 多播（multicast）帧（一对多）：发送给本局域网上一部分站点的帧

### 三个基本问题

#### 封装成帧
将网络层传下来的分组添加首部和尾部，用于标记帧的开始和结束。
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/013.jpg" width="400"/> </div><br>
#### 透明传输
透明表示一个实际存在的事物看起来好像不存在一样。
帧使用首部和尾部进行定界，如果帧的数据部分含有和首部尾部相同的内容，那么帧的开始和结束位置就会被错误的判定。需要在数据部分出现首部尾部相同的内容前面插入转义字符，如果出现转义字符，那么就在转义字符前面再加个转义字符，在接收端进行处理之后可以还原出原始数据。这个过程透明传输的内容是转义字符，用户察觉不到转义字符的存在。
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/014.jpg" width="400"/> </div><br>
#### 差错检测
目前数据链路层广泛使用了循环冗余检验（CRC）来检查比特差错。
# 网络层
网络层是整个互联网的核心，因此应当让网络层尽可能简单。网络层向上只提供简单灵活的、无连接的、尽最大努力交互的数据报服务。使用 IP 协议，可以把异构的物理网络连接起来，使得在网络层看起来好像是一个统一的网络。网络层协议有：
* IP（Internet Protocol，网际协议）是为计算机网络相互连接进行通信而设计的协议。
* ARP（Address Resolution Protocol，地址解析协议）
* ICMP（Internet Control Message Protocol，网际控制报文协议）
* IGMP（Internet Group Management Protocol，网际组管理协议）

## IP 网际协议

### IP 地址分类：
* `IP 地址 ::= {<网络号>,<主机号>}`

| IP 地址类别 | 网络号                                 | 网络范围                 | 主机号 | IP 地址范围                    |
| ----------- | -------------------------------------- | ------------------------ | ------ | ------------------------------ |
| A 类        | 8bit，第一位固定为 0                   | 0 —— 127               | 24bit  | 1.0.0.0 —— 127.255.255.255   |
| B 类        | 16bit，前两位固定为  10                | 128.0 —— 191.255       | 16bit  | 128.0.0.0 —— 191.255.255.255 |
| C  类       | 24bit，前三位固定为  110               | 192.0.0 —— 223.255.255 | 8bit   | 192.0.0.0 —— 223.255.255.255 |
| D  类       | 前四位固定为 1110，后面为多播地址      |
| E  类       | 前五位固定为 11110，后面保留为今后所用 |

### IP 数据报格式：
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/015.jpg" width="500"/> </div><br>
-  **版本**  : 有 4（IPv4）和 6（IPv6）两个值；
-  **首部长度**  : 占 4 位，因此最大值为 15。值为 1 表示的是 1 个 32 位字的长度，也就是 4 字节。因为首部固定长度为 20 字节，因此该值最小为 5。如果可选字段的长度不是 4 字节的整数倍，就用尾部的填充部分来填充。
-  **区分服务**  : 用来获得更好的服务，一般情况下不使用。
-  **总长度**  : 包括首部长度和数据部分长度。
-  **标识**  : 在数据报长度过长从而发生分片的情况下，相同数据报的不同分片具有相同的标识符。
-  **片偏移**  : 和标识符一起，用于发生分片的情况。片偏移的单位为 8 字节。
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/016.jpg" width="500"/> </div><br>
-  **生存时间**  ：TTL，它的存在是为了防止无法交付的数据报在互联网中不断兜圈子。以路由器跳数为单位，当 TTL 为 0 时就丢弃数据报。
-  **协议** ：指出携带的数据应该上交给哪个协议进行处理，例如 ICMP、TCP、UDP 等。
-  **首部检验和** ：因为数据报每经过一个路由器，都要重新计算检验和，因此检验和不包含数据部分可以减少计算的工作量。

### ARP/RARP 地址解析协议/反向地址转化协议

#### 地址解析协议:
- 在数据报向下一个站点传递时，负责将IP地址转换为物理地址。
- 主机发送信息时将包含目标IP地址的ARP请求广播到网络上的所有主机，并接受返回消息，以此确定目标的物理地址；
接收的返回消息后将该IP地址和物理地址存入本机并保留一段时间，下次请求时直接查询ARP缓存以节约时间。
（地址解析协议是IPV4中广泛使用的协议；但在IPV6中不存在该协议，使用NDP（邻居发现协议））
- 工作流程：
当主机A要与主机B通信时，地址解析协议可以将主机B的IP地址解析为主机B的MAC（物理）地址。
ARP缓存是一个用来存储IP地址和MAC地址的一个缓冲区，其本质是一个IP地址对应一个MAC地址。当地址解析协议在查询IP时，首先在ARP缓存中查看，若存在则返回，否则发送ARP请求；
地址解析协议是通过报文工作的。报文包括如下字段：硬件类型，协议类型，硬件地址长度，协议长度，操作类型。
- APR缓存包含一个或多个表，他们用于存储IP地址及经过地址解析的MAC地址。ARP命令用于查询本机的ARP缓存中的IP到MAC地址的对应关系、添加或删除静态对应关系等。如果再没有参数的情况下ARP命令将显示帮助信息。
- ARP-a 查看缓存中的所有项目，在Linux中命令式ARP-g;

#### 反向地址转化协议:
- 作用于ARP相反，负责将物理层地址转换为IP地址
- 反向地址转化协议，作用于ARP相反，负责将物理层地址转换为IP地址；
允许局域网物理机器从网关服务器的ARP表或缓存上请求主机的IP地址；当设置一台新机器时，其RARP客户机程序需要向路由器上的RARP服务器请求相应的IP地址。
- ARP是设备通过自己知道的IP地址来获得自己不知道的物理地址的协议，假设知道自己的物理地址但不知道自己的IP地址，这种情况就该使用RARP协议。
RARP工作方式与ARP相反，RARP发出需要反向解析的MAC地址，并且希望返回其对应的IP地址，应答包括由能提供信息的RARP服务器发出的IP地址。
- 工作流程：
从网卡读取自己的MAC地址--->发送RARP请求的广播数据包--->RARP服务器收到请求，为其分配IP地址，并将RARP回应发送给该机器--->该机器收到IP地址后，使用IP地址进行通信

### ICMP 网际控制报文协议
由于IP协议提供的是一种不可靠的和无连接的数据报服务，为了对IP数据报的传送进行差错控制，对未能完成传送的数据报给出出错的原因，TCP/IP协议簇在网络连层提供了一个用于传递控制报文的ICMP协议，即网际控制报文协议。
ICMP 报文格式：
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/017.jpg" width="400"/> </div><br>
应用：
* PING（Packet InterNet Groper，分组网间探测）测试两个主机之间的连通性
    * TTL（Time To Live，生存时间）该字段指定 IP 包被路由器丢弃之前允许通过的最大网段数量
* Traceroute 是 ICMP 的另一个应用，用来跟踪一个分组从源点到终点的路径。

### IGMP 网际组管理协议

# 运输层
网络层只把分组发送到目的主机，但是真正通信的并不是主机而是主机中的进程。运输层提供了进程间的逻辑通信，运输层向高层用户屏蔽了下面网络层的核心细节，使应用程序看见的好像在两个运输层实体之间有一条端到端的逻辑通信信道。

## TCP协议

### 概念：
面向连接的，提供可靠交付，有流量控制，拥塞控制，提供全双工通信，面向字节流（把应用层传下来的报文看成字节流，把字节流组织成大小不等的数据块）。

### TCP首部格式
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/018.jpg" width="500"/> </div><br>
- **Source Port和Destination Port**:分别占用16位，表示源端口号和目的端口号；用于区别主机中的不同进程，而IP地址是用来区分不同的主机的，源端口号和目的端口号配合上IP首部中的源IP地址和目的IP地址就能唯一的确定一个TCP连接
- **Sequence Number**:用来标识从TCP发端向TCP收端发送的数据字节流，它表示在这个报文段中的的第一个数据字节在数据流中的序号；主要用来解决网络报乱序的问题。例如序号为 301，表示第一个字节的编号为 301，如果携带的数据长度为 100 字节，那么下一个报文段的序号应为 401；
- **Acknowledgment Number**:32位确认序列号包含发送确认的一端所期望收到的下一个序号，因此，确认序号应当是上次已成功收到数据字节序号加1。不过，只有当标志位中的ACK标志为1时该确认序列号的字段才有效。主要用来解决不丢包的问题。例如 B 正确收到 A 发送来的一个报文段，序号为 501，携带的数据长度为 200 字节，因此 B 期望下一个报文段的序号为 701，B 发送给 A 的确认报文段中确认号就为 701；
- **Offset**:给出首部中32 bit字的数目，需要这个值是因为任选字段的长度是可变的。这个字段占4bit（最多能表示15个32bit的的字，即4*15=60个字节的首部长度），因此TCP最多有60字节的首部。然而，没有任选字段，正常的长度是20字节；
- **TCP Flags**:TCP首部中有6个标志比特，它们中的多个可同时被设置为1，主要是用于操控TCP的状态机的，依次为URG，ACK，PSH，RST，SYN，FIN。每个标志位的意思如下：
    - URG：此标志表示TCP包的紧急指针域有效，用来保证TCP连接不被中断，并且督促中间层设备要尽快处理这些数据；
    - **确认ACK**：此标志表示应答域有效，就是说前面所说的TCP应答号将会包含在TCP数据包中；有两个取值：0和1，为1的时候表示应答域有效，反之为0。TCP 规定，在连接建立后所有传送的报文段都必须把 ACK 置 1；
    - PSH：这个标志位表示Push操作。所谓Push操作就是指在数据包到达接收端以后，立即传送给应用程序，而不是在缓冲区中排队；
    - RST：这个标志表示连接复位请求。用来复位那些产生错误的连接，也被用来拒绝错误和非法的数据包；
    - **同步SYN**：表示同步序号，用来建立连接。SYN标志位和ACK标志位搭配使用，当连接请求的时候，SYN=1，ACK=0；连接被响应的时候，SYN=1，ACK=1；这个标志的数据包经常被用来进行端口扫描。扫描者发送一个只有SYN的数据包，如果对方主机响应了一个数据包回来 ，就表明这台主机存在这个端口；但是由于这种扫描方式只是进行TCP三次握手的第一次握手，因此这种扫描的成功表示被扫描的机器不很安全，一台安全的主机将会强制要求一个连接严格的进行TCP的三次握手；
    - **终止FIN**： 表示发送端已经达到数据末尾，也就是说双方的数据传送完成，没有数据可以传送了，发送FIN=1标志位的TCP数据包后，连接将被断开。这个标志的数据包也经常被用于进行端口扫描。
-  **窗口**  ：窗口值作为接收方让发送方设置其发送窗口的依据。之所以要有这个限制，是因为接收方的数据缓存空间是有限的。

### TCP三次握手和四次挥手
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/002.jpg" width="500"/> </div><br>
#### TCP三次握手
* 第一次握手：建立连接。客户端发送连接请求报文段，将SYN位置为1，Sequence Number为x；然后，客户端进入SYN_SEND状态，等待服务器的确认；
* 第二次握手：服务器收到SYN报文段。服务器收到客户端的SYN报文段，需要对这个SYN报文段进行确认，设置Acknowledgment Number为x+1(Sequence Number+1)；同时，自己还要发送SYN请求信息，将SYN位置为1，Sequence Number为y；服务器端将上述所有信息放到一个报文段（即SYN+ACK报文段）中，一并发送给客户端，此时服务器进入SYN_RECV状态；
* 第三次握手：客户端收到服务器的SYN+ACK报文段。然后将Acknowledgment Number设置为y+1，向服务器发送ACK报文段，这个报文段发送完毕以后，客户端和服务器端都进入ESTABLISHED状态，完成TCP三次握手。
  完成了三次握手，客户端和服务器端就可以开始传送数据。以上就是TCP三次握手的总体介绍。

#### TCP四次挥手
当客户端和服务器通过三次握手建立了TCP连接以后，当数据传送完毕，肯定是要断开TCP连接的。那对于TCP的断开连接，就是通常说的“四次挥手”。
* 第一次挥手：主机1（可以使客户端，也可以是服务器端），设置Sequence Number和Acknowledgment Number，向主机2发送一个FIN报文段；此时，主机1进入FIN_WAIT_1状态；这表示主机1没有数据要发送给主机2了；
* 第二次挥手：主机2收到了主机1发送的FIN报文段，向主机1回一个ACK报文段，Acknowledgment Number为Sequence Number加1；主机1进入FIN_WAIT_2状态；主机2告诉主机1，我“同意”你的关闭请求；
* 第三次挥手：主机2向主机1发送FIN报文段，请求关闭连接，同时主机2进入LAST_ACK状态；
* 第四次挥手：主机1收到主机2发送的FIN报文段，向主机2发送ACK报文段，然后主机1进入TIME_WAIT状态；主机2收到主机1的ACK报文段以后，就关闭连接；此时，主机1等待2MSL后依然没有收到回复，则证明Server端已正常关闭，主机1也关闭连接。

#### 为什么需要三次握手
第三次握手是为了防止失效的连接请求到达服务器，让服务器错误打开连接，解决网络中存在延迟的分组，防止了服务器端的一直等待而浪费资源。
> “已失效的连接请求报文段”的产生在这样一种情况下：client发出的第一个连接请求报文段并没有丢失，而是在某个网络结点长时间的滞留了，以致延误到连接释放以后的某个时间才到达server。本来这是一个早已失效的报文段。但server收到此失效的连接请求报文段后，就误认为是client再次发出的一个新的连接请求。于是就向client发出确认报文段，同意建立连接。假设不采用“三次握手”，那么只要server发出确认，新的连接就建立了。由于现在client并没有发出建立连接的请求，因此不会理睬server的确认，也不会向server发送数据。但server却以为新的运输连接已经建立，并一直等待client发来数据。这样，server的很多资源就白白浪费掉了。采用“三次握手”的办法可以防止上述现象发生。例如刚才那种情况，client不会向server的确认发出确认。server由于收不到确认，就知道client并没有要求建立连接。”
失效的连接请求是指，客户端发送的连接请求在网络中滞留，客户端因为没及时收到服务器端发送的连接确认，因此就重新发送了连接请求。滞留的连接请求并不是丢失，之后还是会到达服务器。如果不进行第三次握手，那么服务器会误认为客户端重新请求连接，然后打开了连接。但是并不是客户端真正打开这个连接，因此客户端不会给服务器发送数据，这个连接就白白浪费了。

#### 为什么要四次挥手
TCP是双工的，所以发送方和接收方都需要FIN和ACK。只不过有一方是被动的，所以看上去就成了4次挥手。
TCP协议是一种面向连接的、可靠的、基于字节流的运输层通信协议。TCP是全双工模式，这就意味着，当主机1发出FIN报文段时，只是表示主机1已经没有数据要发送了，主机1告诉主机2，它的数据已经全部发送完毕了；但是，这个时候主机1还是可以接受来自主机2的数据；当主机2返回ACK报文段时，表示它已经知道主机1没有数据发送了，但是主机2还是可以发送数据到主机1的；当主机2也发送了FIN报文段时，这个时候就表示主机2也没有数据要发送了，就会告诉主机1，我也没有数据要发送了，之后彼此就会愉快的中断这次TCP连接。如果要正确的理解四次分手的原理，就需要了解四次分手过程中的状态变化。

#### TCP的十一种状态
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/008.png" width="500"/> </div><br>
- CLOSED：初始状态。
- LISTEN：服务器处于监听状态。
- SYN_SEND：客户端socket执行CONNECT连接，发送SYN包，进入此状态。
- SYN_RECV：服务端收到SYN包并发送服务端SYN包，进入此状态。
- ESTABLISH：表示连接建立。客户端发送了最后一个ACK包后进入此状态，服务端接收到ACK包后进入此状态。
- FIN_WAIT_1: 其实FIN_WAIT_1和FIN_WAIT_2状态的真正含义都是表示等待对方的FIN报文。而这两种状态的区别是：FIN_WAIT_1状态实际上是当SOCKET在ESTABLISHED状态时，它想主动关闭连接，向对方发送了FIN报文，此时该SOCKET即进入到FIN_WAIT_1状态。而当对方回应ACK报文后，则进入到FIN_WAIT_2状态，当然在实际的正常情况下，无论对方何种情况下，都应该马上回应ACK报文，所以FIN_WAIT_1状态一般是比较难见到的，而FIN_WAIT_2状态还有时常常可以用netstat看到。（主动方）
- FIN_WAIT_2：FIN_WAIT_2状态下的SOCKET，表示半连接，也即有一方要求close连接，但另外还告诉对方，我暂时还有点数据需要传送给你(ACK信息)，稍后再关闭连接。（主动方）
- CLOSE_WAIT：这种状态的含义其实是表示在等待关闭。怎么理解呢？当对方close一个SOCKET后发送FIN报文给自己，你系统毫无疑问地会回应一个ACK报文给对方，此时则进入到CLOSE_WAIT状态。接下来呢，实际上你真正需要考虑的事情是察看你是否还有数据发送给对方，如果没有的话，那么你也就可以 close这个SOCKET，发送FIN报文给对方，也即关闭连接。所以你在CLOSE_WAIT状态下，需要完成的事情是等待你去关闭连接。（被动方）
- LAST_ACK: 被动关闭一方在发送FIN报文后，最后等待对方的ACK报文。当收到ACK报文后，也即可以进入到CLOSED可用状态了。（被动方）
- TIME_WAIT: 表示收到了对方的FIN报文，并发送出了ACK报文，就等2MSL后即可回到CLOSED可用状态了。如果FIN_WAIT1状态下，收到了对方同时带FIN标志和ACK标志的报文时，可以直接进入到TIME_WAIT状态，而无须经过FIN_WAIT_2状态。（主动方）

#### TCP长连接和短连接
##### 概念
- 长连接，也叫持久连接，在TCP层握手成功后，不立即断开连接，并在此连接的基础上进行多次消息（包括心跳）交互，直至连接的任意一方（客户端OR服务端）主动断开连接，此过程称为一次完整的长连接。HTTP 1.1相对于1.0最重要的新特性就是引入了长连接。  
- 短连接，与长连接的区别就是，客户端收到服务端的响应后，立刻发送FIN消息，主动释放连接。也有服务端主动断连的情况，凡是在一次消息交互（发请求-收响应）之后立刻断开连接的情况都称为短连接。  
 
##### 使用场景
1、需要频繁交互的场景使用长连接，如即时通信工具（微信/QQ，QQ也有UDP），相反则使用短连接，比如普通的web网站，只有当浏览器发起请求时才会建立连接，服务器返回响应后，连接立即断开。
2、维持长连接会有一定的系统开销，用户量少不容易看出系统瓶颈，一旦用户量上去了，就很有可能把服务器资源（内存/CPU/网卡）耗尽，所以使用需谨慎。  
  
##### 快速区分使用的是长连接还是短连接
1、凡是在一次完整的消息交互（发请求-收响应）之后，立刻断开连接（有一方发送FIN消息）的情况都称为短连接；
2、长连接的一个明显特征是会有心跳消息（也有没有心跳的情况），且一般心跳间隔都在30S或者1MIN左右，用wireshark抓包可以看到有规律的心跳消息交互（可能会存在毫秒级别的误差）。  
#### TCP实现可靠传输
* 建立连接（标志位）：通信前确认通信实体存在。
* 序号机制（序号、确认号）：确保了数据是按序、完整到达。
* 数据校验（校验和）：CRC校验全部数据。
* 超时重传（定时器）：保证因链路故障未能到达数据能够被多次重发。
* 窗口机制（窗口）：提供流量控制，避免过量发送。
* 拥塞控制：同上。

##### 超时重传
超时重传机制：发送端发送报文后若长时间未收到确认的报文则需要重发该报文。可能有以下几种情况：
发送的数据没能到达接收端，所以对方没有响应。
接收端接收到数据，但是ACK报文在返回过程中丢失。
接收端拒绝或丢弃数据。
* 重传间隔(RTO)：从上一次发送数据，因为长期没有收到ACK响应，到下一次重发之间的时间。
  - 通常每次重传RTO是前一次重传间隔的两倍，计量单位通常是RTT。例：1RTT，2RTT，4RTT，8RTT......
  - 重传次数到达上限之后停止重传。
* RTT：数据从发送到接收到对方响应之间的时间间隔，即数据报在网络中一个往返用时。大小不稳定。

##### [TCP流量控制](https://blog.csdn.net/yechaodechuntian/article/details/25429143)

###### 利用滑动窗口实现流量控制
如果发送方把数据发送得过快，接收方可能会来不及接收，这就会造成数据的丢失。所谓流量控制就是让发送方的发送速率不要太快，要让接收方来得及接收。利用滑动窗口机制可以很方便地在TCP连接上实现对发送方的流量控制。

设A向B发送数据。在连接建立时，B告诉了A：“我的接收窗口是 rwnd = 400 ”(这里的 rwnd 表示 receiver window) 。因此，发送方的发送窗口不能超过接收方给出的接收窗口的数值。请注意，TCP的窗口单位是字节，不是报文段。TCP连接建立时的窗口协商过程在图中没有显示出来。再设每一个报文段为100字节长，而数据报文段序号的初始值设为1。大写ACK表示首部中的确认位ACK，小写ack表示确认字段的值ack。
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/007.jpg" width="500"/> </div><br>
从图中可以看出，B进行了三次流量控制。第一次把窗口减少到 rwnd = 300 ，第二次又减到了 rwnd = 100 ，最后减到 rwnd = 0 ，即不允许发送方再发送数据了。这种使发送方暂停发送的状态将持续到主机B重新发出一个新的窗口值为止。B向A发送的三个报文段都设置了 ACK = 1 ，只有在ACK=1时确认号字段才有意义。

TCP为每一个连接设有一个持续计时器(persistence timer)。只要TCP连接的一方收到对方的零窗口通知，就启动持续计时器。若持续计时器设置的时间到期，就发送一个零窗口控测报文段（携1字节的数据），那么收到这个报文段的一方就重新设置持续计时器。

###### 考虑传输速率
可以用不同的机制来控制TCP报文段的发送时机。如：
1. TCP维持一个变量，它等于最大报文段长度MSS。只要缓存中存放的数据达到MSS字节时，就组装成一个TCP报文段发送出去。
2. 由发送方的应用进程指明要求发送报文段，即TCP支持的推送( push )操作。
3. 发送方的一个计时器期限到了，这时就把已有的缓存数据装入报文段(但长度不能超过MSS)发送出去。

Nagle算法：若发送应用进程把要发送的数据逐个字节地送到TCP的发送缓存，则发送方就把第一个数据字节先发送出去，把后面到达的数据字节都缓存起来。当发送方接收对第一个数据字符的确认后，再把发送缓存中的所有数据组装成一个报文段再发送出去，同时继续对随后到达的数据进行缓存。只有在收到对前一个报文段的确认后才继续发送下一个报文段。当数据到达较快而网络速率较慢时，用这样的方法可明显地减少所用的网络带宽。Nagle算法还规定：当到达的数据已达到 发送窗口大小的一半或已达到报文段的最大长度时，就立即发送一个报文段。

糊涂窗口综合证：TCP接收方的缓存已满，而交互式的应用进程一次只从接收缓存中读取1字节（这样就使接收缓存空间仅腾出1字节），然后向发送方发送确认，并把窗口设置为1个字节（但发送的数据报为40字节的的话）。接收，发送方又发来1个字节的数据（发送方的IP数据报是41字节）。接收方发回确认，仍然将窗口设置为1个字节。这样，网络的效率很低。要解决这个问题，可让接收方等待一段时间，使得或者接收缓存已有足够空间容纳一个最长的报文段，或者等到接收方缓存已有一半空闲的空间。只要出现这两种情况，接收方就发回确认报文，并向发送方通知当前的窗口大小。此外，发送方也不要发送太小的报文段，而是把数据报积累成足够大的报文段，或达到接收方缓存的空间的一半大小。

##### TCP拥塞控制
拥塞：即对资源的需求超过了可用的资源。若网络中许多资源同时供应不足，网络的性能就要明显变坏，整个网络的吞吐量随之负荷的增大而下降。
拥塞控制：防止过多的数据注入到网络中，这样可以使网络中的路由器或链路不致过载。拥塞控制所要做的都有一个前提：网络能够承受现有的网络负荷。拥塞控制是一个全局性的过程，涉及到所有的主机、路由器，以及与降低网络传输性能有关的所有因素。
流量控制：指点对点通信量的控制，是端到端正的问题。流量控制所要做的就是抑制发送端发送数据的速率，以便使接收端来得及接收。
拥塞控制代价：需要获得网络内部流量分布的信息。在实施拥塞控制之前，还需要在结点之间交换信息和各种命令，以便选择控制的策略和实施控制。这样就产生了额外的开销。拥塞控制还需要将一些资源分配给各个用户单独使用，使得网络资源不能更好地实现共享。
控制办法：慢开始( slow-start )、拥塞避免( congestion avoidance )、快重传( fast retransmit )和快恢复( fast recovery )。

###### 慢开始和拥塞避免
发送方维持一个拥塞窗口 cwnd ( congestion window )的状态变量。拥塞窗口的大小取决于网络的拥塞程度，并且动态地在变化。发送方让自己的发送窗口等于拥塞。
发送方控制拥塞窗口的原则是：只要网络没有出现拥塞，拥塞窗口就再增大一些，以便把更多的分组发送出去。但只要网络出现拥塞，拥塞窗口就减小一些，以减少注入到网络中的分组数。
慢开始算法：当主机开始发送数据时，如果立即所大量数据字节注入到网络，那么就有可能引起网络拥塞，因为现在并不清楚网络的负荷情况。因此，较好的方法是先探测一下，即由小到大逐渐增大发送窗口，也就是说，由小到大逐渐增大拥塞窗口数值。通常在刚刚开始发送报文段时，先把拥塞窗口 cwnd 设置为一个最大报文段MSS的数值。而在每收到一个对新的报文段的确认后，把拥塞窗口增加至多一个MSS的数值。用这样的方法逐步增大发送方的拥塞窗口 cwnd ，可以使分组注入到网络的速率更加合理。
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/004.jpg" width="500"/> </div><br>
每经过一个传输轮次，拥塞窗口 cwnd 就加倍。一个传输轮次所经历的时间其实就是往返时间RTT。不过“传输轮次”更加强调：把拥塞窗口cwnd所允许发送的报文段都连续发送出去，并收到了对已发送的最后一个字节的确认。
另，慢开始的“慢”并不是指cwnd的增长速率慢，而是指在TCP开始发送报文段时先设置cwnd=1，使得发送方在开始时只发送一个报文段（目的是试探一下网络的拥塞情况），然后再逐渐增大cwnd。
为了防止拥塞窗口cwnd增长过大引起网络拥塞，还需要设置一个慢开始门限ssthresh状态变量（如何设置ssthresh）。慢开始门限ssthresh的用法如下：
当 cwnd < ssthresh 时，使用上述的慢开始算法。
当 cwnd > ssthresh 时，停止使用慢开始算法而改用拥塞避免算法。
当 cwnd = ssthresh 时，既可使用慢开始算法，也可使用拥塞控制避免算法。

拥塞避免算法：让拥塞窗口cwnd缓慢地增大，即每经过一个往返时间RTT就把发送方的拥塞窗口cwnd加1，而不是加倍。这样拥塞窗口cwnd按线性规律缓慢增长，比慢开始算法的拥塞窗口增长速率缓慢得多。

无论在慢开始阶段还是在拥塞避免阶段，只要发送方判断网络出现拥塞（其根据就是没有收到确认），就要把慢开始门限ssthresh设置为出现拥塞时的发送方窗口值的一半（但不能小于2）。然后把拥塞窗口cwnd重新设置为1，执行慢开始算法。这样做的目的就是要迅速减少主机发送到网络中的分组数，使得发生拥塞的路由器有足够时间把队列中积压的分组处理完毕。
如下图，用具体数值说明了上述拥塞控制的过程。现在发送窗口的大小和拥塞窗口一样大。
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/005.jpg" width="500"/> </div><br>
1. 当TCP连接进行初始化时，把拥塞窗口cwnd置为1。前面已说过，为了便于理解，图中的窗口单位不使用字节而使用报文段的个数。慢开始门限的初始值设置为16个报文段，即 cwnd = 16 。
2. 在执行慢开始算法时，拥塞窗口 cwnd 的初始值为1。以后发送方每收到一个对新报文段的确认ACK，就把拥塞窗口值另1，然后开始下一轮的传输（图中横坐标为传输轮次）。因此拥塞窗口cwnd随着传输轮次按指数规律增长。当拥塞窗口cwnd增长到慢开始门限值ssthresh时（即当cwnd=16时），就改为执行拥塞控制算法，拥塞窗口按线性规律增长。
3. 假定拥塞窗口的数值增长到24时，网络出现超时（这很可能就是网络发生拥塞了）。更新后的ssthresh值变为12（即变为出现超时时的拥塞窗口数值24的一半），拥塞窗口再重新设置为1，并执行慢开始算法。当cwnd=ssthresh=12时改为执行拥塞避免算法，拥塞窗口按线性规律增长，每经过一个往返时间增加一个MSS的大小。

强调：“拥塞避免”并非指完全能够避免了拥塞。利用以上的措施要完全避免网络拥塞还是不可能的。“拥塞避免”是说在拥塞避免阶段将拥塞窗口控制为按线性规律增长，使网络比较不容易出现拥塞。

###### 快重传和快恢复
如果发送方设置的超时计时器时限已到但还没有收到确认，那么很可能是网络出现了拥塞，致使报文段在网络中的某处被丢弃。这时，TCP马上把拥塞窗口 cwnd 减小到1，并执行慢开始算法，同时把慢开始门限值ssthresh减半。这是不使用快重传的情况。
快重传算法首先要求接收方每收到一个失序的报文段后就立即发出重复确认（为的是使发送方及早知道有报文段没有到达对方）而不要等到自己发送数据时才进行捎带确认。
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/006.jpg" width="500"/> </div><br>
接收方收到了M1和M2后都分别发出了确认。现在假定接收方没有收到M3但接着收到了M4。显然，接收方不能确认M4，因为M4是收到的失序报文段。根据可靠传输原理，接收方可以什么都不做，也可以在适当时机发送一次对M2的确认。但按照快重传算法的规定，接收方应及时发送对M2的重复确认，这样做可以让发送方及早知道报文段M3没有到达接收方。发送方接着发送了M5和M6。接收方收到这两个报文后，也还要再次发出对M2的重复确认。这样，发送方共收到了接收方的四个对M2的确认，其中后三个都是重复确认。快重传算法还规定，发送方只要一连收到三个重复确认就应当立即重传对方尚未收到的报文段M3，而不必继续等待M3设置的重传计时器到期。由于发送方尽早重传未被确认的报文段，因此采用快重传后可以使整个网络吞吐量提高约20%。
与快重传配合使用的还有快恢复算法，其过程有以下两个要点：
1. 当发送方连续收到三个重复确认，就执行“乘法减小”算法，把慢开始门限ssthresh减半。这是为了预防网络发生拥塞。请注意：接下去不执行慢开始算法。
2. 由于发送方现在认为网络很可能没有发生拥塞，因此与慢开始不同之处是现在不执行慢开始算法（即拥塞窗口cwnd现在不设置为1），而是把cwnd值设置为慢开始门限ssthresh减半后的数值，然后开始执行拥塞避免算法（“加法增大”），使拥塞窗口缓慢地线性增大。

##### 区分流量控制和拥塞控制
* 流量控制属于通信双方协商；拥塞控制涉及通信链路全局。
* 流量控制需要通信双方各维护一个发送窗、一个接收窗，对任意一方，接收窗大小由自身决定，发送窗大小由接收方响应的TCP报文段中窗口值确定；拥塞控制的拥塞窗口大小变化由试探性发送一定数据量数据探查网络状况后而自适应调整。
* 实际最终发送窗口 = min{流控发送窗口，拥塞窗口}。

#### TCP黏包问题
* 原因：
TCP 是一个基于字节流的传输服务（UDP 基于报文的），“流” 意味着 TCP 所传输的数据是没有边界的。所以可能会出现两个数据包黏在一起的情况。
* 解决：
- 发送定长包。如果每个消息的大小都是一样的，那么在接收对等方只要累计接收数据，直到数据等于一个定长的数值就将它作为一个消息。
- 包头加上包体长度。包头是定长的 4 个字节，说明了包体的长度。接收对等方先接收包头长度，依据包头长度来接收包体。
- 在数据包之间设置边界，如添加特殊符号 \r\n 标记。FTP 协议正是这么做的。但问题在于如果数据正文中也含有 \r\n，则会误判为消息的边界。
- 使用更加复杂的应用层协议。

## UDP协议
面向无连接的，尽最大可能交付，没有拥塞控制，面向报文（对于应用程序传下来的报文不合并也不拆分，只是添加 UDP 首部），对于一些控制需要在应用层解决。

### UDP头部
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/009.png" width="500"/> </div><br>
## TCP和UDP的区别
1. TCP 面向连接，UDP 是无连接的；
2. TCP 提供可靠的服务，也就是说，通过 TCP 连接传送的数据，无差错，不丢失，不重复，且按序到达；UDP 尽最大努力交付，即不保证可靠交付
3. TCP 的逻辑通信信道是全双工的可靠信道；UDP 则是不可靠信道
5. 每一条 TCP 连接只能是点到点的；UDP 支持一对一，一对多，多对一和多对多的交互通信
6. TCP 面向字节流（可能出现黏包问题），实际上是 TCP 把数据看成一连串无结构的字节流；UDP 是面向报文的（不会出现黏包问题）
7. UDP 没有拥塞控制，因此网络出现拥塞不会使源主机的发送速率降低（对实时应用很有用，如 IP 电话，实时视频会议等）
8. TCP 首部开销20字节；UDP 的首部开销小，只有 8 个字节

## socket编程

### socket原理
套接字（socket）是通信的基石，是支持TCP/IP协议的网络通信的基本操作单元。它是网络通信过程中端点的抽象表示，包含进行网络通信必须的五种信息：连接使用的协议，本地主机的IP地址，本地进程的协议端口，远地主机的IP地址，远地进程的协议端口。
应用层通过传输层进行数据通信时，TCP会遇到同时为多个应用程序进程提供并发服务的问题。多个TCP连接或多个应用程序进程可能需要通过同一个 TCP协议端口传输数据。为了区别不同的应用程序进程和连接，许多计算机操作系统为应用程序与TCP／IP协议交互提供了套接字(Socket)接口。应 用层可以和传输层通过Socket接口，区分来自不同应用程序进程或网络连接的通信，实现数据传输的并发服务。

### 建立socket连接
建立Socket连接至少需要一对套接字，其中一个运行于客户端，称为ClientSocket ，另一个运行于服务器端，称为ServerSocket 。
套接字之间的连接过程分为三个步骤：服务器监听，客户端请求，连接确认。
* 服务器监听：服务器端套接字并不定位具体的客户端套接字，而是处于等待连接的状态，实时监控网络状态，等待客户端的连接请求。
* 客户端请求：指客户端的套接字提出连接请求，要连接的目标是服务器端的套接字。为此，客户端的套接字必须首先描述它要连接的服务器的套接字，指出服务器端套接字的地址和端口号，然后就向服务器端套接字提出连接请求。
*连接确认：当服务器端套接字监听到或者说接收到客户端套接字的连接请求时，就响应客户端套接字的请求，建立一个新的线程，把服务器端套接字的描述发 给客户端，一旦客户端确认了此描述，双方就正式建立连接。而服务器端套接字继续处于监听状态，继续接收其他客户端套接字的连接请求。

### 创建TCP的socket流程

#### 服务端
* 创建socket： `int socket(int domain, int type, int protocol)`;
* 将socket绑定地址和端口号：`int bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen)`;
* 监听：`int listen(int sockfd, int backlog)`;
* 接受连接：`int accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen)`;
* 读取数据：`ssize_t read(int fd, void *buf, size_t count)`;
* 关闭socket:`int close(int fd)`;

#### 客户端
* 创建socket： `int socket(int domain, int type, int protocol)`;
* 连接：`int connect(int sockfd, struct sockaddr* addr, socklen_t addrlen)`;
* 输入数据: `ssize_t write(int fd, const void *buf, size_t count)`;
* 关闭socket:`int close(int fd)`;

# 应用层

## 域名系统 DNS

DNS（Domain Name System，域名系统）是互联网的一项服务。它作为将域名和 IP 地址相互映射的一个分布式数据库，能够使人更方便地访问互联网。DNS 使用 TCP 和 UDP 端口 53。当前，对于每一级域名长度的限制是 63 个字符，域名总长度则不能超过 253 个字符。

## 文件传输协议 FTP
FTP（File Transfer Protocol，文件传输协议）是用于在网络上进行文件传输的一套标准协议，使用客户/服务器模式，使用 TCP 数据报，提供交互式访问，双向传输。
TFTP（Trivial File Transfer Protocol，简单文件传输协议）一个小且易实现的文件传输协议，也使用客户-服务器方式，使用UDP数据报，只支持文件传输而不支持交互，没有列目录，不能对用户进行身份鉴定

## 远程终端协议 TELNET
TELNET 用于登录到远程主机上，并且远程主机上的输出也会返回。
TELNET 可以适应许多计算机和操作系统的差异，例如不同操作系统系统的换行符定义。

## 电子邮件协议
一个电子邮件系统由三部分组成：用户代理、邮件服务器以及邮件发送协议和读取协议。其中发送协议常用 SMTP，读取协议常用 POP3 和 IMAP。

## 动态主机配置协议 DHCP
DHCP（Dynamic Host Configuration Protocol，动态主机设置协议）是一个局域网的网络协议，使用 UDP 协议工作，主要有两个用途：
1. 用于内部网络或网络服务供应商自动分配 IP 地址给用户
2. 用于内部网络管理员作为对所有电脑作中央管理的手段

## 超文本传送协议 HTTP


# 其他问题
## 从输入URL到页面加载发生了什么
https://segmentfault.com/a/1190000006879700
DNS解析->TCP连接->发送HTTP请求->服务器处理请求并返回HTTP报文->浏览器解析并渲染界面->连接结束

## 为什么TIME_WAIT状态还需要等2MSL后才能返回到CLOSED状态？
TIME_WAIT状态由两个存在的理由。

（1）可靠的实现TCP全双工链接的终止。

这是因为虽然双方都同意关闭连接了，而且握手的4个报文也都协调和发送完毕，按理可以直接回到CLOSED状态（就好比从SYN_SEND状态到ESTABLISH状态那样）；但是因为我们必须要假想网络是不可靠的，你无法保证你最后发送的ACK报文会一定被对方收到，因此对方处于LAST_ACK状态下的SOCKET可能会因为超时未收到ACK报文，而重发FIN报文，所以这个TIME_WAIT状态的作用就是用来重发可能丢失的ACK报文。

（2）允许老的重复的分节在网络中消逝。

假 设在12.106.32.254的1500端口和206.168.1.112.219的21端口之间有一个TCP连接。我们关闭这个链接，过一段时间后在 相同的IP地址和端口建立另一个连接。后一个链接成为前一个的化身。因为它们的IP地址和端口号都相同。TCP必须防止来自某一个连接的老的重复分组在连 接已经终止后再现，从而被误解成属于同一链接的某一个某一个新的化身。为做到这一点，TCP将不给处于TIME_WAIT状态的链接发起新的化身。既然 TIME_WAIT状态的持续时间是MSL的2倍，这就足以让某个方向上的分组最多存活msl秒即被丢弃，另一个方向上的应答最多存活msl秒也被丢弃。 通过实施这个规则，我们就能保证每成功建立一个TCP连接时。来自该链接先前化身的重复分组都已经在网络中消逝了。

#### 参考链接：
https://github.com/huihut/interview#%E8%AE%A1%E7%AE%97%E6%9C%BA%E7%BD%91%E7%BB%9C
https://github.com/CyC2018/Interview-Notebook/blob/master/notes/%E8%AE%A1%E7%AE%97%E6%9C%BA%E7%BD%91%E7%BB%9C.md#%E4%BA%8C%E7%89%A9%E7%90%86%E5%B1%82
https://blog.csdn.net/yechaodechuntian/article/details/25429143
http://www.cnblogs.com/maybe2030/p/4781555.html#_label3