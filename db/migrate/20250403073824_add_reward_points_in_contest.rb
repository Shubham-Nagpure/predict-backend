class AddRewardPointsInContest < ActiveRecord::Migration[7.2]
  def change
    add_column :contest_participants, :reward_points, :integer, default: 0
  end
end
