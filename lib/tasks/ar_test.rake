task :ar_test => :environment do
  
  def article_test
    article = Article.first
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

# article_test
new_entry_test

end