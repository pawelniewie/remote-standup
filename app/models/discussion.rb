class Discussion < ActiveRecord::Base
	has_many :notes
	belongs_to :team
end
