task :tc_text_scrape => :environment do 
  require 'parsing'
  include Parsing

  def get_body_text

    Article.where(id: 2).each do |a|
      s_agent = Mechanize.new
      article_text = ""
      url = a.url
      tc_article = s_agent.get(url)
      html_elem = tc_article.at('div.article-entry')
      case html_elem
      when html_elem.css('p').each do |t|
          article_text += " " + t.text
        end
      end
      article_phrases = make_phrases(article_text)
      count = Hash.new(0)
      article_phrases.each do |w|
        count[w] += 1 
      end
      count.each do |phrase, num|
        w = Wordbank.where(word: phrase, brand: brand_check(phrase)).first_or_create
        WeekCounts.where(wordbank_id: w.id, week_id: a.week_id).first_or_create do |wc|
          if wc.total_count.nil?
            wc.total_count = num
          else
            wc.total_count += num
          end
        end
        MonthCounts.where(wordbank_id: w.id, month_id: a.month_id).first_or_create do |mc|
          if mc.total_count.nil?
            mc.total_count = num
          else
            mc.total_count += num
          end
        end
        YearCounts.where(wordbank_id: w.id, year_id: a.year_id).first_or_create do |yc|
          if yc.total_count.nil?
            yc.total_count = num
          else
            yc.total_count += num
          end
        end
      end
    #   a.update(scraped: true)
    end
  end

get_body_text
end

  # def title_count(array_of_words)
  #   count = Hash.new(0)
  #   array_of_words.each { |word| count[word] += 1 }
  # end

  # a = 'in the mind in the head in the face in the years'
  # b = 'Amazon Web Services'
  # c = 'San Francisco streets'

  # # print a.split

  # phrases = make_phrases(a)
  # count = Hash.new(0)
  # phrases.each do |w| 
  #   count[w] += 1 
  # end


  # puts brand_check(a)
  # puts brand_check(b)
  # puts brand_check(c)

# end