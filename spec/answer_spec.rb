require 'spec_helper'

describe Answer do
  it { should belong_to :question }
  it { should have_many :participants }
  it { should have_many :responses}
  it { should validate_presence_of :answer_text }
end
