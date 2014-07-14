task :tc_title_scrape => :environment do 
  require 'parsing'
  include Parsing

  def get_headline_text

    Article.all.each do |a|
      headline = a.headline
      # Creates 2, 3 word phrases
      headline_words = make_phrases(headline)
      # Counts the frequency of each word/phrase
      count = Hash.new(0)
      headline_words.each do |w|
        count[w] += 1 
      end
      count.each do |phrase, num|
        # Preps it for entry
        phrase = strip_punct(phrase)
        # Finds or creates the word database entry
        w = Wordbank.where(word: phrase).first_or_create
        # Finds or creates the corresponding week count of the word
        WeekCounts.where(wordbank_id: w.id, week_id: a.week_id).first_or_create do |wc|
          # Adds the frequency count from this article
          if wc.headline_count.nil?
            wc.headline_count = num
          else
            wc.headline_count += num
          end
        end
        # Finds or creates the corresponding month count of the word        
        MonthCounts.where(wordbank_id: w.id, month_id: a.month_id).first_or_create do |mc|
          # Adds the frequency count from this article
          if mc.headline_count.nil?
            mc.headline_count = num
          else
            mc.headline_count += num
          end
        end
        # Finds or creates the corresponding year count of the word
        YearCounts.where(wordbank_id: w.id, year_id: a.year_id).first_or_create do |yc|
          # Adds the frequency count from this article
          if yc.headline_count.nil?
            yc.headline_count = num
          else
            yc.headline_count += num
          end
        end
      end
    #   a.update(scraped: true)
    end
  end

get_headline_text


end