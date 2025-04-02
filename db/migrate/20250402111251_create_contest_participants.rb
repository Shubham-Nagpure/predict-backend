class CreateContestParticipants < ActiveRecord::Migration[7.2]
  def change
    create_table :contest_participants do |t|
      t.references :contest
      t.references :user
      t.integer :answer_id

      t.timestamps
    end
  end
end
