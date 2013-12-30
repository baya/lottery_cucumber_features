# language: zh-CN

功能:追双色球
  为了方便客户使用相同的号码连续投注多个双色球

  背景:
    假设系统里有下面的彩种:
    |    name        | lotno  | money |moneymulti  | betmore |
    |    双色球       | F47104 | 2     | 1          | 0       | 

  场景大纲: 追双色球
    当客户投注"<彩种>"
    并且客户选择号码"<注码>"进行投注
    并且客户选择"<倍数>"倍
    同时客户追"<期数>"期
    当第"1"次新期入库后
    同时系统检测到新期
    并且投注"成功"
    那么客户应该增加"1"条新的投注记录
    并且投注号码是"<注码>"
    同时客户的投注结果应该成功
    同时客户投注结果应该入库成功
    当第"2"次新期入库后
    同时系统检测到新期
    并且投注"成功"
    那么客户应该增加"1"条新的投注记录
    并且投注号码是"<注码>"
    同时客户的投注结果应该成功
    同时客户投注结果应该入库成功
    当第"3"次新期入库后
    同时系统检测到新期
    并且投注"成功"
    那么客户应该增加"1"条新的投注记录
    并且投注号码是"<注码>"
    并且客户的投注结果应该成功
    同时客户投注结果应该入库成功
    同时客户的追号应该结束
    当第"4"次新期入库后
    那么客户不会产生新的投注记录

  @hd-ld
  例子: 红单蓝单
    | 彩种   |   注码                  | 倍数 | 期数 |
    | 双色球  | 010203040512~01        | 1   | 3    |
    | 双色球  | 010203040510~01        | 5   | 3    |
    | 双色球  | 010203040513~01        | 16  | 3    |

  @hf-ld
  例子: 红复蓝单
    | 彩种   |   注码                  | 倍数 | 期数 |
    | 双色球  | 010203040506070809~01  | 1   | 3    |
    | 双色球  | 010203040508091013~01  | 11  | 3    |
    | 双色球  | 010203040508091516~01  | 6   | 3    |

  @hd-lf
  例子: 红单蓝复
    | 彩种   |   注码                  | 倍数 | 期数 |
    | 双色球  | 060712161833~0710      | 1   | 3    |

  @hf-lf
  例子: 红复蓝复
    | 彩种   |   注码                  | 倍数 | 期数 |
    | 双色球  | 0102030405060708~0102  | 1   | 3    |
    | 双色球  | 0102030405080910~0103  | 10  | 3    |
    | 双色球  | 0102030405080915~0204  | 7   | 3    |

  @hdt-ld
  例子: 红胆拖蓝单
    | 彩种   |   注码                  | 倍数 | 期数 |
    | 双色球  | 01*02030405060708~01   | 1   | 3    |
    | 双色球  | 0102*030405080910~03   | 23  | 3    |
    | 双色球  | 010203*0405080915~04   | 4   | 3    |

  @hdt-lf
  例子: 红胆拖蓝复
    | 彩种   |   注码                  | 倍数 | 期数 |
    | 双色球  | 01*02030405060709~0102 | 1   | 3    |
    | 双色球  | 010203*0405080912~0304 | 32  | 3    |
    | 双色球  | 01020304*05080916~0405 | 2   | 3    |

  @hh
  例子: 混合
    | 彩种   |   注码                           | 倍数 | 期数 |
    | 双色球  | 32*031221223031~04              | 1   | 3    | 
    | 双色球  | 030817192326~04                 | 1   | 3    |
    | 双色球  | 16*0506152526~16                | 1   | 3    |
    | 双色球  | 061516172627~06                 | 3   | 3    |
    | 双色球  | 061718*26272829~07              | 1   | 3    |
    | 双色球  | 01112122313233~01*              | 1   | 3    |
    | 双色球  | 01111221223132~02*              | 1   | 3    |
    | 双色球  | 212232*01111231~02*             | 1   | 3    |
    | 双色球  | 101120252728~12                 | 1   | 3    |
    | 双色球  | 060712161833~0710               | 1   | 3    |
    | 双色球  | 0608101213151619202532~060709   | 1   | 3    |
    | 双色球  | 010902040610132328~15^          | 1   | 3    |

