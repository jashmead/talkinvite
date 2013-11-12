# there are no longer routes to nearby, recent, & roulette because search now includes location stuff & is limited to posted

class TalksController < ApplicationController

  # should always have a person for a talk
  before_action :set_person
  before_action :set_talk, only: [:show, :edit, :update, :destroy, :control]

  # TBD:  allow the 'new' action without a person, require before a create however
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
    # TBD: can we use an association method for this? person.talk & person.talks seemed to fail? maybe because no talks present
    # @talks = Talk.talks_by_person(@person)
    @talks = Talk.all
  end

  # GET /talks/1
  # GET /talks/1.json
  def show
    @talk = @person.talks.find(params[:id])
  end

  # GET /talks/new
  # TBD:  allow people who aren't signed in to start a talk, but don't allow save until they have an id
  #   -- and explain why in the help page
  #   -- when they start the new talk, put up a flash that says they'll need to log in/create new account before they can save/post
  #   -- at some point, verify their email, thus avoiding annoying spam
  #   -- meanwhile, making sure you are signed in before starting a talk is OK
  def new
    # logger.debug("TalksController.new")
    @talk = @person.talks.build
  end

  # GET /talks/1/edit
  def edit
    @talk = @person.talks.find(params[:id])
  end

  def control
    @talk = @person.talks.find(params[:id])
  end

  def search_fields
    [ 'summary', 'description' ]
  end

  # POST /talks
  # POST /talks.json
  def create
    params.permit!
    # logger.debug("TalksController.create: @person: #{@person.inspect}, params: #{params.inspect}")
    @talk = @person.talks.create(talk_params)
    # logger.debug("TalksController.create: @talk: #{@talk.inspect}")
    if @talk.save
        flash.now[:success] = "Talk has been created"
        redirect_to [@person, @talk]
    else
      flash[:alert] = "Talk has not been created"
      render 'new'
    end
  end

  # PATCH/PUT /talks/1
  # PATCH/PUT /talks/1.json
  ## what is correct handling of update of current talk? -- use logger.debug to find
  def update
    # logger.debug("TalksController.update: params: #{params.inspect}")
    update_q(@talk, params)
  end

  # DELETE /talks/1
  # DELETE /talks/1.json
  # TBD: TalksController.destroy will need to be customized to requirements of talks
  def destroy
    # logger.debug("TalksController.destroy: params: #{params.inspect}")
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
      redirect_to home_people(@person)
    else 
      # talks are automatically listed 'posted' only, most recent first, and nearby in preference (default radius of search)
      redirect_to posted_person_talks(@person)
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

  # TBD:  eliminate my_talks, only belongs as a search on the model
  def my_talks
    # logger.debug("TalksController.my_talks: params: #{params.inspect}")

    @title = "My Talks"
    @person = current_person || anonymous
    @talks = Talk.talks_by_person(@person)

    render 'index' and return
  end

  # search will be limited to posted (with override), to nearby (including infinite distance), & in most recent first order
  def search
    @person = current_person || anonymous
    # logger.debug("TalksController.search: params: #{params.inspect}")
  end

  # posted will show only the 'posted' talks
  def posted
    @title = 'Current Talks'
    @talks = Talk.where('talk_status = ?', 'posted')
    render 'index' and return
  end

  def map
    @talk = Talk.find(params[:id])
    map_q(@talk, params)
  end

  # TBD:  specialized searches

  private
    def set_person
      @person = Person.find_by_id(params[:person_id]) or
        current_person or
        anonymous
      # logger.debug("TalksController.set_person: @person: #{@person}")
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_talk
      # @person = current_person || anonymous
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
