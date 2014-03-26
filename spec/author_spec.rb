require 'spec_helper'

describe Author do
  it 'should be saved to the database when created' do
    n_author = Author.create(:name => "Regina Watson")
    Author.all.should eq [n_author]
  end

  it { should have_many :surveys }
  it { should have_many :questions }

  it { should validate_presence_of :name }
end
