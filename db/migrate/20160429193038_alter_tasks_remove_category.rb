class AlterTasksRemoveCategory < ActiveRecord::Migration
  def change
  	remove_column(:tasks, :category)
  end
end
