# language: zh-CN

功能:追号入库

  背景:
    假设系统里有下面的彩种:
    |        name       | lotno  | money | moneymulti | betmore |
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


   场景大纲: 追号成功,入库
     当客户投注"<彩种>"
     并且客户选择号码"<注码>"进行投注
     同时客户选择"<倍数>"倍
     同时客户追"<期数>"期
     当第"1"次新期入库后
     同时系统检测到新期
     并且投注"成功"
     当完成入库操作后
     那么应该生成正确的入库记录
     并且不应该重复入库


   例子: 各彩种追号成功,入库
     | 彩种               |   注码            | 倍数 | 期数 |
     | 重庆时时彩[五星]    | 06~08~05~01~08    | 1   | 3    |
     | 重庆时时彩[三星]    |   05~01~08        | 1   | 3    |
     | 重庆时时彩[二星]    |   05~08           | 1   | 3    |
     | 重庆时时彩[一星]    |   08              | 1   | 3    |
     | 重庆时时彩[大小单双] |   大~单           | 1   | 3    |
     | 双色球             | 010203040513~01   | 16  | 3    |
     | 大乐透             | 0304060725~0409   | 5   | 3    |
     | 排列三[组六]       | 00020304           | 1   | 3    |
     | 排列三[组三]       | 0002               | 1   | 3    |
     | 排列三[直选]       | 00~02~06           | 1   | 3    |
     | 福彩3D[组六]       | 010203             | 1   | 3    |
     | 福彩3D[组三]       | 0102               | 1   | 3    |
     | 福彩3D[直选]       | 01~01~02           | 1   | 3    |



   场景大纲: 追号重试,不入库
     当客户投注"<彩种>"
     并且客户选择号码"<注码>"进行投注
     同时客户选择"<倍数>"倍
     同时客户追"<期数>"期
     当第"1"次新期入库后
     同时系统检测到新期
     并且投注"不成功"
     当完成入库操作后
     那么应该不生成入库记录


   例子: 各彩种追号重试,不入库
     | 彩种               |   注码            | 倍数 | 期数 |
     | 重庆时时彩[五星]    | 06~08~05~01~08    | 1   | 3    |
     | 重庆时时彩[三星]    |   05~01~08        | 1   | 3    |
     | 重庆时时彩[二星]    |   05~08           | 1   | 3    |
     | 重庆时时彩[一星]    |   08              | 1   | 3    |
     | 重庆时时彩[大小单双] |   大~单           | 1   | 3    |
     | 双色球             | 010203040513~01   | 16  | 3    |
     | 大乐透             | 0304060725~0409   | 5   | 3    |
     | 排列三[组六]       | 00020304           | 1   | 3    |
     | 排列三[组三]       | 0002               | 1   | 3    |
     | 排列三[直选]       | 00~02~06           | 1   | 3    |
     | 福彩3D[组六]       | 010203             | 1   | 3    |
     | 福彩3D[组三]       | 0102               | 1   | 3    |
     | 福彩3D[直选]       | 01~01~02           | 1   | 3    |



   场景大纲: 追号失败,入库
     当客户投注"<彩种>"
     并且客户选择号码"<注码>"进行投注
     同时客户选择"<倍数>"倍
     同时客户追"<期数>"期
     当第"1"次新期入库后
     同时系统检测到新期
     并且投注"不成功"
     当重试投注"3"次后
     但是投注"不成功"
     当完成入库操作后
     那么应该生成正确的入库记录
     并且不应该重复入库


   例子: 各彩种追号失败,入库
     | 彩种               |   注码            | 倍数 | 期数 |
     | 重庆时时彩[五星]    | 06~08~05~01~08    | 1   | 3    |
     | 重庆时时彩[三星]    |   05~01~08        | 1   | 3    |
     | 重庆时时彩[二星]    |   05~08           | 1   | 3    |
     | 重庆时时彩[一星]    |   08              | 1   | 3    |
     | 重庆时时彩[大小单双] |   大~单           | 1   | 3    | 
     | 双色球             | 010203040513~01   | 16  | 3    |
     | 大乐透             | 0304060725~0409   | 5   | 3    |
     | 排列三[组六]       | 00020304           | 1   | 3    |
     | 排列三[组三]       | 0002               | 1   | 3    |
     | 排列三[直选]       | 00~02~06           | 1   | 3    |
     | 福彩3D[组六]       | 010203             | 1   | 3    |
     | 福彩3D[组三]       | 0102               | 1   | 3    |
     | 福彩3D[直选]       | 01~01~02           | 1   | 3    |

