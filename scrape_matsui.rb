require 'open-uri'
require 'nokogiri'

url = 'https://www.deal.matsui.co.jp/ITS/login/MemberLogin.jsp'
charset = nil
html = open(url) do |f|
  charset = f.charset
  f.read
end

doc = Nokogiri::HTML.parse(html, nil, charset)
puts doc.title
