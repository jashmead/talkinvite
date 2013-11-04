class MapsController < ApplicationController
  before_action :set_map, only: [:show, :edit, :update, :destroy]

  # GET /maps
  # GET /maps.json
  def index
    super
    @maps = Map.all
  end

  # GET /maps/1
  # GET /maps/1.json
  def show
  end

  # GET /maps/new
  def new
    @map = Map.new
  end

  # GET /maps/1/edit
  def edit
  end

  # POST /maps
  # POST /maps.json
  def create
    @map = Map.new(map_params)
    create_q(@map)
  end

  # PATCH/PUT /maps/1
  # PATCH/PUT /maps/1.json
  def update
    update_q(@map, map_params)
  end

  # DELETE /maps/1
  # DELETE /maps/1.json
  def destroy
    destroy_q(@map, maps_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_map
      @map = Map.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def map_params
      params.require(:map).permit(:name, :description, :geometry, :settings, :history)
    end
end
