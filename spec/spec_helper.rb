require 'active_record'
require 'shoulda-matchers'
require 'rspec'

require 'survey'
require 'author'
require 'question'
require 'participant'
require 'answer'
require 'response'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Survey.all.each { |product| product.destroy }
    Author.all.each { |author| author.destroy }
    Question.all.each { |question| question.destroy }
    Response.all.each { |response| response.destroy }
    Answer.all.each { |answer| answer.destroy }
    Participant.all.each { |participant| participant.destroy }

  end
end
