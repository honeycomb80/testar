class Article < ActiveRecord::Base
  belongs_to :week
  belongs_to :month
  belongs_to :year

  validates :tc_num, presence: true, uniqueness: true

  by_star_field :date
end
