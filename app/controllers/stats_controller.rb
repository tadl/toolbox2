class StatsController < ApplicationController
  before_action :authenticate_super_user!
  before_action :set_stat, only: [:show, :edit, :update, :destroy]

  # GET /stats
  # GET /stats.json
  def index
    @stats = Stat.all
  end

  # GET /stats/1
  # GET /stats/1.json
  def show
  end

  # GET /stats/new
  def new
    @stat = Stat.new
  end

  # GET /stats/1/edit
  def edit
  end

  # POST /stats
  # POST /stats.json
  def create
    @stat = Stat.new(stat_params)

    respond_to do |format|
      if @stat.save
        format.html { redirect_to @stat, notice: 'Stat was successfully created.' }
        format.json { render :show, status: :created, location: @stat }
      else
        format.html { render :new }
        format.json { render json: @stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stats/1
  # PATCH/PUT /stats/1.json
  def update
    respond_to do |format|
      if @stat.update(stat_params)
        format.html { redirect_to @stat, notice: 'Stat was successfully updated.' }
        format.json { render :show, status: :ok, location: @stat }
      else
        format.html { render :edit }
        format.json { render json: @stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stats/1
  # DELETE /stats/1.json
  def destroy
    @stat.destroy
    respond_to do |format|
      format.html { redirect_to stats_url, notice: 'Stat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stat
      @stat = Stat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stat_params
      params.require(:stat).permit(:code, :name, :group_name, :start_date, :end_date)
    end
end
