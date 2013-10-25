class TalksController < ApplicationController
  before_action :set_talk, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_person, only: [:new, :create, :edit, :update, :destroy, :my_talks]
  before_action :correct_person, only: :destroy

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
    @talk = Talk.new
  end

  # GET /talks/1/edit
  def edit
  end

  def search_fields
    [ 'summary', 'description' ]
  end

  # POST /talks
  # POST /talks.json
  def create
    @talk = current_person.talks.build(talk_params)
    if @talk.save
      flash[:success] = "Talk Started"
      redirect_to edit_talk_url(@talk)
    else
      @feed_talks = []
      # really want to return to the form that called us
      render 'talks/search'
    end
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
  # right now, it is a virtual page, switching to my_talks or gottalk, depending
  def start
    logger.debug("CC: TalksController.start")
    if signed_in?
      @talks = Talk.talks_by_person( current_person )
      render 'my_talks' and return
    else 
      @talks = Talk.gottalk
      render 'gottalk' and return
    end
  end

  ## found & gottalk are two responses to completed searches
  def found
    if params['button'] == 'Start Talk'
      @talk = Talk.new( { 'summary' => check_q } )
      render 'new' and return
    else
      logger.debug("CC: TalksController.found: params: #{params.inspect}")
      @talks = search_q(Talk)
    end
  end

  # gottalk is a snazzed up version of talks/search
  def gottalk
    @talks = Talk.gottalk
    if ! @talks
      ## logger.debug("CC: TalksController.gottalk: no talks found")
      flash.now[:info] = "No talks found"
    else
      ## logger.debug("CC: TalksController.gottalk: #{@talks.size} talks found")
      # can we get pluralize to work here?
      if @talks.size == 1
        flash.now[:info] = "One talk found"
      else
        flash.now[:info] = "#{@talks.size} talks found"
      end 
    end 
    @talks
  end

  # divers searches for talks -- in a way, the heart of the system
  #   can also add twitter, facebook, favorite urls or topics, ...
  #   actual search should be done with the Talk model,
  #     -- some stubs already present

  def category  ## categories might be sports, movies, politics, ...
    teapot_q
  end

  # go to talks with your friends are part of
  def my_friends
    teapot_q
  end

  ## my_tags works by checking tags you've put on yourself & looking for talks with them
  def my_tags 
    teapot_q
  end

  def my_talks
    logger.debug("CC: TalksController.my_talks")
    ## can probably consolidate once we have debugged
    if signed_in?
      person = current_person
      @talks = Talk.talks_by_person(person)
    else
      @talks = Talk.gottalk
    end
    @talks
  end

  def nearby
    @talks = Talk.nearby(page: params[:page])
  end

  def recent
    @talks = Talk.recent(page: params[:page])
    logger.debug("CC: TalksController.recent: @talks: #{@talks.inspect}")
    @talks
  end

  def roulette # like chatroulette :)
    teapot_q
  end

  def search
    logger.debug("CC: TalksController.search")
  end

  def map
    @talk = Talk.find(params[:id])
    map_q(@talk, params)
  end

  def calendar
    @talk = Talk.find(params[:id])
    calendar_q(@talk, params)
  end

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
end
