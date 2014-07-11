class MonthCounts < ActiveRecord::Base
  belongs_to :month
  belongs_to :wordbank
end
