class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.column :name, :string
    end
  end
end
