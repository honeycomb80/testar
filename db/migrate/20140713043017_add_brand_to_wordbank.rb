class AddBrandToWordbank < ActiveRecord::Migration
  def change
    add_column :wordbanks, :brand, :boolean
  end
end
