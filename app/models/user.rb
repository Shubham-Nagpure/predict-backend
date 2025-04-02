class User < ApplicationRecord
  has_many :teams, foreign_key: :captain_id, dependent: :nullify
end
