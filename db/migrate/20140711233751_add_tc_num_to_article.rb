class AddTcNumToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :tc_num, :integer
  end
end
