class ContestParticipant < ApplicationRecord
  belongs_to :contest
  belongs_to :user
  belongs_to :answer, class_name: 'Team'

  def as_json(options = {})
    super(options.merge({
      include: [:contest, :answer]
    }))
  end
end
