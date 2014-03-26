class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :responses
  has_many :participants, :through => :responses

  validates :answer_text, :presence => :true

end
