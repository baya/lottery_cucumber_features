# -*- coding: utf-8 -*-

module Lot

  module Helper

    MAP_WAGER = {
      '重庆时时彩[五星]'    => %w(02~06~09~00~05 01~0203~0508~040002~0307 0209~03~05~08~01 000102~0109~0205~00~03),
      '重庆时时彩[三星]'    => %w(01~04~08 0205~0306~07 0308~00~02 00010209~0205~03 0109~0205~03),
      '重庆时时彩[二星]'    => %w(02~08 0309~0207 0100~05 010905~03 00010209~020503),
      '重庆时时彩[一星]'    => %w(02 08 02 0205 0503 01090503),
      '重庆时时彩[大小单双]' => %w(大~小 大~单 小~双 双~小 双~双 大~大),
      '福彩3D[直选]'        => %w(01~01~02 0102~03~04 010203~0405~06),
      '福彩3D[组六]'        => %w(010203 01020304 010205 010307 06~01~05),
      '福彩3D[组三]'        => %w(0102 01020304 010203040506 01020304050607 02040508),
      '排列三[直选]'        => %w(00~02~06 00~010203~04 0002~06~08 010203~040506~0708),
      '排列三[组六]'        => %w(00020304 0001020304 00020608 000102030405060709),
      '排列三[组三]'        => %w(0002 0001020304 00020608 00010203040506070809),
      '双色球'             => %w(010203040512~01 010203040506070809~01 01*02030405060708~01 01*02030405060709~0102 010203*0405080912~0304 01*02030405060708~01 0102030405080910~0103),
      '大乐透'             => %w(0102030405~0102 0304060725~0409 0115242530~0212 01040607081920~0211 01040607081920~0211 01111931*21~0203 0111213132*~0102 07*010203040506~01*020304)
    }

    CQSSC = ['重庆时时彩']
    FC3D = ['福彩3D']
    PL3 = ['排列三']
    SSQ = ['双色球']
    DLT = ['大乐透']


    ALL_LOTS = CQSSC + FC3D + PL3 + SSQ + DLT


     MAP_LOT_NO = {
    "江西多乐彩"              => "T01010",
    "十一运夺金[任选三复式]"    => "T01012",
    "十一运夺金[任选八单式]"    => "T01012",
    "刮刮乐"                  => "GGL001",
    "十一运夺金[任选七复式]"    => "T01012",
    "广东快乐十分[任选三]"      => "T01015",
    "重庆时时彩[一星]"          => "T01007",
    "十一运夺金[选前二直选复式]" => "T01012",
    "十一运夺金[选前三直选复式]" => "T01012",
    "七乐彩"                  => "F47102",
    "江西多乐彩[任选二]"        => "T01010",
    "江西多乐彩[选前一直选]"     => "T01010",
    "江西多乐彩[任选八]"        => "T01010",
    "江西多乐彩[任选七]"        => "T01010",
    "江西多乐彩[任选六]"        => "T01010",
    "江西多乐彩[任选五]"        => "T01010",
    "江西多乐彩[任选四]"        => "T01010",
    "十一运夺金[任选一复式]"     => "T01012",
    "十一运夺金[选前三组选复式]"  => "T01012",
    "江西多乐彩[选前二直选]"     => "T01010",
    "江西多乐彩[选前二组选]"     => "T01010",
    "福彩3D[组六]"              => "F47103",
    "广东快乐十分[任选四]"       => "T01015",
    "广东快乐十分[任选五]"       => "T01015",
    "广东快乐十分[任二连直]"     => "T01015",
    "广东快乐十分[直选前三]"     => "T01015",
    "广东快乐十分[选二连组]"     => "T01015",
    "广东快乐十分[组选前三]"     => "T01015",
    "重庆时时彩[大小单双]"       => "T01007",
    "江西多乐彩[选前三直选]"     => "T01010",
    "重庆时时彩[二星]"          => "T01007",
    "十一运夺金[任选四复式]"     => "T01012",
    "十一运夺金[任选五复式]"     => "T01012",
    "大乐透"                   => "T01001",
    "十一运夺金[任选六复式]"     => "T01012",
    "十一运夺金(11选5)"         => "T01012",
    "竞彩篮球胜负"              => "J00005",
    "重庆时时彩"                => "T01007",
    "广东快乐十分[任选二]"       => "T01015",
    "广东快乐十分"              => "T01015",
    "广东快乐十分[选一数投]"     => "T01015",
    "广东快乐十分[选一红投]"     => "T01015",
    "双色球"                   => "F47104",
    "重庆时时彩[五星]"          => "T01007",
    "福彩3D[组三]"             => "F47103",
    "江西多乐彩[选前三组选]"     => "T01010",
    "十一运夺金[选前二组选复式]"  => "T01012",
    "福彩3D[直选]"             => "F47103",
    "排列三[组六]"             => "T01002",
    "排列三[直选]"             => "T01002",
    "福彩3D"                  => "F47103",
    "排列三"                  => "T01002",
    "排列三[组三]"             => "T01002",
    "江西多乐彩[任选三]"        => "T01010",
    "十一运夺金[任选二复式]"     => "T01012",
    "重庆时时彩[三星]"          => "T01007"
  }  

    C2E_DIC = {
      '彩种'      => 'lot_name',
      '彩期'      => 'issue',
      '开始时间'   => 'starttime',
      '结束时间'   => 'endtime',
      '是否使用过' => 'used',
      '追号期数'   => 'terms',
      '注码'      => 'wager'
    }

    def get_term_notice_xml(termids = [])
      notice_xml = "<response errorcode=\"0\">
                     <result termids=\"#{termids.join(',')}\"/>
                   </response>"
    end

    def get_or_create_lot_term(lot_type)
      data = OpenStruct.new(:lotno => lot_type.lotno)
      channel = KingSoftChannel.new data
      res = channel.api_query_term
      data = ActiveSupport::XmlMini.parse res.body
      if data['results']['response']['errorcode'] == '0'
        term = data['results']['response']['result']
        term.delete('lotno')
        term.merge!(lotterytypeid: lot_type.lotterytypeid)
        lot_term = Pa::Term.where(issue: term['issue'], lotterytypeid: lot_type.lotterytypeid).first
        lot_term = Fabricate('Pa::Term', term) if lot_term.nil?
        lot_term
      else
        pp "------------------------->>>>#{lot_type.name}"
        nil
      end
    end

    def get_or_create_lot_type(lot_name)
      lotno = MAP_LOT_NO[lot_name]
      lottype = Pa::Lotterytype.where(name: lot_name).first
      lottype = Fabricate('Pa::Lotterytype', name: lot_name, lotno: lotno) if lottype.nil?
      lottype
    end  

    def get_lot_issue(term_no)
      while term_no.length < 3; term_no = "0#{term_no}" end
      issue = "#{DateTime.now.year}#{term_no}"
    end

    def current_term(lot_name)
      if @current_term.nil?
        lottype = Pa::Lotterytype.where(name: lot_name).first
        @current_term = Pa::Term.where(lotterytypeid: lottype.lotterytypeid).order('termid desc').first
      end
      
      @current_term
    end

    def reset_current_term
      @current_term = nil
    end


    def create_pre_bet(lot_name, terms_num)
      lottype = Pa::Lotterytype.where(name: lot_name).first
      multi = "%02d" % rand(1..49)
      code = MAP_WAGER[lot_name][rand 3]
      code = "#{multi}#{dxds_wager(code)}"
      wager = Wager.new(code: code, channel: '金软', lot_type: lottype.name)
      sum = wager.betsum
      money = 2 * multi.to_i * sum * terms_num
      Fabricate('Pa::Prebet',
                lotterytypeid: lottype.lotterytypeid,
                terms:         terms_num,
                wager:         wager.code,
                sum:           sum,
                money:         money,
                termid:        current_term(lot_name).try(:termid) || -1,
                userbank:      0
                )
    end

    def split_term_notice(notice)
      {
        '重庆时时彩' => CQSSC,
        '全部彩种'   => FC3D + PL3 + SSQ + DLT + CQSSC
      }[notice]
    end

    # 大小单双转换为对应的数字
    def dxds_wager(wager)

      {'大' => '02', '小' => '01', '单' => '05', '双' => '04'}.each {|k, v|
        wager.gsub!(k, v)
      }

      wager
      
    end


    def zhuihao(reset = true)

      ::LotTable.lots.each {|lot_name|
        business = BusinessCombZhuiHao.new(lot_name)
        pre_term = business.call
        next if pre_term.blank?
        
        if reset
          # 恢复pre_term的状态，模拟新期
          pre_term.status = Pa::PreTerm::SM['默认'].code
          pre_term.depoted = false
          pre_term.save
        end  

      }
      
    end

  end
  
end

begin
  World(Lot::Helper)
rescue NoMethodError
end
