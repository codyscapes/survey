class Survey < ActiveRecord::Base

  has_many :questions, :dependent => :destroy
  has_many :participants, :through => :participants_surveys

  validates :name, :presence => :true
end
