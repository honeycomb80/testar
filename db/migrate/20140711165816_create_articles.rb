class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :headline
      t.string :url
      t.date :date
      t.string :author
      t.integer :week_id
      t.integer :month_id
      t.integer :year_id

      t.timestamps
    end
  end
end
