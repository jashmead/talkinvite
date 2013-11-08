# there are no longer routes to nearby, recent, & roulette because search now includes location stuff & is limited to active

class TalksController < ApplicationController
  before_action :set_talk, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_person, only: [:new, :create, :edit, :update, :destroy, :my_talks]
  before_action :correct_person, only: :destroy

  # currently talks & people share the list of nav buttons, but that is likely to change
  def feet_center
    feet_for_people_pages
  end

  # GET /talks
  # GET /talks.json
  def index
    super
    @talks = Talk.all
    # logger.debug("CC: TalksController.index: @talks: #{@talks.inspect}")
  end

  # GET /talks/1
  # GET /talks/1.json
  def show
  end

  # GET /talks/new
  # TBD:  allow people who aren't signed in to start a talk, but don't allow save until they have an id
  #   -- and explain why in the help page
  def new
    # logger.debug("TalksController.new")
    @talk = Talk.new
  end

  # GET /talks/1/edit
  def edit
  end

  def control
    @talk = Talk.find(params[:id])
  end

  def search_fields
    [ 'summary', 'description' ]
  end

  # POST /talks
  # POST /talks.json
  def create
    @talk = current_person.talks.build(talk_params)
    create_q(@talk)
  end

  # PATCH/PUT /talks/1
  # PATCH/PUT /talks/1.json
  ## what is correct handling of update of current talk? -- use logger.debug to find
  def update
    logger.debug("TalksController.update: params: #{params.inspect}")
    update_q(@talk, talk_params)
  end

  # DELETE /talks/1
  # DELETE /talks/1.json
  # TBD: TalksController.destroy will need to be customized to requirements of talks
  def destroy
    logger.debug("TalksController.destroy: params: #{params.inspect}")
    destroy_q(@talk, root_url)
  end

  # start is the default starting point for the entire website
  # right now, it is a virtual page, redirecting to appropriate start points for signed_in & not signed_in users
  # TBD:  switch 'start' to be a one stop fits all place to start a talk & sign in if you haven't before
  # TBD:  icon for start talk screen? just a comment bubble?
  #   -- first open is a simple: what, where, when, why, who
  # TBD:  icon for my talks screen? 
  #   -- second is a my talks
  #   -- third is find in talks, search option
  #   -- fourth is find on web, web icon
  def start
    # logger.debug("CC: TalksController.start")
    if signed_in?
      redirect_to '/people/home'
    else 
      # talks are automatically listed 'active' only, most recent first, and nearby in preference (default radius of search)
      redirect_to '/talks/active'
    end
  end

  ## found -- responds to completed searches
  def found
    if params['button'] == 'New Talk'
      @talk = Talk.new( { 'summary' => check_q } )
      render 'new' and return
    else
      @talks = search_q(Talk)
    end
  end

  # divers searches for talks -- in a way, the heart of the system
  #   can also add twitter, facebook, favorite urls or topics, ...
  #   actual search should be done with the Talk model,
  #     -- some stubs already present

  def my_talks
    ## logger.debug("CC: TalksController.my_talks")
    ## can probably consolidate once we have debugged
    @person = current_person
    @title = "My Talks"
    @talks = Talk.talks_by_person(@person)
    render 'index' and return
  end

  # search will be limited to active (with override), to nearby (including infinite distance), & in most recent first order
  def search
    ## logger.debug("CC: TalksController.search")
  end

  # active will show only the 'active' talks
  def active
    @title = 'Current Talks'
    @talks = Talk.where('talk_status = ?', 'active')
    render 'index'
  end

  def map
    @talk = Talk.find(params[:id])
    map_q(@talk, params)
  end

  # TBD:  specialized searches

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_talk
      @talk = Talk.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def talk_params
      params.require(:talk).permit(:summary, :description, :person_id, 
        :start_dt, :end_dt, :posted_dt, :longitude, :latitude, :who_desc, :talk_status, :where_desc, :when_desc)
    end

    def correct_person
      # find the talk(s) through the person
      @talk = current_person.talks.find_by(id: params[:id])
      # logger.debug("ZZ: TalksController.correct_person: id = #{params[:id]}, @talk = #{@talk.inspect}") #DDT
      redirect_to root_url if @talk.nil?
    end

    # fetch_children likely to be slow; may want to break it down, once it is working
    # TBD:  how do we save these back? there must be a tool!
    def fetch_children
      @comments = @talk.comments
      @posts = @talk.posts

      @talks = @talk.guests
    end

    def fetch_parents
      # see if this even works!
      @person = @talk.person
    end

end
