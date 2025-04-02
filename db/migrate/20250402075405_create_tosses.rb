class CreateTosses < ActiveRecord::Migration[7.2]
  def change
    create_table :tosses do |t|
      t.string :title
      t.references :team_one, foreign_key: { to_table: :teams }, null: false
      t.references :team_two, foreign_key: { to_table: :teams }, null: false
      t.datetime :timing

      t.timestamps
    end
  end
end
