require 'active_record'
require './lib/survey'
require './lib/author'
require './lib/question'
require './lib/participant'
require './lib/answer'
require './lib/response'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def main_menu
  system('clear')
  puts "*************************************************"
  puts "Hello!  Are you an author (a) or a participant (p)?"
  puts "You can also type e to exit the program"
  puts "Don't type poodle"
  case gets.chomp
  when 'p'
    participant_landing
  when 'a'
    author_landing
  when 'e'
    puts 'goodbye!'
  when 'poodle'
    dog_sound = 'ruff'
    500.times do
      puts dog_sound
      dog_sound = dog_sound + " ruff "
      sleep(1)
    end
    input=gets.chomp
    main_menu
  else
    'that is not a valid option'
  end
end

def author_landing
  puts "Are you registered in our system? (yes or no)"
  puts "You can also type main to return to the main menu"
  case gets.chomp
  when 'yes'
    author_log_in
  when 'no'
    create_author
  when 'main'
    main_menu
  else
    puts 'that is not a valid option'
    author_landing
  end
end

def participant_landing
  puts "Welcome to the Survey Program!"
  puts "Are you registered in our system? (yes or no)"
  puts "You can also type main to return to the main menu."
  case gets.chomp
  when 'yes'
    participant_log_in
  when 'no'
    create_participant
  when 'main'
    main_menu
  else
    puts 'that is not a valid option'
    participant_landing
  end
end

def participant_log_in
  puts "What is your name?"
  participant = Participant.find_by(name: gets.chomp)
  participant_interface(participant)
end

def participant_interface(participant)
  puts "What do you want to do?"
  puts "Type 'choose' to choose a survey you can take"
  case gets.chomp
  when 'choose'
    choose_survey(participant)
  end
end

def choose_survey(participant)
  list_surveys
  puts "\n\nWhat survey do you want to take?"
  survey = Survey.find_by(:name => gets.chomp)
  take_survey(survey, participant)
end

def list_surveys
  system('clear')
  Survey.all.each_with_index do |survey, index|
    puts (index+1).to_s + ": " + survey.name
  end
end


def take_survey(survey, participant)
  system('clear')
  # puts "#{"%20s" % [survey.name]}"
  puts survey.name + "\n\n"
  survey_questions = Question.where(:survey_id => survey.id)

  survey_questions.each do |question|
    puts "QUESTION:"
    puts question.question_text + "\n\n"
    puts "POSSIBLE ANSWERS:"
    question.answers.each { |a| puts a.answer_text }
    puts "\nWHAT IS YOUR ANSWER?"
    answer = Answer.find_by(:answer_text => gets.chomp, :question_id => question.id)
    Response.create({:answer_id => answer.id, :question_id => question.id, :participant_id => participant.id })
  end
  system 'clear'
  puts "Thank you for taking this survey, sucker!"
  participant_interface(participant)
end

def create_author
  puts 'What is your name?'
  author = Author.create({ :name => gets.chomp })
  author_interface(author)
end

def create_participant
  puts "What is your name?"
  participant = Participant.create({ :name => gets.chomp })
  participant_interface(participant)
end

def author_log_in
  puts "What is your name?"
  author = Author.find_by(name: gets.chomp)
  author_interface(author)
end

def author_interface(author)
  puts "Welcome #{author.name}"
  puts "To review answers to a past survey type 'review'"
  puts "To create a survey type 'create'"
  case gets.chomp
  when 'review'
    review_survey(author)
  when 'create'
    create_survey(author)
  end
end

def review_survey(author)
  system('clear')
  surveys = Survey.where(:author_id => author.id)
  surveys.each do |survey|
    puts survey.name
  end

  puts "\n\n"
  puts "What do you want to do?"
  puts "Type delete to delete a survey"
  puts "Type add to add questions to a survey"
  puts "Type go back to go back to the author interface"
  puts "\n\n"

  case gets.chomp
  when 'delete'
    puts 'what survey do you want to delete?'
    input = Survey.find_by(name: gets.chomp)
    input.destroy
    puts 'survey destroyed'
    review_survey(author)
    # NEED TO DELETE OTHER DATA RELATED TO THE SURVEY
  when 'add'
    puts 'what survey do you want to add questions to?'
    survey = Survey.find_by(name: gets.chomp)
    add_questions_to_survey(author, survey)
  when 'go back'
    author_interface(author)
  else
    puts 'that is not a valid option'
  end
end

def create_survey(author)
  puts "What is the name of the survey you want to create?"
  new_survey_name = gets.chomp
  new_survey = Survey.create({:name => new_survey_name, :author_id => author.id})
  if new_survey.save
    puts "'#{new_survey.name}' has been added to your survey list."
    add_questions_to_survey(author, new_survey)
  else
    puts "That wasn't a valid survey name:"
    new_survey.errors.full_messages.each { |message| puts message }
    create_survey(author)
  end
end

def add_questions_to_survey(author, survey)
  puts "What do you want your new question to be?  If you are finished adding questions, type 'I am done'"
  input = gets.chomp
  case input
  when 'I am done'
    author_interface(author)
  else
    new_question = Question.create({:survey_id => survey.id, :question_text => input})

    if new_question.save
      puts "The question has been added."


      puts "What is one possible answer to the question?"
      new_answer = Answer.create({:question_id => new_question.id, :answer_text => gets.chomp})

      while 1 > 0 do
        puts "What is another possible answer? If there are no more possible answers, please type I am done"
        new_answer = gets.chomp
        case new_answer
        when 'I am done'
          author_interface(author)
          break
        else
          Answer.create({:question_id => new_question.id, :answer_text => new_answer})
        end
      end

      add_questions_to_survey(author, survey)
    else
      puts "The question needs text"
      add_questions_to_survey(author, survey)
    end
  end

end


main_menu
