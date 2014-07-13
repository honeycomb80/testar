task :ar_test => :environment do
  require 'date'

  def article_test
    # article = Article.first
    week_count = WeekCounts.first.wordbank.word
    word = Wordbank.first.word
    puts word
    puts week_count
  end

  def new_entry_test
    word = Wordbank.first
    # week_count = WeekCounts.new(wordbank_id: @word.id)
    week_count = WeekCounts.new
    week_count.wordbank = word
    puts word
    puts week_count.wordbank
  end

  def month_date(article_date)
    article_date = Date.parse(article_date)
    month_date = article_date - article_date.wday
    w = Month.find_by_month(month_date).id
    puts w
  end

a = Article.first
a.update(scraped: false)

# month_date('2005-06-11')

end