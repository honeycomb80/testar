class WeekCounts < ActiveRecord::Base
  belongs_to :week
  belongs_to :wordbank

  validates :wordbank, :wordbank_id, presence: true
end
