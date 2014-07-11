class WeekCounts < ActiveRecord::Base
  belongs_to :week
  belongs_to :wordbank
end
