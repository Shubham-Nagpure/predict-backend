class Match < ApplicationRecord
  belongs_to :winner, class_name: "Team", optional: true
  belongs_to :team_one, class_name: "Team", optional: true
  belongs_to :team_two, class_name: "Team", optional: true

  has_many :contests

  def as_json(options = {})
    super(options.merge({
      include: [:team_one, :team_two, :winner]
    }))
  end

  def teams
    Team.where(id: [team_one.id, team_two.id])
  end
end
