class Task < ActiveRecord::Base
	validates :title, presence: true
	validates :date, presence: true
	validates :value, presence: true
	validates :category_id, presence: true


	belongs_to :user
	belongs_to :category
	accepts_nested_attributes_for :category
end
