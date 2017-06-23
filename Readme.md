# pmdconv
PMD 到 MIDI 的转换工具。

## 使用方法
`pmdconv <输入：PMD文件> [输出：MIDI文件]`

## 编译
请用 VS2017 编译，本程序需要 [midifile](https://github.com/craigsapp/midifile) 和 [pmdplay](https://github.com/lxfly2000/pmdplay) 来工作，可通过运行 `fetchlib.ps1` 获得。

### 提示
使用本程序前请先在程序目录中创建一个 `patch.txt` 文件，在里面写上 PMD 到 GM 的音色转换，一共 256 行，每行写对应的 GM 音色号即可。

## TODO
该程序目前正在制作中。