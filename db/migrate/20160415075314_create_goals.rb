class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :description
      t.string :category
      t.references :user
      t.timestamps null: false
    end
  end
end
