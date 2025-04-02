class Team < ApplicationRecord
  has_one_attached :logo, dependent: :destroy

  belongs_to :captain, class_name: "User", optional: true
  validates :name, presence: true

  def as_json(options = {})
    super(options.merge({
      methods: [:logo_url]
    }))
  end

  def logo_url
    return '' unless logo.attached?

    Rails.application.routes.url_helpers.url_for(logo)
  end

end
