require 'spec_helper'

describe Survey do
  it 'should be saved to the database when created' do
    n_survey = Survey.create(:name => "Feedback Survey")
    Survey.all.should eq [n_survey]
  end


  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many :participants }

  it { should validate_presence_of :name }
end
