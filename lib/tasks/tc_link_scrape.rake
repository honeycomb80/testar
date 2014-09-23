task :tc_link_scrape => :environment do 
  require 'open-uri'

  # Gets the info on the articles, makes Articles entries
  def get_article_data(pg = 2, article_date = Date.today)
    agent = Mechanize.new
    tc = agent.get('http://www.techcrunch.com')
    article_pg_count = 0

    # Limits the amount of articles scraped
    until article_date === Date.today - 25  #<-- "yesterday" option
    # until Article.find_by(tc_num: @tc_num) != nil #<-- "all" option
      # Gets the article date
      tc.root.css('li.river-block').each do |link|
        tc_num = link['id'].to_i
        article_date = link.css('time')[0]['datetime']
        article_date = Date.parse(article_date)
        # gets the week_id
        week_date = article_date - article_date.wday
        week_date = Week.find_by_week(week_date).id
        # gets the month_id
        month_date = article_date - article_date.mday + 1
        month_date = Month.find_by_month(month_date).id
        # gets the year_id
        year_date = article_date.year.to_i
        year_date = Year.find_by_year(year_date).id
        # Gets the author (which isn't always in the same place)
        if link.css('div.byline a').text.empty?
          a = link.css('div.byline').text
          b = link.css('div.byline time').text
          author = a.gsub(b, "")
          author = author.gsub("by", "").strip
        else
          author = link.css('div.byline a').text
        end
        f = link.css('h2.post-title').first
        # Gets the link
        url = f.css('a')[0]['href']
        # Gets the headline
        headline = f.css('a')[0].text
        # Combines all the parts to make an Article
        Article.create(
          tc_num: tc_num,
          headline: headline,
          date: article_date,
          url: url,
          author: author,
          week_id: week_date,
          month_id: month_date,
          year_id: year_date,
          scraped: false
        )
        article_pg_count += 1
        # Gets me to the next page of links
        if article_pg_count == 20
          tc = tc.link_with(:href => %r{page/#{pg}}i).click
          tc
          pg += 1
          article_pg_count = 0
        end
      end
    end
  end

get_article_data

end

