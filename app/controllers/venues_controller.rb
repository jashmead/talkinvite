class VenuesController < ApplicationController
  before_action :set_venue, only: [:show, :edit, :update, :destroy]

  # default search_fields seem fine...

  def footer_fields 
    if signed_in?
      [ '/talks/my_talks', '/venues/search', '/talks/nearby', '/talks/recent', @@help_page ]
    else
      super
    end
  end

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

  def search
  end

  ## found -- responds to completed searches
  ## may want to build a found_q to consolidate common elements
  def found
    if params['button'] == 'Add Venue'
      @venue = Venue.new( { 'name' => check_q } )
      render 'new' and return
    else
      @venues = search_q(Venue)
    end
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

    # fetch_children likely to be slow; may want to break it down, once it is working
    # TBD:  how do we save these back? there must be a tool!
    def fetch_children

      # talks that use me as their location:
      @talks = @venue.talks

      # my tags:
      @tags = @venue.tagable

      # my attachments:
      @attachments = @venue.attachable
    end

end
