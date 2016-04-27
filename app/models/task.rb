class Task < ActiveRecord::Base
	validates :title, presence: true
	validates :date, presence: true
	validates :value, presence: true
	validates :category, presence: true


	belongs_to :user
end
