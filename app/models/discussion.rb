class Discussion < ActiveRecord::Base
	has_many :notes
	belongs_to :team

  validates_presence_of :team

	scope :first, -> { order("created_at").first }
	scope :last, -> { order("created_at DESC").first }
end
