# -*- coding: utf-8 -*-

假设 /^系统里有下面的彩种:$/ do |lot_type_table|
  lot_type_table.hashes.each {|lot_type| Pa::Lotterytype.create(lot_type) }
end

当 /^客户投注"(.*?)"$/ do |lot_type_name|
  @lot_type = Pa::Lotterytype.where(name: lot_type_name).first
  @bet = Fabricate.build('Pa::Bet', lotterytypeid: @lot_type.lotterytypeid)
end

假如 /^客户选择号码"(.*?)"进行投注$/ do |wager|
  if @lot_type.name =~ /大小单双/ and !(wager =~ /\d/)
    wager = dxds_wager(wager)
  end  
  @bet.wager = wager
end

当 /^客户选择"(.*?)"倍$/ do |multi|
  @multi = multi.to_i
  multi = "%02d" % @multi
  @bet.wager = "#{multi}#{@bet.wager}"
  @bet.betsum = @bet.converter.wager_to_betsum
  @bet.betmoney = @lot_type.money * 100 * @multi * @bet.betsum
  @bet.save
end

假如 /^客户追"(.*?)"期$/ do |num|
  @prebet = Fabricate('Pa::Prebet', 
                       lotterytypeid: @lot_type.lotterytypeid,
                       sum:           @bet.betsum,
                       money:         num.to_i * @bet.betmoney / 100,
                       terms:         num,
                       wager:         @bet.wager 
                       )
end

当 /^第"(.*?)"次新期入库后$/ do |term_no|
  # 记录新期入库前的bet count
  @fresh_bet_count = Pa::AutoBet.where(wager: @bet.wager).count

  # 设置last_issue为空,这样可以在同一彩期内多次投注，使测试进行下去
  @prebet.last_issue = ''
  # 设置termid为0,原因同上
  @prebet.termid = 0
  @prebet.save

  @lot_term = get_or_create_lot_term(@lot_type)
  # 设置starttime大于追号记录的createtime，以模拟新期
  @lot_term.starttime = @prebet.createtime + 1.hour
  @lot_term.save
  @term_no = term_no

  # 创建父彩种的彩期
  p_lot_name = LotTable.l2s(@lot_type.name)
  @p_lot_type = Pa::Lotterytype.where(name: p_lot_name).first
  @p_lot_term = get_or_create_lot_term(@p_lot_type)
  @p_lot_term.starttime = @prebet.createtime + 1.hour
  @p_lot_term.save

  
end

当 /^系统检测到新期$/ do
end

那么 /^客户应该增加"(.*?)"条新的投注记录$/ do |num|
  Pa::AutoBet.where(wager: @prebet.wager).count.should == @fresh_bet_count + num.to_i
end

那么 /^投注号码是"(.*?)"$/ do |wager|
  Pa::AutoBet.count.should == Pa::AutoBet.where(wager: @prebet.wager).count
end

那么 /客户的投注结果应该成功$/ do
  @auto_bet = @lot_term.auto_bets.order('createtime DESC').first
  @auto_bet.status.should == Pa::AutoBet::SM['成功'].code
  @prebet.reload
  @prebet.last_issue.should == @lot_term.issue
  @prebet.termeds.should == @term_no.to_i
end

那么 /^客户投注结果应该入库成功$/ do
  bet = Pa::Bet.where(ordersn: @auto_bet.ordersn).first
  bet.status.should == @auto_bet.status
  
  # 目前追号只支持金软渠道
  bet.dealterid.should == 1
  bet.dealtersign.should == 'jr'
  
end

那么 /^客户的追号应该结束$/ do
  @prebet.reload
  @prebet.status.should == Pa::Prebet::SM['终止'].code
  @prebet.termeds.should == @prebet.terms
end

那么 /^客户不会产生新的投注记录$/ do
  Pa::AutoBet.where(wager: @prebet.wager).count.should == @fresh_bet_count
end

# 追号重试

当 /^投注"(.*?)"$/ do |bet_res|
  case bet_res
  when '不成功'
    # 制造一个错误的投注号码,期待渠道返回失败的结果
    @prebet.wager = "#{@prebet.wager}bug"
    @prebet.save
  when '成功';
    # 修复投注号码，期待渠道返回成功的结果
    @prebet.wager = @prebet.wager.sub('bug', '')
    @prebet.save
    @prebet.auto_bets.each {|auto_bet|
      auto_bet.wager = @prebet.wager
      auto_bet.save
    }
    
  end


  if @try_num
    jobs = Pa::BbJob.workable
    BusinessRetryBatchBet.new(jobs).call
  else

    zhuihao

  end
  
end


那么 /^客户的投注记录应该被标记为"(.*?)"$/ do |st_name|
  auto_bet = @lot_term.auto_bets.order('createtime DESC').first
  auto_bet.status.should == Pa::AutoBet::SM[st_name].code
end

那么 /^客户的已追号数目为"(.*?)"$/ do |termeds|
  @prebet.reload
  @prebet.termeds.should == termeds.to_i
end

当 /^重试投注第"(.*?)"次后$/ do |try_num|
  @try_num = try_num.to_i
end

# 追号入库

当 /^完成入库操作后$/ do
  # 入库操作是实时的
  # auto_bets = Pa::AutoBet.depotable
  # BusinessDepotBet.new(auto_bets).call
end

那么 /^应该生成正确的入库记录$/ do
  @auto_bet = @lot_term.auto_bets.order('createtime DESC').first
  if @auto_bet.status == Pa::AutoBet::SM['成功'].code
    bet = Pa::Bet.where(ordersn: @auto_bet.ordersn).first
    bet.status.should == Pa::Bet::SM['投注成功'].code
    bet.statusnote.should == Pa::Bet::SM['投注成功'].note
    bet.paystatus.should == Pa::Bet::SM['订单支付成功'].code
    bet.paystatusnote.should == Pa::Bet::SM['订单支付成功'].note
  else
    bet = Pa::Bet.where(ordersn: @auto_bet.ordersn).first
    bet.status.should == Pa::Bet::SM['购买彩票失败'].code
    bet.statusnote.should == Pa::Bet::SM['购买彩票失败'].note
    bet.paystatus.should == Pa::Bet::SM['订单已申请退款'].code
    bet.paystatusnote.should == Pa::Bet::SM['订单已申请退款'].note
  end  
end

当 /^重试投注"(.*?)"次后$/ do |tried_num|
  tried_num = tried_num.to_i - 1
  tried_num.times do |i|
    step "重试投注第\"1\"次后"
    step "投注\"不成功\"" 
  end
end

那么 /^应该不生成入库记录$/ do
  @auto_bet = @lot_term.auto_bets.order('createtime DESC').first
  Pa::Bet.where(ordersn: @auto_bet.ordersn).count.should == 0
end

那么 /^不应该重复入库$/ do
  step '完成入库操作后'
  Pa::Bet.where(ordersn: @auto_bet.ordersn).count.should == 1
end


# 多用户多彩种追号

假设 /^有下面的追号数据:$/ do |zhuihao_table|
  @t00 = Time.now
  zhuihao_table.hashes.each do |zt|
    zt['users_num'].to_i.times { create_pre_bet(zt['lot_name'], zt['terms_num'].to_i) }
  end
end

当 /^系统收到"(.*?)"$/ do |notice|
  
  # 检测到新期前的投注数目
  @before_bet_count = Pa::AutoBet.count

  @ns = split_term_notice notice
  lotterytypeids = Pa::Lotterytype.where(name: @ns).map(&:lotterytypeid)
  @before_prebets = Pa::Prebet.where(lotterytypeid: lotterytypeids).all

  @ns.each do |name|
    lot_type = Pa::Lotterytype.where(name: name).first
    term = get_or_create_lot_term(lot_type)
    # 设置starttime大于追号记录的createtime，以模拟新期
    term.starttime = DateTime.now + 10.minutes
    term.save
  end

  t0 = Time.now
  
  # 开始追号
  zhuihao          

  # terms = Pa::Term.unused.non_expired
  # BusinessAutoBatchBets.new(terms).call
  
end

那么 /^系统应该批量投注"(.*?)"条追号记录$/ do |bet_num|
  # 确保验证同一次追号在同一个彩期中只能追一次
  g_bets = Pa::AutoBet.success.group_by{|auto_bet| "#{auto_bet.prebetid}@#{auto_bet.termid}"}
  g_bets.keys.size.should == @before_bet_count + bet_num.to_i
  Pa::AutoBet.success.count.should == @before_bet_count + bet_num.to_i
end

那么 /^每个客户的已追期数应该增加"(.*?)"$/ do |num|
  @before_prebets.each {|before_prebet|
    after_prebet = Pa::Prebet.find(before_prebet.prebetid)
    assert_equal after_prebet.termeds, before_prebet.termeds + num.to_i
  }
end


# 不能追当前期

假设 /^系统已经存在下面的渠道彩期:$/ do |terms_table|
  @old_terms = terms_table.hashes.map {|term|
    lot_name = term['彩种']
    issue = term['彩期']
    starttime = term['开始时间']
    endtime = term['结束时间']
    lottype = Pa::Lotterytype.where(name: lot_name).first
    term = Fabricate('Pa::Term',
                     lotterytypeid: lottype.lotterytypeid,
                     issue: issue,
                     starttime: starttime,
                     endtime: endtime
                     )
    term
  }
end

假设 /^我购买了下面的追号:$/ do |prebets_table|
  @mem_prebets = prebets_table.hashes.map {|prebet|
    last_issue = prebet['最近已追期号']
    lot_name = prebet['彩种']
    terms = prebet['追号期数'].to_i
    termeds = prebet['已追期数'].to_i
    multi = "%02d" % prebet['追号倍数'].to_i
    wager = prebet['注码']
    wager = "#{multi}#{wager}"
    lottype = Pa::Lotterytype.where(name: lot_name).first
    starttime = Time.parse('2012-11-22 09:59:00')
    endtime = Time.parse('2012-11-22 10:09:00')

    lot_sname = LotTable.l2s(lot_name)
    lot_stype = Pa::Lotterytype.where(name: lot_sname).first
    term = nil
    
    if last_issue.present?
      
      Fabricate('Pa::Term',
                lotterytypeid: lot_stype.lotterytypeid,
                issue: last_issue,
                starttime: starttime,
                endtime: endtime
                )
      
      term = Fabricate('Pa::Term',
                       issue: last_issue,
                       lotterytypeid: lottype.lotterytypeid,
                       starttime: starttime,
                       endtime: endtime
                       )

      Timecop.freeze('2012-11-22 10:01:00')
      zhuihao(false)
      
    end  

    wager = Wager.new(code: wager, channel: '金软', lot_type: lottype.name)
    Fabricate('Pa::Prebet',
              lotterytypeid: lottype.lotterytypeid,
              termid: (term.try(:termid) || -1),
              sum:   wager.betsum,
              money: lottype.money * multi.to_i * wager.betsum * terms,
              terms: terms,
              termeds: termeds,
              wager: wager.code
              )
  }
end

当 /^追号系统启动时$/ do
  Timecop.freeze('2012-12-03 10:22:00')
  zhuihao(false)
end

那么 /^不应该对这些追号记录进行追号:$/ do |prebets_table|
  prebets_table.hashes.map {|prebet|
    prebet = Pa::Prebet.where(prebetid: prebet['prebetid']).first
    prebet.termeds.should == 0
  }
end

那么 /^这些彩期应该变为"(.*?)", "(.*?)":$/ do |status, depoted, terms_table|
  terms_table.hashes.each {|term|
    lot_name = LotTable.l2s(term['彩种'])
    issue = term['彩期']
    pre_term = Pa::PreTerm.where(lot_name: lot_name, issue: issue).first
    pre_term.status.should == Pa::PreTerm::SM['已追'].code
    pre_term.depoted.should == true
  }
end

# 漏追

假设 /^追号系统宕机$/ do
  Timecop.freeze('2012-11-22 10:05:00')
  zhuihao(false)
end

当 /^系统恢复后取到的"(.*?)"的新彩期号是"(.*?)"$/ do |lot_name, issue|
  Timecop.freeze('2012-11-22 10:20:00')
  
  starttime = Time.parse('2012-11-22 10:19:00')
  endtime = Time.parse('2012-11-22 10:29:00')
  lottype = Pa::Lotterytype.where(name: lot_name).first
  
  term = Fabricate('Pa::Term',
                   issue: issue,
                   lotterytypeid: lottype.lotterytypeid,
                   starttime: starttime,
                   endtime: endtime
                   )

  zhuihao(false)

end

那么 /^我漏掉"(.*?)"的追号"(.*?)"期$/ do |lot_name, lost_termeds|
  lottype = Pa::Lotterytype.where(name: lot_name).first
  prebet = Pa::Prebet.where(lotterytypeid: lottype.lotterytypeid).first
  prebet.lost_termeds.should == lost_termeds.to_i
end

那么 /^我漏掉的"(.*?)"的彩期号是"(.*?)"$/ do |lot_name, lost_issue|
  lot_name = LotTable.l2s(lot_name)
  pre_term = Pa::PreTerm.where(lot_name: lot_name, issue: lost_issue).first
  pre_term.status.should == Pa::PreTerm::SM['漏追'].code
end

那么 /^我有下面漏追的下注记录:$/ do |lost_bets_table|
  lost_bets_table.hashes.each {|bet|
    lottype = Pa::Lotterytype.where(name: bet['彩种']).first
    auto_bet = Pa::AutoBet.where(lotterytypeid: lottype.lotterytypeid, issue: bet['彩期号']).first
    auto_bet.losted.should == true

    bet = Pa::Bet.where(lotterytypeid: lottype.lotterytypeid).first
    bet.status.should == Pa::Bet::SM['购买彩票失败'].code
    
  }
  
end

# 人工设置预期彩期状态

假设 /^设置"(.*?)"的"(.*?)"的状态为"(.*?)"$/ do |lot_name, issue, status_note|
  @lot_name = lot_name
  pre_term = Pa::PreTerm.where(lot_name: lot_name, issue: issue).first
  pre_term.status = Pa::PreTerm::SM[status_note].code
  pre_term.save
end

当 /^收到"(.*?)"的"(.*?)"$/ do |lot_name, issue|
  lottype = Pa::Lotterytype.where(name: lot_name).first
  endtime = Time.parse('2012-11-22 10:39:00')
  starttime = Time.parse('2012-11-22 10:29:00')
  
  Fabricate('Pa::Term',
            lotterytypeid: lottype.lotterytypeid,
            issue: issue,
            starttime: starttime,
            endtime: endtime
            )

  Timecop.freeze('2012-11-22 10:30:00')
  zhuihao(false)
  
end

那么 /^我漏追的彩期是"(.*?)"$/ do |issues|
  issues = issues.split(',')
  pre_terms = Pa::PreTerm.where(lot_name: @lot_name, issue: issues)
  pre_terms.each {|pre_term|
    pre_term.status.should == Pa::PreTerm::SM['漏追'].code
  }
  
  prebets = Pa::Prebet.where(prebetid: @mem_prebets.map(&:prebetid))
  prebets.each {|prebet|
    prebet.lost_termeds.should == issues.size
  }
  
end


# 追号中断，剩余记录继续追号


当 /^"(.*?)"的新期入库后$/ do |lot_name|
  Timecop.return
  
  LotTable[lot_name].each {|ln|
    lottype = Pa::Lotterytype.where(name: ln).first
    lot_term = get_or_create_lot_term(lottype)
    lot_term.starttime = DateTime.now
    lot_term.save
  }
  
end

假设 /^追号任务"(.*?)"$/ do |sig|
  if sig == '中断'
    LotZhuihao::TERM_NUM = 20
  end
  
  zhuihao(false)
end

那么 /^会有部分追号未完成$/ do
  Pa::Bet.where(prebetid: @mem_prebets.map(&:prebetid), status: '0').count.should > 0
  Pa::Bet.where(prebetid: @mem_prebets.map(&:prebetid)).count.should < @mem_prebets.size
end

当 /^追号任务重新启动完成后$/ do
  LotZhuihao::TERM_NUM = 100 * 100 *100
  zhuihao(false)
end


那么 /^应该完成全部追号$/ do
  Pa::Bet.where(prebetid: @mem_prebets.map(&:prebetid)).count.should == @mem_prebets.size
end

