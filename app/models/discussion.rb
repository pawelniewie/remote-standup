class Discussion < ActiveRecord::Base
	has_many :notes
	belongs_to :team

	scope :first, -> { order("created_at").first }
	scope :last, -> { order("created_at DESC").first }
end
