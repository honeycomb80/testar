class YearCounts < ActiveRecord::Base
  belongs_to :year
  belongs_to :wordbank
end
