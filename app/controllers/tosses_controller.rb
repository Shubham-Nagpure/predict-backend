class TossesController < ApplicationController
  before_action :set_toss, only: %i[ show edit update destroy ]

  # GET /tosses or /tosses.json
  def index
    @tosses = Toss.all
  end

  # GET /tosses/1 or /tosses/1.json
  def show
  end

  # GET /tosses/new
  def new
    @toss = Toss.new
  end

  # GET /tosses/1/edit
  def edit
  end

  # POST /tosses or /tosses.json
  def create
    @toss = Toss.new(toss_params)

    respond_to do |format|
      if @toss.save
        format.html { redirect_to @toss, notice: "Toss was successfully created." }
        format.json { render :show, status: :created, location: @toss }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @toss.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tosses/1 or /tosses/1.json
  def update
    respond_to do |format|
      if @toss.update(toss_params)
        format.html { redirect_to @toss, notice: "Toss was successfully updated." }
        format.json { render :show, status: :ok, location: @toss }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @toss.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tosses/1 or /tosses/1.json
  def destroy
    @toss.destroy!

    respond_to do |format|
      format.html { redirect_to tosses_path, status: :see_other, notice: "Toss was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_toss
      @toss = Toss.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def toss_params
      params.require(:toss).permit(:title, :team_one_id, :team_two_id, :timing)
    end
end
