class MonthCounts < ActiveRecord::Base
  belongs_to :month
  belongs_to :wordbank

  validates :wordbank, :wordbank_id, presence: true
end
