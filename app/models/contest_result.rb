class ContestResult < ApplicationRecord
  belongs_to :contest
  belongs_to :team #winner team for contest

  after_create :update_points

  validates :team_id, uniqueness: { scope: :contest_id }

  def update_points
    winner_id = team_id
    ContestParticipant.where(answer_id: winner_id, contest_id: contest_id).update(reward_points: 100)
    contest.update(status: 'COMPLETED')
  end

end
