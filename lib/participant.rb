class Participant < ActiveRecord::Base

  has_many :surveys, :through => :participants_surveys
  has_many :responses
  has_many :questions, :through => :responses
  has_many :answers, :through => :responses


  validates :name, :presence => :true

end
