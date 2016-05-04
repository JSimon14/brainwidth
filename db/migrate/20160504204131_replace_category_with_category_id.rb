class ReplaceCategoryWithCategoryId < ActiveRecord::Migration
  def change
  	add_column(:tasks, :category_id, :integer)
  	remove_column(:tasks, :category)
  end
end
