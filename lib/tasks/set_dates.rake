# Builds all fixed date categories
task :set_dates => :environment do
  require 'date'

  def make_week(date_in)
    date_in = Date.parse(date_in)
    last_updated = Week.order('created_at DESC').take
    unless last_updated.nil?
      date_in = last_updated.week
    end
    until date_in > Date.today
      Week.create(week: date_in)
      date_in += 7
    end
  end

  def make_month(date_in)
    date_in = Date.parse(date_in)
    date_in = date_in - date_in.mday + 1
    last_updated = Month.order('created_at DESC').take
    unless last_updated.nil?
      date_in = last_updated.month
    end
    until date_in > Date.today
      Month.create(month: date_in)
      date_in = date_in >> 1
    end
  end

  def make_year(date_in)
    date_in = Date.parse(date_in).year
    last_updated = Year.order('created_at DESC').take
    unless last_updated.nil?
      date_in = last_updated.year
    end
    until date_in > Date.today.year
      Year.create(year: date_in.to_i)
      date_in += 1
    end
  end

date = '20050611'
date2 = '20050605'
make_week(date2)
make_month(date)
make_year(date)

end