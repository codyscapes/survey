require 'spec_helper'

describe Response do
  it { should belong_to :answer }
  it { should belong_to :question }
  it { should belong_to :participant }
end
