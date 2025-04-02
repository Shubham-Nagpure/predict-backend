class ContestResultsController < ApplicationController

  # GET /contests/new
  def new
    @contest_result = ContestResult.new
  end

  # POST /contests or /contests.json
  def create
    @contest_result = ContestResult.new(contest_result_params)

    respond_to do |format|
      if @contest_result.save
        format.html { redirect_to @contest_result.contest, notice: "Contest Result was successfully created." }
        format.json { render :show, status: :created, location: @contest_result }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contest_result.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def contest_result_params
      params.require(:contest_result).permit(:contest_id, :team_id)
    end
end
