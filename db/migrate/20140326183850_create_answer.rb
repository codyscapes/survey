class CreateAnswer < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.column :answer_text, :text
      t.column :question_id, :integer

      t.timestamps
    end

    create_table :answers_participants_questions do |t|
      t.column :answer_id, :integer
      t.column :participant_id, :integer
      t.column :question_id, :integer

      t.timestamps
    end

    remove_column :questions, :answer_text, :text
  end
end
