class CreateParticipant < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.column :name, :string

      t.timestamps
    end
  end
end
