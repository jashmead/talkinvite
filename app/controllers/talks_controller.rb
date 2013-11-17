# Talks Controller

# most important single piece of code

# there are no longer routes to nearby, recent, & roulette because search now includes location stuff & is limited to posted

class TalksController < ApplicationController

  # should always have a person for a talk
  before_action :set_person
  # TBD:  add in posts, comments, members?
  before_action :set_talk, only: [:show, :edit, :update, :destroy, :control, :map]

  # TBD:  allow the 'new' action without a person, require before a create however
  before_action :signed_in_person, only: [:new, :create, :edit, :update, :destroy ]

  # note: for control:  
  #   -- owner can do anything, 
  #   -- anyone can join, 
  #   -- members can leave, post, comment, message, & map
  before_action :correct_person, only: [:edit, :destroy]

  # currently talks & people share the list of nav buttons, but that is likely to change
  def feet_center
    feet_for_people_pages
  end

  # GET /talks
  # GET /talks.json
  def index
    super
    @talks = Talk.all # all just works much better than anything else
  end

  # GET /talks/1
  # GET /talks/1.json
  def show
    @title = @talk.summary
  end

  # GET /talks/new
  # TBD:  allow people who aren't signed in to start a talk, but don't allow save until they have an id
  #   -- and explain why in the help page
  #   -- when they start the new talk, put up a flash that says they'll need to log in/create new account before they can save/post
  #   -- at some point, verify their email, thus avoiding annoying spam
  #   -- meanwhile, making sure you are signed in before starting a talk is OK
  def new
    @talk = @person.talks.build
  end

  # GET /talks/1/edit
  # TBD:  allow easy flipping between edit & control?  or treat edit as scaffolding while en route to control?
  def edit
  end

  # GET /talks/1/control
  # TBD:  saving from control is done via ajax
  # TBD:  add control into routes
  def control
  end

  def search_fields
    [ 'summary', 'description', 'who_desc', 'where_desc', 'when_desc' ]
  end

  # POST /talks
  # POST /talks.json
  def create
    # TBD:  we would like to return to the 'control' screen from create, not to the default
    @talk = @person.talks.create(talk_params)
    create_q(@talk)
  end

  # PATCH/PUT /talks/1
  # PATCH/PUT /talks/1.json
  # TBD:  verify update is working correctly
  def update
    update_q(@talk, talk_params)
  end

  # DELETE /talks/1
  # DELETE /talks/1.json
  # TBD: TalksController.destroy will need to be customized to requirements of talks
  def destroy
    destroy_q(@talk, home_path)
  end

  # start is root_path for system
  def start
    if signed_in?
      redirect_to home_people(@person)
    else 
      redirect_to '/talks/search'
    end
  end

  # found = search + index; also, has a 'Create Talk' button
  def found
    if params['button'] == 'Create Talk'
      @talk = Talk.new( { summary: check_q, person_id: @person.id } )
      render 'new' and return
    else
      # TBD:  fix search to automatically pull in supporting detail, as person
      #   -- could use includes 
      #   -- could hand-build the sql
      #   -- as this is an efficiency thing, defer till system core is up
      @talks = search_q(Talk)
      logger.debug("TalksController.found: @talks: #{@talks.inspect}")
    end
  end

  # divers searches for talks -- in a way, the heart of the system
  #   can also add twitter, facebook, favorite urls or topics, ...
  #   actual search should be done with the Talk model,
  #     -- some stubs already present

  def search
  end

  def map
    map_q(@talk, params)
  end

  # TBD:  specialized searches

  private
    def set_person
      @person = Person.find_by_id(params[:person_id]) ||
        current_person ||
        anonymous
      logger.debug("TalksController.set_person: @person: #{@person}")
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_talk
      # could work thru @person, but that can be a bit trickier, what with anonymous & all
      @talk = Talk.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def talk_params
      logger.debug("TalksController.talk_params: params: #{params.inspect}")
      # note: params:
      #   -- "#require" makes sure that the parameters include a 'talk' hash
      #   -- "#permit" allows only the white-listed fields thru
      #   -- returns the params object itself
      params.require(:talk).permit(:summary, :description, :person_id, 
        :start_dt, :end_dt, :longitude, :latitude, :who_desc, :talk_status, :where_desc, :when_desc)
    end

    def correct_person
      # find the talk through the person, if not found, this person doesn't own the talk
      @talk = current_person.talks.find_by(id: params[:id])
      redirect_to root_url if @talk.nil?
    end

end
