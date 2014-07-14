class Month < ActiveRecord::Base
  has_many :articles
  has_many :month_counts
  has_many :wordbanks, through: :month_count

  validates :month, uniqueness: true
  by_star_field :month
end
