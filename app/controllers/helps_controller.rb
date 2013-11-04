class HelpsController < ApplicationController
  before_action :set_help, only: [:show, :edit, :update, :destroy]

  # GET /helps
  # GET /helps.json
  def index
    super
    @helps = Help.all
  end

  # GET /helps/1
  # GET /helps/1.json
  def show
  end

  # GET /helps/new
  def new
    @help = Help.new
  end

  # GET /helps/1/edit
  def edit
  end

  # POST /helps
  # POST /helps.json
  def create
    @help = Help.new(help_params)
    create_q(@help)
  end

  # PATCH/PUT /helps/1
  # PATCH/PUT /helps/1.json
  def update
    update_q(@help, help_params)
  end

  # DELETE /helps/1
  # DELETE /helps/1.json
  def destroy
    destroy_q(@help, helps_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_help
      @help = Help.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def help_params
      params.require(:help).permit(:name, :description)
    end
end
