class Team < ActiveRecord::Base
	has_many :users, :inverse_of => :team, :dependent => :destroy

  accepts_nested_attributes_for :users

  attr_accessible :name, :users_attributes
end