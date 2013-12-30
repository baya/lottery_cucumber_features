# language: zh-CN

功能:追号过程中有中断，追号任务重启时应该完成剩余的追号

  背景:
    假设系统里有下面的彩种:
    |        name       | lotno  | money | moneymulti | betmore |
    |    重庆时时彩       | T01007 | 2     | 1          | 0       | 
    |    重庆时时彩[五星] | T01007 | 2     | 1          | 0       | 
    |    重庆时时彩[三星] | T01007 | 2     | 1          | 0       |
    |    重庆时时彩[二星] | T01007 | 2     | 1          | 0       |
    |    重庆时时彩[一星] | T01007 | 2     | 1          | 0       |
    | 重庆时时彩[大小单双] | T01007 | 2     | 1          | 0       |
    |    福彩3D[直选]    | F47103  | 2    |  1         |  0      |
    |    福彩3D[组六]    | F47103  | 2    |  1         |  0      |
    |    福彩3D[组三]    | F47103  | 2    |  1         |  0      |
    |    双色球          | F47104 | 2     | 1          | 0       |
    | 排列三[组六]       | T01002 | 2     | 1          | 0       |
    | 排列三[组三]       | T01002 | 2     | 1          | 0       |
    | 排列三[直选]       | T01002 | 2     | 1          | 0       |
    |    大乐透         | T01001 | 2     | 1          | 0       |

    并且我购买了下面的追号:
    | 彩种                | 追号期数 | 追号倍数 | 注码            | 已追期数  |
    | 重庆时时彩[五星]     | 5       |   2     | 02~09~05~00~03 |   1      | 
    | 重庆时时彩[五星]     | 5       |   2     | 01~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 03~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 05~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 06~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 07~09~05~00~03 |   1      |
    | 重庆时时彩[三星]     | 8       |   1     | 06~00~03       |   1      |
    | 重庆时时彩[三星]     | 8       |   1     | 07~00~03       |   1      |
    | 重庆时时彩[三星]     | 8       |   1     | 08~00~03       |   1      |
    | 重庆时时彩[二星]     | 8       |   1     | 05~08          |   1      |
    | 重庆时时彩[一星]     | 8       |   1     | 08             |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 02~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 01~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 03~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 04~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 05~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 06~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 07~09~05~00~03 |   1      |
    | 重庆时时彩[三星]     | 8       |   1     | 06~00~03       |   1      |
    | 重庆时时彩[三星]     | 8       |   1     | 07~00~03       |   1      |
    | 重庆时时彩[三星]     | 8       |   1     | 08~00~03       |   1      |
    | 重庆时时彩[二星]     | 8       |   1     | 05~08          |   1      |
    | 重庆时时彩[一星]     | 8       |   1     | 08             |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 02~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 02~09~05~00~03 |   1      | 
    | 重庆时时彩[五星]     | 5       |   2     | 01~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 03~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 05~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 06~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 07~09~05~00~03 |   1      |
    | 重庆时时彩[三星]     | 8       |   1     | 06~00~03       |   1      |
    | 重庆时时彩[三星]     | 8       |   1     | 07~00~03       |   1      |
    | 重庆时时彩[三星]     | 8       |   1     | 08~00~03       |   1      |
    | 重庆时时彩[二星]     | 8       |   1     | 05~08          |   1      |
    | 重庆时时彩[一星]     | 8       |   1     | 08             |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 02~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 01~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 03~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 04~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 05~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 06~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 07~09~05~00~03 |   1      |
    | 重庆时时彩[三星]     | 8       |   1     | 06~00~03       |   1      |
    | 重庆时时彩[三星]     | 8       |   1     | 07~00~03       |   1      |
    | 重庆时时彩[三星]     | 8       |   1     | 08~00~03       |   1      |
    | 重庆时时彩[二星]     | 8       |   1     | 05~08          |   1      |
    | 重庆时时彩[一星]     | 8       |   1     | 08             |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 02~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 02~09~05~00~03 |   1      | 
    | 重庆时时彩[五星]     | 5       |   2     | 01~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 03~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 05~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 06~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 07~09~05~00~03 |   1      |
    | 重庆时时彩[三星]     | 8       |   1     | 06~00~03       |   1      |
    | 重庆时时彩[三星]     | 8       |   1     | 07~00~03       |   1      |
    | 重庆时时彩[三星]     | 8       |   1     | 08~00~03       |   1      |
    | 重庆时时彩[二星]     | 8       |   1     | 05~08          |   1      |
    | 重庆时时彩[一星]     | 8       |   1     | 08             |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 02~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 01~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 03~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 04~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 05~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 06~09~05~00~03 |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 07~09~05~00~03 |   1      |
    | 重庆时时彩[三星]     | 8       |   1     | 06~00~03       |   1      |
    | 重庆时时彩[三星]     | 8       |   1     | 07~00~03       |   1      |
    | 重庆时时彩[三星]     | 8       |   1     | 08~00~03       |   1      |
    | 重庆时时彩[二星]     | 8       |   1     | 05~08          |   1      |
    | 重庆时时彩[一星]     | 8       |   1     | 08             |   1      |
    | 重庆时时彩[五星]     | 5       |   2     | 02~09~05~00~03 |   1      |


  场景:追号过程中断，立即重启追号任务
    当"重庆时时彩"的新期入库后
    假设追号任务"中断"
    那么会有部分追号未完成
    当追号任务重新启动完成后
    那么应该完成全部追号
