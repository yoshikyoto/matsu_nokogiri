# coding: utf-8

require 'open-uri'
require 'net/https'
require 'nokogiri'

class MatsuClient

  def initialize(id, pass)
    # フォームなどの値のpostする先
    @login_uri = 'https://www.deal.matsui.co.jp/servlet/ITS/login/MemberLoginEnter'
    @shisan_uri = 'https://www.deal.matsui.co.jp/ITS/frame/FraAstDistribution.jsp;jgieww05=LTS8Ys3C6JTZCnVGt7Lwwgst02NqNFv9vpNGpPXZvGBR1xhMw5Jh!521214102'
    # ログインページ
    @test_url = 'https://www.deal.matsui.co.jp/ITS/login/MemberLogin.jsp'
    @id = id
    @pass = pass
  end

  # ログインページをnokogiriでパースしたやつを返す
  def test()
    charset = nil
    html = open(@test_url) do |f|
      charset = f.charset
      f.read
    end
    Nokogiri::HTML.parse(html, nil, charset)
  end

  def login()
    uri = URI.parse(@login_uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data({
                        'attrFromJsp' => '/ITS/login/MemberLogin.jsp',
                        'clientId' => @id,
                        'passwd' => @pass,
                        'easyTradeFlg' => 0
                      })
    response = http.request(req)
    doc = Nokogiri::HTML.parse(response.body)
    error_message = doc.xpath('//p[@class="m-box-alert-txt"]/strong').inner_text
    if error_message.empty?
      puts 'ログイン成功'
      true
    else
      puts 'ログイン失敗'
      puts error_message
      false
    end
  end
end

