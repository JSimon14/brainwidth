class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.date :date
      t.integer :value
      t.string :category
      t.timestamps
    end
  end
end
