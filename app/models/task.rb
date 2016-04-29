class Task < ActiveRecord::Base
	validates :title, presence: true
	validates :date, presence: true
	validates :value, presence: true


	belongs_to :user
	belongs_to :category
end
