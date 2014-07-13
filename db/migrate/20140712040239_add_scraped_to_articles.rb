class AddScrapedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :scraped, :boolean
  end
end
