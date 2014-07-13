# if Wordbank.all.count < 200 
#   200.times do
#     Wordbank.create(word: Forgery(:lorem_ipsum).words(1, :random => true, :unique => true))
#   end
# end

# if Article.all.count < 100
#   100.times do
#     Article.create(headline: Forgery(:lorem_ipsum).words(10, :random => true), date: Forgery(:date).date(:past => true), url: Forgery(:internet).domain_name)
#   end
# end

# if WeekCounts.all.count < 100
#   100.times do
#     WeekCounts.create(total_count: Forgery(:basic).number(:at_most => 100), headline_count: Forgery(:basic).number(:at_most => 5), week_id: Forgery(:basic).number(:at_most => 100), wordbank_id: Forgery(:basic).number(:at_most => 100))
#   end
# end

# if MonthCounts.all.count < 100
#   100.times do
#     MonthCounts.create(total_count: Forgery(:basic).number(:at_most => 100), headline_count: Forgery(:basic).number(:at_most => 10), month_id: Forgery(:basic).number(:at_most => 100), wordbank_id: Forgery(:basic).number(:at_most => 100))
#   end
# end

# if YearCounts.all.count < 100
#   100.times do
#     YearCounts.create(total_count: Forgery(:basic).number(:at_most => 100), headline_count: Forgery(:basic).number(:at_most => 100), year_id: Forgery(:basic).number(:at_most => 9), wordbank_id: Forgery(:basic).number(:at_most => 100))
#   end
# end

# if Week.all.count < 450
#   450.times do
#     Week.create(week: Forgery(:date).date(:past => true))
#   end
# end

# if Month.all.count < 108
#   108.times do
#     Month.create(month: Forgery(:date).date(:past => true))
#   end
# end

# if Year.all.count < 9
#   y = 2005
#   9.times do
#     y += 1
#     Year.create(year: y)
#   end
# end
