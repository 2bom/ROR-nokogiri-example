require 'nokogiri'
require 'open-uri'

class Notice < ApplicationRecord
  validates :link, :uniqueness => true

  url = "http://www.dongguk.edu/mbs/kr/jsp/board/list.jsp?boardId=3638&id=kr_010801000000"
  data = Nokogiri::HTML(open(url))
  @notices = data.css('tbody tr')
  @notices.each do |notice|
    if notice.css('td')[0].text.strip =~ /\A\d+\z/
      Notice.create(
        :title => notice.css('td.title a').text.strip,
        :link => "https://www.dongguk.edu/mbs/kr/jsp/board/" + notice.css('td.title a')[0]['href'].strip,
        :writer => notice.css('td')[2].text.strip,
        :created_on => notice.css('td')[3].text.strip
      )
    else
      next
    end
  end
end
