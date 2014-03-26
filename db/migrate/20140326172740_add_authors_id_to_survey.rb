class AddAuthorsIdToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :author_id, :integer
  end
end
