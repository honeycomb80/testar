module Parsing

  # Checks fronts, backs of words for quotes
  def fr_quotes(word)
    /\A\"|\'/.match(word) != nil
  end

  def bk_quotes(word)
    /\Z\"|\'/.match(word) != nil
  end

  # Checks fronts, backs of word for parentheses
  def fr_parens(word)
    /\A\(|\{|\</.match(word) != nil
  end

  def bk_parens(word)
    /\Z\)|\}|\>/.match(word) != nil
  end

  # Checks fronts, backs of words for other punctuation
  def check_fr(word)
    /\A\,|\?|\!\+/.match(word) != nil
  end

  def check_bk(word)
    /\Z\,|\?|\!|\./.match(word) != nil
  end

  # Checks to see if it's a proper noun (to denote as brand)
  def proper(word)
    /[[:upper:]]/.match(word) != nil
  end

  def proper_two(array)
    one   = array[0]
    two   = array[1]
    if proper(one) && proper(two)
      true
    else
      false
    end
  end

  def proper_three(array)
    one   = array[0]
    two   = array[1]
    three = array[2]
    if proper(one) && proper(two) && proper(three)
      true
    else
      false
    end
  end

  # Checks a two-word array for punctuation problems
  def check_two(array)
    one   = array[0]
    two   = array[1]
    if bk_quotes(one) || bk_parens(one) || check_bk(one) || fr_parens(two) || fr_quotes(two)
      array.clear
    end
  end

  # Checks a three-word array for punctuation problems
  def check_three(array)
    one   = array[0]
    two   = array[1]
    three = array[2]
    if bk_quotes(one) || bk_parens(one) || check_bk(one) || fr_parens(two) || fr_quotes(two)
      array.clear
    elsif bk_quotes(two) || bk_parens(two) || check_bk(two) || fr_parens(three) || fr_quotes(three)
      array.clear
    end
  end

  # Checks to see if it's google+
  def google_plus(word)
    if /\Z+/.match(word) != nil && /google/i.match(word) != nil
      true
    else
      false
    end
  end

  def strip_punct(word)
    # Strips most types of punctuation from the front of the word
    if /\A\W/.match(word) != nil
      unless /\A\.|\@|\#|\$/.match(word) != nil
      word.gsub!(/\A\W/, "")
      end
    end
    # Strips all types of punctuation from the end of the word, except Google+
    if /\W\Z/.match(word) != nil
      unless google_plus(word)
      word.gsub!(/\W\Z/, "")
      end
    end
  end

  def add_word_phrases(array_of_words)
    hold = []
    array_of_words.each do |word|
      n = array_of_words.index(word)
      # Creates a two word array
      two_word = array_of_words[n..n+1]
      # Checks for the punctuations
      check_two(two_word)
      # Checks for two words
      if two_word[1].nil?
        two_word.clear
      else
        two_word = two_word.join(" ")
        hold.push(two_word)
      end
      # Creates a three word array
      three_word = array_of_words[n..n+2]
      # Checks for the punctuations
      check_three(three_word)
      if three_word[2].nil?
        three_word.clear
      else
        three_word = three_word.join(" ")
        hold.push(three_word)
      end
    end
  end

  def brand_check(string)
    words = string.split
    case words
    when words[1].nil?
      check = proper(words[0])
    when words[2].nil?
      check = proper_two(words)
      words = words.join(" ").to_s
    else
      check = proper_three(words)
      words = words.join(" ").to_s
    end
    check
  end

end