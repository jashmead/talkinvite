# Talks Controller

# most important single piece of code

# there are no longer routes to nearby, recent, & roulette because search now includes location stuff & is limited to posted

class TalksController < ApplicationController
  
  MAX_TALKS_PER_AGE = ApplicationController::MAX_ITEMS_PER_PAGE

  # current_talk set by set_talk, unset_talk
  cattr_accessor :current_talk, instance_accessor: false

  # these actions all need a talk; set current_talk as a side-effect
  before_action :set_talk, only: [:show, :edit, :update, :destroy, :control, :map, :calendar]

  # you have to be logged in to edit/update/destroy a talk
  before_action :authenticate_person!, only: [:new, :create, :edit, :update, :destroy ]

  # note: for control:  
  #   -- owner can do anything, 
  #   -- anyone can join, 
  #   -- members can leave, post, comment, message, & map
  # before_action :correct_person, only: [:edit, :destroy]

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
    @person = current_person
    @talk = @person.talks.build
    @member = @talk.members.build( person_id: current_person.id )
    logger.debug("TalksController.new: @talk: #{@talk.inspect}")
  end

  # GET /talks/1/edit
  # TBD:  allow easy flipping between edit & control?  or treat edit as scaffolding while en route to control?
  def edit
    # logger.debug("TalksController.edit: talk_admin? #{talk_admin?}, @talk: #{@talk.inspect}, current_person: #{current_person.inspect}")
    store_location
    render 'show' and return if ! talk_admin?
  end

  # GET /talks/1/control
  # TBD:  saving from control is done via ajax
  # TBD:  add control into routes
  def control
    logger.debug("TalksController.control: @talk: #{@talk.inspect}, current_person: #{current_person.inspect}")
    store_location
    @title = @talk.summary
  end

  def search_fields
    [ 'summary', 'description', 'who_desc', 'where_desc', 'when_desc' ]
  end

  # POST /talks
  # POST /talks.json
  def create
    # TBD:  we would like to return to the 'control' screen from create, not to the default
    @talk = Talk.new(talk_params)
    @talk.person_id = current_person.id # TBD: use one of the association functions for this?
    respond_to do |format|
      # TBD:  does this work or do we have to explicitly set the talk_id in the member record?
      if @talk.save 
        @member && @member.save
        format.html { 
          redirect_back_or control_talk_url(@talk)
          flash.now[:success] = 'A talk is born!'
        }
        # TBD: on format.json, do we want action: 'show' or do we want 'index'?  what does 'location: model' mean?
        format.json { render action: 'control', status: :created, location: @talk }
      else
        fail_q(@talk, format, 'new')
      end
    end
  end

  # PATCH/PUT /talks/1
  # PATCH/PUT /talks/1.json
  # TBD:  verify update is working correctly
  def update
    logger.debug("TalksController.update: talk_params: #{talk_params.inspect}")
=begin
    case talk_params['commit']
      when /post/i
        if ! @talk.posted
          @talk.posted = DateTime.now
          @talk.talk_status = 'posted'
        end
      when /cancel/i
        @talk.talk_status = 'cancelled'
      when /done/i
        @talk.talk_status = 'done'
    end
=end
    # TBD:  save membership status & talk at the same time, rather than in two separate calls
    update_q(@talk, talk_params)
    @member && update_q(@member, talk_params)
  end

  # DELETE /talks/1
  # DELETE /talks/1.json
  # TBD: TalksController.destroy will need to be customized to requirements of talks
  def destroy
    render 'show' and return if ! talk_admin?
    destroy_q(@talk, home_path)
    unset_talk
  end

  # start is root_path for system
  def start
    # TBD:  use store location here, if available?
    # TBD:  use url not path?
    if person_signed_in?
      # redirect_to '/people/home'
      redirect_to home_people_path
    else 
      # redirect_to '/talks/search'
      redirect_to search_talks_path
    end
  end

  # found = search + index; also, has a 'Start Talk' button
  def found
    if params['button'] == 'Start Talk'
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

  def calendar
    calendar_q(@talk, params)
  end

  def map
    map_q(@talk, params)
  end

  # TBD:  specialized searches
  def current_talk?(talk)
    TalksController.current_talk == talk
  end

  # return relation of associated talks
  # implies 'my_messages', 'my_memberships', 'my_comments' & so on
  def talks_by_person(person_id) 
    Talk.find_by_sql("select * from talks where person_id = ? or talk.id in (select talk_id from members where person_id = ?)",
      person_id, person_id)
  end

  def my_talks
    @title = "My Talks"
    @talks = talks_by_person(current_person.id)
  end

  private

    # set @talk & current_talk from params
    def set_talk
      # TBD:  using self.current_talk here raises error:   ActionDispatch::Cookies::CookieOverflow:
      #   -- may have to instantiate sessions in the database to fix
      #     -- could be we hit the 4K size limit for cookie-based sessions
      #   -- alternatively, we could store only the talk.id in the session...
      #   -- or, store the current_talk as a class variable in the Talk class, i.e. Talk::current_talk = 
      @talk = TalksController.current_talk = Talk.find(params[:id])
      @member = membership
      logger.debug("TalksController.set_talk: @talk: #{@talk.inspect}, @member: #{@member.inspect}")
    end

    def unset_talk
      TalksController.current_talk = nil
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def talk_params
      logger.debug("TalksController.talk_params: params: #{params.inspect}")
      # note: params:
      #   -- "#require" makes sure that the parameters include a 'talk' hash
      #   -- "#permit" allows only the white-listed fields thru
      #   -- returns the params object itself
      params.require(:talk).permit(:id, :summary, :description, :person_id, 
        :start_dt, :end_dt, :longitude, :latitude, :who_desc, :talk_status, :where_desc, :when_desc)
    end

    def talk_admin?(talk = nil)
      # TBD:  why is this elaborate setting of defaults needed? current_talk should have been set in set_talk
      talk ||= @talk || current_talk
      # TBD: include designated admins, members with member_type == 'admin'
      # logger.debug("TalksController.talk_admin?: @talk: #{@talk.inspect}, session: #{session.inspect}")
      # logger.debug("TalksController.talk_admin?: current_person: #{current_person.inspect}, current_talk: #{current_talk.inspect}")
      current_person && talk && current_person.id == talk.person_id
    end

    def membership
      # member_relation is the relation which is either none or else has just the member in it
      # TBD:  what does 'where' return on no rows found?
      if person_signed_in? 
        @member = Member.where("talk_id = ? and person_id = ?", @talk.id, current_person.id).first
      else
        @member = nil
      end
    end

end
