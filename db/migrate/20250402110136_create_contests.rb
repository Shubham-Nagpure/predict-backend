class CreateContests < ActiveRecord::Migration[7.2]
  def change
    create_table :contests do |t|
      t.integer :status
      t.string :name
      t.string :contest_type
      t.references :match
      t.integer :team_size
      t.text :description
      t.string :title
      t.datetime :deleted_at
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
