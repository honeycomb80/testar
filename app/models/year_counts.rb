class YearCounts < ActiveRecord::Base
  belongs_to :year
  belongs_to :wordbank

  validates :wordbank, :wordbank_id, presence: true
end
