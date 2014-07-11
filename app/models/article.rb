class Article < ActiveRecord::Base
  belongs_to :week
  belongs_to :month
  belongs_to :year
end
