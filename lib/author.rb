class Author < ActiveRecord::Base
  has_many :surveys
  has_many :questions, :through => :surveys

  validates :name, :presence => :true

end
