class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.column :answer_id, :integer
      t.column :participant_id, :integer
      t.column :question_id, :integer

      t.timestamps
    end
    drop_table :answers_participants_questions
  end
end
