task :tc_scrape => :environment do 
  require 'parsing'

  def get_body_text
    s_agent = Mechanize.new
    
    Article.each do |a|
      if a.scraped == false
        url = a.url
        tc_article = s_agent.get(url)
        html_elem = tc_article.at('div.article-entry')
        case html_elem
        when html_elem.css('p').each do |t|
            article_text << t.text.strip
          end
        end
        article_text = article_text.split
        article_text = add_word_phrases(article_text)
        count = Hash.new(0)
        article_text.each { |w| count[w] += 1 }
        count.each_key do |w|
          word = Wordbank.find_or_create_by(word: w)



        a.update(scraped: true)
      end
    end
  end

  def title_count(array_of_words)
    count = Hash.new(0)
    array_of_words.each { |word| count[word] += 1 }
  end


end