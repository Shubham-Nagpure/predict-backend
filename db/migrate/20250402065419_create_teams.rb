class CreateTeams < ActiveRecord::Migration[7.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :short_name
      t.references :captain, foreign_key: { to_table: :users }
      t.integer :team_size
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
