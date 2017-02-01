require 'nokogiri'
require 'open-uri'

class Notice < ApplicationRecord
  url = "http://www.chosun.com/"
  data = Nokogiri::HTML(open(url))
  @notices = data.css('dl.art_list_item')
  @notices.each do |notice|
    Notice.create(
      :title => notice.css('dt a').text.strip,
      :link => "link",
      :writer => "조선일보",
      :created_on => "created_on"
    )
  end
end
