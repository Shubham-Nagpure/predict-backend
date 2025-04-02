# frozen_string_literal: true

class Api::V1::ContestParticipantsController < Api::ApplicationController

  def create
    contest_participant = ContestParticipant.where(contest_id: contest_participant_params[:contest_id],
                                                    user_id: contest_participant_params[:user_id]).first

    if contest_participant
      failure_response('You already save response for this') and return
    else
      contest_participant = ContestParticipant.new(contest_participant_params)

      if contest_participant.save
        success_response(I18n.t('model.create.success', model_name: 'Response'), { contest_participant: contest_participant })
      else
        failure_response(I18n.t('model.create.failure', model_name: 'Response'), contest_participant.errors.full_messages) and return
      end
    end
  end

  private

  def contest_participant_params
    params[:contest_participant].permit(:contest_id, :user_id, :answer_id)
  end

end
