# frozen_string_literal: true

class Api::V1::ContestsController < Api::ApplicationController
  before_action :find_contest, only: [:show]

  def index
    contests = Contest.all.includes(match: [:team_one, :team_two, :winner], contest_result: :team)

    render json: { data: {contest: contests}, message: I18n.t('model.found.success', model_name: 'Contest')}, status: :ok
  end

  def show
    if @contest
      render json: { data: @contest, message: I18n.t('model.found.success', model_name: 'Contest')}, status: :ok
    else
      render json: { error: I18n.t('model.found.failure', model_name: 'Contest')}, status: :unprocessable_entity
    end
  end

  private

  def find_contest
    @contest = Contest.find_by(id: params[:id])
  end

end
