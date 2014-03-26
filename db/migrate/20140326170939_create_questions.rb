class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.column :survey_id, :integer
      t.column :question_text, :text
      t.column :answer_text, :text
      t.timestamps
    end
  end
end
