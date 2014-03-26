require 'spec_helper'

describe Question do
  it 'should be saved to the database when created' do
    n_question = Question.create( {:question_text => "What sound does a poodle make?", :survey_id => 1} )
    Question.all.should eq [n_question]
  end

  it 'should be able to see the number of times an answer was chosen' do
    new_question = Question.create(:question_text => "What is your favorite color?")
    new_answer = Answer.create(:answer_text => "Blue", :question_id => new_question.id)
    new_answer2 = Answer.create(:answer_text => "Green", :question_id => new_question.id)
    new_answer3 = Answer.create(:answer_text => "Yellow", :question_id => new_question.id)
    new_participant = Participant.create(:name => "Bobodino")
    new_participant2 = Participant.create(:name => "Dr. Who")
    new_response = Response.create(:participant_id => new_participant.id, :question_id => new_question.id, :answer_id => new_answer.id)
    new_response2 = Response.create(:participant_id => new_participant2.id, :question_id => new_question.id, :answer_id => new_answer2.id)
    new_question.responses.should eq [new_response, new_response2]
    new_question.response_tally.should eq [["Blue", 1], ["Green", 1], ["Yellow", 0]]
  end

  it { should belong_to :survey }
  it { should have_many :answers }
  it { should have_many :participants }

  it { should validate_presence_of :question_text }
end
