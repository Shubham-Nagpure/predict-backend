class Contest < ApplicationRecord
  STATUS = { 'UPCOMING' => 0, 'LIVE' => 1, 'COMPLETED' => 2 }.freeze
  CONTEST_NAME = { 'TOSS' => 0, 'MATCH' => 1 }.freeze
  CONTEST_TYPE = { 'TEAM' => 0, 'SINGLE_PLAYER' => 1 }.freeze

  enum status: STATUS
  enum name: CONTEST_NAME
  enum contest_type: CONTEST_TYPE

  belongs_to :match
  has_one :contest_result


  def as_json(options = {})
    super(options.merge({
      include: [match: {
        include: [:team_one, :team_two, :winner]
      },
      contest_result: {
        include: :team
      }
    ]
    }))
  end


end
