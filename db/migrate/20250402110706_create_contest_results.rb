class CreateContestResults < ActiveRecord::Migration[7.2]
  def change
    create_table :contest_results do |t|
      t.references :contest
      t.references :team

      t.timestamps
    end
  end
end
