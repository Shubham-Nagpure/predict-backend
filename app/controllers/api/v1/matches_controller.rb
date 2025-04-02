# frozen_string_literal: true

class Api::V1::MatchesController < Api::ApplicationController
  before_action :find_match, only: [:show]

  def index
    matches = Match.all.includes(:team_one, :team_two)

    render json: { data: {matches: matches}, message: I18n.t('model.found.success', model_name: 'Matches')}, status: :ok
  end

  def show
    if @match
      render json: { data: @match, message: I18n.t('model.found.success', model_name: 'Macth')}, status: :ok
    else
      render json: { error: I18n.t('model.found.failure', model_name: 'Match')}, status: :unprocessable_entity
    end
  end

  private

  def find_match
    @match = Match.find_by(id: params[:id])
  end

end
