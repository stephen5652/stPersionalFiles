1. 早期版本的 ergodone 由于使用了 tmk 芯片， 芯片刷机工作模式为 hid bootloader, 需要使用 tkg-toolkit 来刷固件[链接](https://github.com/kairyu/tkg-toolkit.git)；
2. 刷固件的指令： ./hid_bootloader_cli -w -v -mmcu=atmega32u4 /Usrs/xxx/xxx/xxx/xxx.hex
3. 由于 ergodone 这样刷机比使用 QMK ToolBox 麻烦， 所以我自己用源码编译了 via 版本的固件， 可以使用 via 来改建。
4. 如果 via 改键过多，想恢复原来未改键的固件，可以按照上述方法刷回初始固件。
5. 我自己的另一款 ergodone, 使用的是 dfu 的刷机模式， 所以可以直接使用 QMK ToolBox 来刷固件，可以灵活的在 [ydkb](https://ydkb.io/) 制作自己的固件，脱离了对 via 的依赖。

tkg 相关资料：

1. 配列编辑与查看： https://config.qmk.fm/#/ktec/ergodone/LAYOUT_ergodox
2. tkg 在线刷固件【注意作者有一个网盘分享的使用说明】： https://yang.tkg.io/

感触： 如果再买入 ergodone 一定要问清如下几点：

1. 刷固件的方式【又称： 刷配列】
2. 轴体是否热插拔 【缺了热插拔，就丧失了一般的灵魂】
3. 如何改键， 是否开启了 via 【 注意：通过 ydkb 制作的固件，默认不开启 via, 所以以后还想体验 via 功能的话，最好问下作者，是否可以提供原始配列 .json 和 原始固件 .hex】
