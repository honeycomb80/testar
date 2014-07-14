class Week < ActiveRecord::Base
  has_many :articles
  has_many :week_counts
  has_many :wordbanks, through: :week_count

  validates :week, uniqueness: true
  by_star_field :week
end
