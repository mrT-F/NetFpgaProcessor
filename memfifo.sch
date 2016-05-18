VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "virtex2p"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL firstword
        SIGNAL clk
        SIGNAL drop_pkt
        SIGNAL lastword
        SIGNAL waddr(7:0)
        SIGNAL XLXN_10
        SIGNAL XLXN_11
        SIGNAL fifowrite
        SIGNAL XLXN_13
        SIGNAL in_fifo(71:0)
        SIGNAL XLXN_15
        SIGNAL XLXN_16(7:0)
        SIGNAL raddr(7:0)
        SIGNAL XLXN_21
        SIGNAL XLXN_22
        SIGNAL fiforead
        SIGNAL XLXN_26
        SIGNAL valid_data
        SIGNAL rst
        SIGNAL XLXN_37
        SIGNAL XLXN_38
        SIGNAL XLXN_39(0:0)
        SIGNAL XLXN_40(71:0)
        SIGNAL out_fifo(71:0)
        SIGNAL XLXN_53(7:0)
        SIGNAL XLXN_54(71:0)
        SIGNAL processor_control
        SIGNAL processor_addr_in(7:0)
        SIGNAL processor_data_in(71:0)
        SIGNAL XLXN_64(0:0)
        SIGNAL processor_wea
        SIGNAL XLXN_70(7:0)
        SIGNAL packet_head(7:0)
        SIGNAL packet_tail(7:0)
        SIGNAL XLXN_71
        SIGNAL fifo_empty
        PORT Input firstword
        PORT Input clk
        PORT Input lastword
        PORT Input fifowrite
        PORT Input in_fifo(71:0)
        PORT Input fiforead
        PORT Output valid_data
        PORT Input rst
        PORT Output out_fifo(71:0)
        PORT Input processor_control
        PORT Input processor_addr_in(7:0)
        PORT Input processor_data_in(71:0)
        PORT Input processor_wea
        PORT Output packet_head(7:0)
        PORT Output packet_tail(7:0)
        PORT Output fifo_empty
        BEGIN BLOCKDEF fd
            TIMESTAMP 2000 1 1 10 10 10
            RECTANGLE N 64 -320 320 -64 
            LINE N 0 -128 64 -128 
            LINE N 0 -256 64 -256 
            LINE N 384 -256 320 -256 
            LINE N 80 -128 64 -144 
            LINE N 64 -112 80 -128 
        END BLOCKDEF
        BEGIN BLOCKDEF reg9B
            TIMESTAMP 2016 1 27 20 22 58
            RECTANGLE N 64 0 320 256 
            LINE N 64 160 0 160 
            LINE N 64 96 0 96 
            LINE N 64 224 0 224 
            LINE N 64 32 0 32 
            RECTANGLE N 0 20 64 44 
            LINE N 320 32 384 32 
            RECTANGLE N 320 20 384 44 
        END BLOCKDEF
        BEGIN BLOCKDEF fd8ce
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 0 -128 64 -128 
            LINE N 0 -192 64 -192 
            LINE N 0 -32 64 -32 
            LINE N 0 -256 64 -256 
            LINE N 384 -256 320 -256 
            LINE N 192 -32 64 -32 
            LINE N 192 -64 192 -32 
            LINE N 80 -128 64 -144 
            LINE N 64 -112 80 -128 
            RECTANGLE N 320 -268 384 -244 
            RECTANGLE N 0 -268 64 -244 
            RECTANGLE N 64 -320 320 -64 
        END BLOCKDEF
        BEGIN BLOCKDEF comp8
            TIMESTAMP 2000 1 1 10 10 10
            RECTANGLE N 64 -384 320 -64 
            LINE N 384 -224 320 -224 
            RECTANGLE N 0 -332 64 -308 
            LINE N 0 -320 64 -320 
            RECTANGLE N 0 -140 64 -116 
            LINE N 0 -128 64 -128 
        END BLOCKDEF
        BEGIN BLOCKDEF fdc
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 0 -128 64 -128 
            LINE N 0 -32 64 -32 
            LINE N 0 -256 64 -256 
            LINE N 384 -256 320 -256 
            RECTANGLE N 64 -320 320 -64 
            LINE N 64 -112 80 -128 
            LINE N 80 -128 64 -144 
            LINE N 192 -64 192 -32 
            LINE N 192 -32 64 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF cb8ce
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 384 -128 320 -128 
            RECTANGLE N 320 -268 384 -244 
            LINE N 384 -256 320 -256 
            LINE N 0 -192 64 -192 
            LINE N 192 -32 64 -32 
            LINE N 192 -64 192 -32 
            LINE N 80 -128 64 -144 
            LINE N 64 -112 80 -128 
            LINE N 0 -128 64 -128 
            LINE N 0 -32 64 -32 
            LINE N 384 -192 320 -192 
            RECTANGLE N 64 -320 320 -64 
        END BLOCKDEF
        BEGIN BLOCKDEF cb8cle
            TIMESTAMP 2000 1 1 10 10 10
            RECTANGLE N 64 -448 320 -64 
            LINE N 0 -192 64 -192 
            LINE N 192 -32 64 -32 
            LINE N 192 -64 192 -32 
            LINE N 80 -128 64 -144 
            LINE N 64 -112 80 -128 
            LINE N 0 -128 64 -128 
            LINE N 0 -32 64 -32 
            LINE N 0 -256 64 -256 
            LINE N 0 -384 64 -384 
            RECTANGLE N 0 -396 64 -372 
            LINE N 384 -384 320 -384 
            LINE N 384 -192 320 -192 
            RECTANGLE N 320 -396 384 -372 
            LINE N 384 -128 320 -128 
        END BLOCKDEF
        BEGIN BLOCKDEF or2
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 0 -64 64 -64 
            LINE N 0 -128 64 -128 
            LINE N 256 -96 192 -96 
            ARC N 28 -224 204 -48 112 -48 192 -96 
            ARC N -40 -152 72 -40 48 -48 48 -144 
            LINE N 112 -144 48 -144 
            ARC N 28 -144 204 32 192 -96 112 -144 
            LINE N 112 -48 48 -48 
        END BLOCKDEF
        BEGIN BLOCKDEF and2b1
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 64 -48 64 -144 
            LINE N 64 -144 144 -144 
            LINE N 144 -48 64 -48 
            ARC N 96 -144 192 -48 144 -48 144 -144 
            LINE N 256 -96 192 -96 
            LINE N 0 -128 64 -128 
            LINE N 0 -64 40 -64 
            CIRCLE N 40 -76 64 -52 
        END BLOCKDEF
        BEGIN BLOCKDEF vcc
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 64 -32 64 -64 
            LINE N 64 0 64 -32 
            LINE N 96 -64 32 -64 
        END BLOCKDEF
        BEGIN BLOCKDEF and3b2
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 0 -64 40 -64 
            CIRCLE N 40 -76 64 -52 
            LINE N 0 -128 40 -128 
            CIRCLE N 40 -140 64 -116 
            LINE N 0 -192 64 -192 
            LINE N 256 -128 192 -128 
            LINE N 64 -64 64 -192 
            ARC N 96 -176 192 -80 144 -80 144 -176 
            LINE N 144 -80 64 -80 
            LINE N 64 -176 144 -176 
        END BLOCKDEF
        BEGIN BLOCKDEF gnd
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 64 -64 64 -96 
            LINE N 76 -48 52 -48 
            LINE N 68 -32 60 -32 
            LINE N 88 -64 40 -64 
            LINE N 64 -64 64 -80 
            LINE N 64 -128 64 -96 
        END BLOCKDEF
        BEGIN BLOCKDEF dataMem
            TIMESTAMP 2016 3 2 23 27 2
            RECTANGLE N 32 32 544 576 
            BEGIN LINE W 0 80 32 80 
            END LINE
            BEGIN LINE W 0 112 32 112 
            END LINE
            BEGIN LINE W 0 208 32 208 
            END LINE
            LINE N 0 272 32 272 
            BEGIN LINE W 0 336 32 336 
            END LINE
            LINE N 0 528 32 528 
            BEGIN LINE W 576 336 544 336 
            END LINE
        END BLOCKDEF
        BEGIN BLOCKDEF m2_1
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 96 -64 96 -192 
            LINE N 256 -96 96 -64 
            LINE N 256 -160 256 -96 
            LINE N 96 -192 256 -160 
            LINE N 176 -32 96 -32 
            LINE N 176 -80 176 -32 
            LINE N 0 -32 96 -32 
            LINE N 320 -128 256 -128 
            LINE N 0 -96 96 -96 
            LINE N 0 -160 96 -160 
        END BLOCKDEF
        BEGIN BLOCKDEF buf
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 0 -32 64 -32 
            LINE N 224 -32 128 -32 
            LINE N 64 0 128 -32 
            LINE N 128 -32 64 -64 
            LINE N 64 -64 64 0 
        END BLOCKDEF
        BEGIN BLOCK XLXI_1 fd
            PIN C clk
            PIN D firstword
            PIN Q XLXN_10
        END BLOCK
        BEGIN BLOCK XLXI_2 fd
            PIN C clk
            PIN D lastword
            PIN Q XLXN_11
        END BLOCK
        BEGIN BLOCK XLXI_3 fd
            PIN C clk
            PIN D fifowrite
            PIN Q XLXN_39(0:0)
        END BLOCK
        BEGIN BLOCK XLXI_4 reg9B
            PIN ce XLXN_15
            PIN clk clk
            PIN clr rst
            PIN d(71:0) in_fifo(71:0)
            PIN q(71:0) XLXN_40(71:0)
        END BLOCK
        BEGIN BLOCK XLXI_5 fd8ce
            PIN C clk
            PIN CE XLXN_38
            PIN CLR rst
            PIN D(7:0) waddr(7:0)
            PIN Q(7:0) XLXN_16(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_6 comp8
            PIN A(7:0) waddr(7:0)
            PIN B(7:0) raddr(7:0)
            PIN EQ XLXN_71
        END BLOCK
        BEGIN BLOCK XLXI_7 comp8
            PIN A(7:0) raddr(7:0)
            PIN B(7:0) XLXN_16(7:0)
            PIN EQ XLXN_21
        END BLOCK
        BEGIN BLOCK XLXI_8 fd
            PIN C clk
            PIN D drop_pkt
            PIN Q XLXN_37
        END BLOCK
        BEGIN BLOCK XLXI_9 fdc
            PIN C clk
            PIN CLR rst
            PIN D XLXN_26
            PIN Q valid_data
        END BLOCK
        BEGIN BLOCK XLXI_10 cb8ce
            PIN C clk
            PIN CE XLXN_26
            PIN CLR rst
            PIN CEO
            PIN Q(7:0) raddr(7:0)
            PIN TC
        END BLOCK
        BEGIN BLOCK XLXI_11 cb8cle
            PIN C clk
            PIN CE XLXN_39(0:0)
            PIN CLR rst
            PIN D(7:0) XLXN_16(7:0)
            PIN L XLXN_37
            PIN CEO
            PIN Q(7:0) waddr(7:0)
            PIN TC
        END BLOCK
        BEGIN BLOCK XLXI_13 or2
            PIN I0 XLXN_11
            PIN I1 XLXN_10
            PIN O XLXN_13
        END BLOCK
        BEGIN BLOCK XLXI_14 and2b1
            PIN I0 XLXN_37
            PIN I1 XLXN_13
            PIN O XLXN_38
        END BLOCK
        BEGIN BLOCK XLXI_15 vcc
            PIN P XLXN_15
        END BLOCK
        BEGIN BLOCK XLXI_17 and3b2
            PIN I0 XLXN_21
            PIN I1 XLXN_71
            PIN I2 fiforead
            PIN O XLXN_26
        END BLOCK
        BEGIN BLOCK XLXI_18 gnd
            PIN G drop_pkt
        END BLOCK
        BEGIN BLOCK XLXI_19 dataMem
            PIN clka clk
            PIN clkb clk
            PIN dina(71:0) XLXN_54(71:0)
            PIN addra(7:0) XLXN_53(7:0)
            PIN wea(0:0) XLXN_64(0:0)
            PIN addrb(7:0) XLXN_70(7:0)
            PIN doutb(71:0) out_fifo(71:0)
        END BLOCK
        BEGIN BLOCK XLXI_21(7:0) m2_1
            PIN D0 waddr(7:0)
            PIN D1 processor_addr_in(7:0)
            PIN S0 processor_control
            PIN O XLXN_53(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_22(71:0) m2_1
            PIN D0 XLXN_40(71:0)
            PIN D1 processor_data_in(71:0)
            PIN S0 processor_control
            PIN O XLXN_54(71:0)
        END BLOCK
        BEGIN BLOCK XLXI_23 m2_1
            PIN D0 XLXN_39(0:0)
            PIN D1 processor_wea
            PIN S0 processor_control
            PIN O XLXN_64(0:0)
        END BLOCK
        BEGIN BLOCK XLXI_24(7:0) m2_1
            PIN D0 raddr(7:0)
            PIN D1 processor_addr_in(7:0)
            PIN S0 processor_control
            PIN O XLXN_70(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_25(7:0) buf
            PIN I waddr(7:0)
            PIN O packet_tail(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_26(7:0) buf
            PIN I raddr(7:0)
            PIN O packet_head(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_27 or2
            PIN I0 XLXN_21
            PIN I1 XLXN_71
            PIN O fifo_empty
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        INSTANCE XLXI_1 512 512 R0
        INSTANCE XLXI_2 512 864 R0
        INSTANCE XLXI_3 1440 576 R0
        BEGIN INSTANCE XLXI_4 2176 384 R0
        END INSTANCE
        INSTANCE XLXI_5 720 1264 R0
        INSTANCE XLXI_6 1168 1776 R0
        INSTANCE XLXI_7 1168 2272 R0
        INSTANCE XLXI_8 576 2688 R0
        INSTANCE XLXI_10 2112 1760 R0
        INSTANCE XLXI_11 2016 1248 R0
        INSTANCE XLXI_9 2224 2304 R0
        BEGIN BRANCH firstword
            WIRE 288 256 336 256
            WIRE 336 256 512 256
            BEGIN DISPLAY 336 256 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 288 256 firstword R180 28
        IOMARKER 272 2544 clk R270 28
        BEGIN BRANCH drop_pkt
            WIRE 384 2336 384 2416
            WIRE 384 2336 464 2336
            WIRE 464 2336 464 2432
            WIRE 464 2432 496 2432
            WIRE 496 2432 576 2432
            BEGIN DISPLAY 496 2432 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH lastword
            WIRE 304 608 352 608
            WIRE 352 608 512 608
            BEGIN DISPLAY 352 608 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 304 608 lastword R180 28
        INSTANCE XLXI_13 1072 640 R0
        BEGIN BRANCH XLXN_10
            WIRE 896 256 976 256
            WIRE 976 256 976 512
            WIRE 976 512 1072 512
        END BRANCH
        BEGIN BRANCH XLXN_11
            WIRE 896 608 976 608
            WIRE 976 576 976 608
            WIRE 976 576 1072 576
        END BRANCH
        BEGIN BRANCH fifowrite
            WIRE 1328 320 1360 320
            WIRE 1360 320 1440 320
            BEGIN DISPLAY 1360 320 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 1328 320 fifowrite R180 28
        INSTANCE XLXI_14 1408 672 R0
        BEGIN BRANCH XLXN_13
            WIRE 1328 544 1408 544
        END BRANCH
        BEGIN BRANCH in_fifo(71:0)
            WIRE 2080 416 2096 416
            WIRE 2096 416 2176 416
            BEGIN DISPLAY 2096 416 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 2080 416 in_fifo(71:0) R180 28
        INSTANCE XLXI_15 1808 544 R0
        BEGIN BRANCH XLXN_15
            WIRE 1872 544 1872 608
            WIRE 1872 608 1968 608
            WIRE 1968 544 1968 608
            WIRE 1968 544 2176 544
        END BRANCH
        BEGIN BRANCH XLXN_16(7:0)
            WIRE 1088 1328 1088 2144
            WIRE 1088 2144 1168 2144
            WIRE 1088 1328 1488 1328
            WIRE 1104 1008 1488 1008
            WIRE 1488 1008 1552 1008
            WIRE 1488 1008 1488 1328
            WIRE 1552 864 1552 1008
            WIRE 1552 864 2016 864
        END BRANCH
        INSTANCE XLXI_17 1680 1680 R0
        BEGIN BRANCH XLXN_21
            WIRE 1552 2048 1616 2048
            WIRE 1616 1616 1680 1616
            WIRE 1616 1616 1616 1984
            WIRE 1616 1984 1616 2048
            WIRE 1616 1984 1728 1984
            WIRE 1728 1984 1728 2400
            WIRE 1728 2400 1856 2400
        END BRANCH
        BEGIN BRANCH fiforead
            WIRE 1568 1488 1600 1488
            WIRE 1600 1488 1680 1488
            BEGIN DISPLAY 1600 1488 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 1568 1488 fiforead R180 28
        BEGIN BRANCH XLXN_26
            WIRE 1936 1552 2016 1552
            WIRE 2016 1552 2016 1568
            WIRE 2016 1568 2112 1568
            WIRE 2016 1568 2016 2048
            WIRE 2016 2048 2224 2048
        END BRANCH
        BEGIN BRANCH valid_data
            WIRE 2608 2048 2720 2048
            WIRE 2720 2048 2880 2048
            BEGIN DISPLAY 2720 2048 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 2880 2048 valid_data R0 28
        BEGIN BRANCH rst
            WIRE 720 1232 720 1312
            WIRE 720 1312 1648 1312
            WIRE 1648 1312 1808 1312
            WIRE 1808 1312 2032 1312
            WIRE 1808 1312 1808 1472
            WIRE 1808 1472 2048 1472
            WIRE 2048 1472 2048 1728
            WIRE 2048 1728 2112 1728
            WIRE 1648 736 1648 1312
            WIRE 1648 736 2032 736
            WIRE 1792 1216 1824 1216
            WIRE 1824 1216 1872 1216
            WIRE 1872 1216 2016 1216
            WIRE 1872 1216 1872 1296
            WIRE 1872 1296 2032 1296
            WIRE 2032 1296 2032 1312
            WIRE 2000 1728 2000 2272
            WIRE 2000 2272 2224 2272
            WIRE 2000 1728 2048 1728
            WIRE 2032 608 2032 736
            WIRE 2032 608 2176 608
            BEGIN DISPLAY 1824 1216 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 1792 1216 rst R180 28
        BEGIN BRANCH XLXN_37
            WIRE 960 2432 1136 2432
            WIRE 1136 2432 1584 2432
            WIRE 1136 608 1136 2432
            WIRE 1136 608 1408 608
            WIRE 1584 992 1584 2432
            WIRE 1584 992 2016 992
        END BRANCH
        BEGIN BRANCH XLXN_38
            WIRE 656 1072 720 1072
            WIRE 656 1072 656 1296
            WIRE 656 1296 1712 1296
            WIRE 1664 576 1712 576
            WIRE 1712 576 1712 1296
        END BRANCH
        BEGIN BRANCH out_fifo(71:0)
            WIRE 3248 1888 3248 1968
            WIRE 3248 1968 3312 1968
            WIRE 3248 1888 3328 1888
            WIRE 3328 1776 3328 1888
            WIRE 3328 1776 3504 1776
            WIRE 3488 1168 3504 1168
            WIRE 3504 1168 3504 1776
            BEGIN DISPLAY 3328 1776 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        INSTANCE XLXI_18 320 2544 R0
        IOMARKER 3312 1968 out_fifo(71:0) R0 28
        BEGIN BRANCH clk
            WIRE 272 2544 272 2560
            WIRE 272 2560 304 2560
            WIRE 304 2560 384 2560
            WIRE 384 2560 576 2560
            WIRE 384 2544 384 2560
            WIRE 384 2544 528 2544
            WIRE 432 384 512 384
            WIRE 432 384 432 480
            WIRE 432 480 432 736
            WIRE 432 736 512 736
            WIRE 432 736 432 816
            WIRE 432 816 528 816
            WIRE 528 816 528 1136
            WIRE 528 1136 720 1136
            WIRE 528 1136 528 1392
            WIRE 528 1392 528 2544
            WIRE 432 480 928 480
            WIRE 512 1392 528 1392
            WIRE 512 1392 512 1776
            WIRE 512 1776 1984 1776
            WIRE 928 448 928 480
            WIRE 928 448 1440 448
            WIRE 1952 1120 2016 1120
            WIRE 1952 1120 1952 1232
            WIRE 1952 1232 2096 1232
            WIRE 2096 1232 2096 1296
            WIRE 2096 1296 2096 1360
            WIRE 2096 1360 2096 1632
            WIRE 2096 1632 2112 1632
            WIRE 2096 1632 2096 2176
            WIRE 2096 2176 2224 2176
            WIRE 2096 1296 2416 1296
            WIRE 1984 480 2176 480
            WIRE 1984 480 1984 1360
            WIRE 1984 1360 1984 1776
            WIRE 1984 1360 2096 1360
            WIRE 2416 1184 2416 1296
            WIRE 2416 1184 2704 1184
            WIRE 2704 1184 2704 1360
            WIRE 2704 1360 2912 1360
            WIRE 2704 1104 2912 1104
            WIRE 2704 1104 2704 1184
            BEGIN DISPLAY 304 2560 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_19 2912 832 R0
        END INSTANCE
        BEGIN BRANCH waddr(7:0)
            WIRE 272 1008 272 1168
            WIRE 272 1168 272 1456
            WIRE 272 1456 1168 1456
            WIRE 272 1456 272 1552
            WIRE 272 1008 544 1008
            WIRE 544 1008 720 1008
            WIRE 544 864 544 1008
            WIRE 544 864 960 864
            WIRE 960 768 960 864
            WIRE 960 768 2528 768
            WIRE 2528 768 2528 864
            WIRE 2528 864 2528 1248
            WIRE 1344 208 1344 1248
            WIRE 1344 1248 2528 1248
            WIRE 1344 208 2656 208
            WIRE 2656 208 2656 480
            WIRE 2656 480 2896 480
            WIRE 2400 864 2528 864
            BEGIN DISPLAY 272 1168 ATTR Name
                ALIGNMENT SOFT-TVCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_53(7:0)
            WIRE 2896 800 2896 912
            WIRE 2896 912 2912 912
            WIRE 2896 800 3296 800
            WIRE 3216 448 3296 448
            WIRE 3296 448 3296 800
        END BRANCH
        BEGIN BRANCH XLXN_40(71:0)
            WIRE 2560 416 2576 416
            WIRE 2576 416 2576 720
            WIRE 2576 720 2592 720
        END BRANCH
        INSTANCE XLXI_21(7:0) 2896 320 M180
        BEGIN BRANCH XLXN_54(71:0)
            WIRE 2880 816 2880 944
            WIRE 2880 944 2912 944
            WIRE 2880 816 2992 816
            WIRE 2912 688 2992 688
            WIRE 2992 688 2992 816
        END BRANCH
        INSTANCE XLXI_22(71:0) 2592 560 M180
        BEGIN BRANCH processor_control
            WIRE 2592 448 2592 592
            WIRE 2592 448 2816 448
            WIRE 2608 320 2640 320
            WIRE 2640 320 2816 320
            WIRE 2816 320 2896 320
            WIRE 2896 320 2896 352
            WIRE 2816 320 2816 448
            BEGIN DISPLAY 2640 320 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 2608 320 processor_control R180 28
        BEGIN BRANCH processor_addr_in(7:0)
            WIRE 2096 176 2544 176
            WIRE 2544 176 2752 176
            WIRE 2752 176 2752 416
            WIRE 2752 416 2896 416
            BEGIN DISPLAY 2544 176 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH processor_data_in(71:0)
            WIRE 2096 112 2576 112
            WIRE 2576 112 2736 112
            WIRE 2736 112 2736 240
            WIRE 2112 240 2112 656
            WIRE 2112 656 2592 656
            WIRE 2112 240 2736 240
            BEGIN DISPLAY 2576 112 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH raddr(7:0)
            WIRE 1152 1648 1168 1648
            WIRE 1152 1648 1152 1808
            WIRE 1152 1808 1152 1952
            WIRE 1152 1952 1168 1952
            WIRE 1152 1808 2608 1808
            WIRE 2608 1808 2656 1808
            WIRE 2496 1504 2560 1504
            WIRE 2560 1504 2608 1504
            WIRE 2608 1504 2608 1584
            WIRE 2608 1584 2608 1808
            WIRE 2608 1584 2704 1584
            BEGIN DISPLAY 2560 1504 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_39(0:0)
            WIRE 1824 320 1888 320
            WIRE 1888 320 1888 448
            WIRE 1888 448 1920 448
            WIRE 1920 448 1920 1056
            WIRE 1920 1056 2016 1056
            WIRE 1920 1056 1920 1280
            WIRE 1920 1280 2464 1280
            WIRE 2464 1040 2464 1280
            WIRE 2464 1040 2512 1040
            WIRE 2512 1040 2512 1072
            WIRE 2512 1072 2560 1072
        END BRANCH
        BEGIN BRANCH XLXN_64(0:0)
            WIRE 2880 1040 2912 1040
        END BRANCH
        INSTANCE XLXI_23 2560 912 M180
        BEGIN BRANCH processor_control
            WIRE 2560 832 2576 832
            WIRE 2560 832 2560 880
            WIRE 2560 880 2560 944
            BEGIN DISPLAY 2560 880 ATTR Name
                ALIGNMENT SOFT-TVCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH processor_wea
            WIRE 2432 992 2432 1008
            WIRE 2432 1008 2448 1008
            WIRE 2448 1008 2560 1008
            BEGIN DISPLAY 2448 1008 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH processor_wea
            WIRE 2032 64 2432 64
            WIRE 2432 48 2752 48
            WIRE 2432 48 2432 64
            BEGIN DISPLAY 2432 48 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        INSTANCE XLXI_24(7:0) 2704 1424 M180
        BEGIN BRANCH processor_control
            WIRE 2608 1392 2640 1392
            WIRE 2640 1392 2704 1392
            WIRE 2704 1392 2704 1456
            BEGIN DISPLAY 2640 1392 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH processor_addr_in(7:0)
            WIRE 2656 1520 2672 1520
            WIRE 2672 1520 2704 1520
            BEGIN DISPLAY 2672 1520 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_70(7:0)
            WIRE 2848 1168 2912 1168
            WIRE 2848 1168 2848 1424
            WIRE 2848 1424 3088 1424
            WIRE 3088 1424 3088 1552
            WIRE 3024 1552 3088 1552
        END BRANCH
        INSTANCE XLXI_25(7:0) 240 1552 R90
        BEGIN BRANCH packet_tail(7:0)
            WIRE 272 1776 272 1824
            WIRE 272 1824 272 1904
            BEGIN DISPLAY 272 1824 ATTR Name
                ALIGNMENT SOFT-TVCENTER
            END DISPLAY
        END BRANCH
        INSTANCE XLXI_26(7:0) 2656 1840 R0
        BEGIN BRANCH packet_head(7:0)
            WIRE 2880 1808 2928 1808
            WIRE 2928 1808 3008 1808
            BEGIN DISPLAY 2928 1808 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 272 1904 packet_tail(7:0) R90 28
        IOMARKER 3008 1808 packet_head(7:0) R0 28
        IOMARKER 2096 112 processor_data_in(71:0) R180 28
        IOMARKER 2096 176 processor_addr_in(7:0) R180 28
        IOMARKER 2032 64 processor_wea R180 28
        INSTANCE XLXI_27 1856 2464 R0
        BEGIN BRANCH XLXN_71
            WIRE 1552 1552 1600 1552
            WIRE 1600 1552 1680 1552
            WIRE 1600 1552 1600 2336
            WIRE 1600 2336 1856 2336
        END BRANCH
        BEGIN BRANCH fifo_empty
            WIRE 2112 2368 2144 2368
            WIRE 2144 2368 2256 2368
            BEGIN DISPLAY 2144 2368 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 2256 2368 fifo_empty R0 28
    END SHEET
END SCHEMATIC
