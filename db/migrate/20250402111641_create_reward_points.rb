class CreateRewardPoints < ActiveRecord::Migration[7.2]
  def change
    create_table :reward_points do |t|
      t.references :contest
      t.references :user
      t.integer :points

      t.timestamps
    end
  end
end
