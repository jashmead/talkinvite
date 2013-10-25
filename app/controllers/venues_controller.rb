class VenuesController < ApplicationController
  before_action :set_venue, only: [:show, :edit, :update, :destroy]

  # GET /venues
  # GET /venues.json
  def index
    @venues = Venue.all
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
  end

  # GET /venues/new
  def new
    @venue = Venue.new
  end

  # GET /venues/1/edit
  def edit
  end

  # POST /venues
  # POST /venues.json
  def create
    @venue = Venue.new(venue_params)
    create_q(@venue)
  end

  # PATCH/PUT /venues/1
  # PATCH/PUT /venues/1.json
  def update
    update_q(@venue, venue_params)
  end

  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    destroy_q(@venue, venues_url)
  end

  def found
    @venues = search_q(Venue)
  end

  def search
  end

  def map
    @venue = Venue.find(params[:id])
    map_q(@venue, params)
  end

  def calendar
    @venue = Venue.find(params[:id])
    calendar_q(@venue, params)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue
      @venue = Venue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def venue_params
      params.require(:venue).permit(:person_id, :name, :description, :longitude, :latitude, :venue_type)
    end
end
