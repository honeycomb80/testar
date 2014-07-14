task :tc_text_scrape => :environment do 
  require 'parsing'
  include Parsing

  # Gets the text of the article, makes the respective database entries for each word
  def get_body_text

    # Uses the URL stored in Article
    Article.where(id: 2).each do |a|
      s_agent = Mechanize.new
      article_text = ""
      url = a.url
      tc_article = s_agent.get(url)
      # Gets the text from the article
      html_elem = tc_article.at('div.article-entry')
      case html_elem
      when html_elem.css('p').each do |t|
          article_text += " " + t.text
        end
      end
      # Creates 2, 3 word phrases
      article_words = make_phrases(article_text)
      # Counts the frequency of each word/phrase
      count = Hash.new(0)
      article_words.each do |w|
        count[w] += 1 
      end
      count.each do |phrase, num|
        # Checks for a brand
        brand = brand_check(phrase)
        # Preps it for entry
        phrase = strip_punct(phrase)
        # Finds or creates the word database entry
        w = Wordbank.where(word: phrase, brand: brand).first_or_create
        # Finds or creates the corresponding week count of the word
        WeekCounts.where(wordbank_id: w.id, week_id: a.week_id).first_or_create do |wc|
          # Adds the frequency count from this article
          if wc.total_count.nil?
            wc.total_count = num
          else
            wc.total_count += num
          end
        end
        # Finds or creates the corresponding month count of the word        
        MonthCounts.where(wordbank_id: w.id, month_id: a.month_id).first_or_create do |mc|
          # Adds the frequency count from this article
          if mc.total_count.nil?
            mc.total_count = num
          else
            mc.total_count += num
          end
        end
        # Finds or creates the corresponding year count of the word
        YearCounts.where(wordbank_id: w.id, year_id: a.year_id).first_or_create do |yc|
          # Adds the frequency count from this article
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