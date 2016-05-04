class RenameCategoryIdColumn < ActiveRecord::Migration
  def change
  	remove_column(:tasks, :category_id)
  	add_column(:tasks, :category, :string)
  end
end
