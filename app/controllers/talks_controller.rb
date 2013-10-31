# Talks Central!
#
# there are no longer routes to nearby, recent, & roulette because search now includes location stuff & is limited to active

class TalksController < ApplicationController
  before_action :set_talk, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_person, only: [:new, :create, :edit, :update, :destroy, :my_talks]
  before_action :correct_person, only: :destroy

  def footer_fields 
    [ '/talks/start', '/talks/new', '/talks/my_talks', '/talks/search', @@help_page ]
  end

  # GET /talks
  # GET /talks.json
  def index
    @talks = Talk.all
  end

  # GET /talks/1
  # GET /talks/1.json
  def show
  end

  # GET /talks/new
  def new
    logger.debug("TalksController.new")
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
    update_q(@talk, talk_params, Talk)
  end

  # DELETE /talks/1
  # DELETE /talks/1.json
  def destroy
    @talk.destroy
    redirect_to root_url
  end

  # start is the default starting point for the entire website
  # right now, it is a virtual page, redirecting to appropriate start points for signed_in & not signed_in users
  def start
    logger.debug("CC: TalksController.start")
    if signed_in?
      redirect_to '/people/home'
    else 
      # talks are automatically listed 'active' only, most recent first, and nearby in preference (default radius of search)
      redirect_to '/talks'
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
    person = current_person
    @talks = Talk.talks_by_person(person)
  end

  # search will be limited to active (with override), to nearby (including infinite distance), & in most recent first order
  def search
    ## logger.debug("CC: TalksController.search")
  end

  # active will show only the 'active' talks
  def active
    @talks = Talk.where('talk_status = ?', 'active')
  end

  def map
    @talk = Talk.find(params[:id])
    map_q(@talk, params)
  end

  # TBD:  all_searches

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_talk
      @talk = Talk.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def talk_params
      params.require(:talk).permit(:summary, :description, :person_id)
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
