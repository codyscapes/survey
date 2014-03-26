class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :answers
  has_many :responses
  has_many :participants, :through => :responses

  validates :question_text, :presence => true

  def response_tally
    results = []
    total = 0
    self.answers.each do |answer|
      results << [answer.answer_text, response_total(answer.id), ((response_total(answer.id)).to_d / (self.responses.length).to_d) ]
    end
   results
  end




  def response_total(answer_id)
    count = 0
    self.responses.each do |response|
      if response.answer_id == answer_id
        count += 1
      end
    end
    count
  end

end
