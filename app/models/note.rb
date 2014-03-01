class Note < ActiveRecord::Base

	scope :first, -> { order("created_at").first }
  scope :last, -> { order("created_at DESC").first }

  belongs_to :user

end
