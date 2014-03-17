class Note < ActiveRecord::Base

	scope :first, -> { order("created_at").first }
  scope :last, -> { order("created_at DESC").first }

  belongs_to :user
  belongs_to :team

  validates_presence_of :user
  validates_presence_of :team

  before_create do |note|
    if note.team.nil? and not note.user.nil?
      note.team = note.user.team
    end
  end

  def user
  	User.find(self.user_id)
  end
end