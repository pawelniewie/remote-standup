class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

	scope :first, -> { order("created_at").first }
  scope :last, -> { order("created_at DESC").first }

  has_many :notes, dependent: :destroy

end
