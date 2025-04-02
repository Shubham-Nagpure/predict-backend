# frozen_string_literal: true

class Api::V1::TeamsController < Api::ApplicationController
  before_action :find_team, only: [:show]

  def index
    teams = Team.all

    render json: { data: {teams: teams}, message: I18n.t('model.found.success', model_name: 'Teams')}, status: :ok
  end

  def show
    if @team
      render json: { data: @team, message: I18n.t('model.found.success', model_name: 'Team')}, status: :ok
    else
      render json: { error: I18n.t('model.found.failure', model_name: 'Team')}, status: :unprocessable_entity
    end
  end

  private

  def find_team
    @team = Team.find_by(id: params[:id])
  end

end
