require 'spec_helper'

describe Participant do
  it { should have_many :surveys }
  it { should have_many(:answers).through(:responses) }
  it { should have_many(:questions).through(:responses) }
  it { should validate_presence_of :name }


end
