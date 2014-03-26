class CreateParticipantsSurveys < ActiveRecord::Migration
  def change
    create_table :participants_surveys do |t|
      t.column :participant_id, :integer
      t.column :survey_id, :integer

      t.timestamps
    end
  end
end
