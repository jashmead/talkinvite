# People Controller
# 
# 2nd most important controller
#
# TBD:  add in separate change password form

class PeopleController < ApplicationController

  # profile, settings, & home are only available to the 'correct_person': logged in as the person being profiled, set, or home'd
  # edit & update only available to the 'correct_person'

  before_action :set_person, only: [:show, :edit, :update, :destroy, :settings, :home, :change_password]

  ## removed index (& therefore search) from list of routes that require you to be signed in; 
  ##    -- no, this caused additional failures
  ##    -- need deeper understanding before we can continue
  ##    -- put :index back in for now

  before_action :signed_in_person, only: [ :index, :edit, :update, :destroy, :settings, :home, :profile, :change_password ]

  # do not need correct_person for settings, profile, & home because they reroute *to* the correct_person
  before_action :correct_person, only: [:edit, :update]

  # most a regular person can do is inactivate
  before_action :admin_person, only: [:destroy]

  # TBD:  add in the new fields, as url
  def search_fields
    [ 'name', 'email', 'description' ]
  end

  # TBD: we can change the footer for profile, settings, & home.  Do we wish to?
  def feet_center
    if signed_in?
      feet_for_people_pages
    else
      feet_for_static_pages
    end
  end

  # GET /people
  # GET /people.json
  def index
    super
    @people = Person.all
    # @title = pluralize(@people.count, "person").titlecase
  end

  # GET /people/1
  # GET /people/1.json
  def show
    # don't need to look for person here; done in 'before_action' callback by set_person
    if ! @person 
      # logger.debug("CC: PeopleController.show: no person found for id# #{params[:id]}")
      flash.now[:alert] = "There isn't any person# " + :id.to_s
      render :search and return
    end
    logger.debug("PeopleController.show: @person: #{@person.inspect}")
    @title = @person.name.titlecase
    @data_role = 'dialog' if @person != current_person
    render 'show' # have to spell it out in case we were called from 'profile'
  end

  # TBD: merge profile back into 'show'
  def profile
    @person = current_person
    @title = @person.name.titlecase
    show
  end

  # GET /people/new
  def new
    ## logger.debug("PeopleController.new")
    @person = Person.new
  end

  # GET /people/1/edit
  # TBD:  if not admin or correct_person, switch to 'show'
  def edit
    logger.debug("PeopleController.edit: params: #{params.inspect}, @current_person: #{@current_person.inspect}")
    # don't need to look for person here; done in 'before_action' callback by set_person
    if @person != current_person
      render 'show' and return
    end
    @title = @person.name.titlecase
  end

  # settings are the same as edit, except we force the person to be the current_person
  # TBD:  put password stuff in a button
  def settings
    logger.debug("PeopleController.settings: params: #{params.inspect}, @current_person: #{@current_person.inspect}")
    @person = current_person
    @title = @person.name.titlecase
    @action_name = 'settings'
  end

  def change_password
    logger.debug("PeopleController.change_password: params: #{params.inspect}, @current_person: #{@current_person.inspect}")
    @person = current_person
    @title = ("password 4 " + @person.name).titlecase
  end

  # 'home' is a control panel type thing
  # TBD:  add talks box, eliminate update fields
  def home
    # TBD: how to manage return navigation 
    store_location  # so if we click on something we'll come back here:  it is home, after all!
    @person = current_person
    @talks = Talk.talks_by_person(@person)
    @title = @person.name.titlecase
  end

  # POST /people
  # POST /people.json
  def create
    ## logger.debug("PeopleController.create: #{params.inspect}")

    @person = Person.new(person_params)

    if @person.save 
      sign_in @person
      flash[:success] = "Welcome to Talk Invite!"
      redirect_to @person
    else
      render :new
    end

  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  # update should be called by edit, settings
  def update
    ## correct_person finds the appropriate person
    ## @person = Person.find(params[:id])
    # update_attributes should not be running validations? or should it?
    logger.debug("PeopleController.update: @person: #{@person.inspect}");
    if @person.update_attributes(person_params)
      flash[:success] = "Profile updated"
      sign_in @person     # why needed?
      redirect_to @person
    else
      ## logger.debug("QQ: PeopleController.update: failure");
      render :edit
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  # commenting out the respond_to bit causes tests to fail with a missing template error.  Hunh?
  # TBD: PeopleControllers.destroy will need to be customized to People
  def destroy
    ## note use of method chaining to combine find & destroy into one line
    Person.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :no_content }
    end
  end

  def search
    logger.debug("PeopleController.search")
  end

  def found
    logger.debug("PeopleController.found")
    # TBD:  add in a title of the form N people found?
    @people = search_q(Person)
  end

  def oauth
    teapot_q
  end

  # people can have a location associated with them so get a map as well
  def map
    @person = Person.find(params[:id])
    map_q(@person, params)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      ## ActiveRecord will raise an exception if the record is not found
      begin
        @person = Person.find(params[:id])
      rescue
        # TBD: is defaulting this a good idea?
        logger.debug("PeopleController.set_person: params: #{params.inspect}")
        @person = Person.new
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # Here we allow only password & password_confirmation, but not the true field, password_digest!
    # We also do *not* allow admin or sub flags to be set from here
    def person_params
      # params whitelist does *not* include admin, sub, remember_token
      params.require(:person).permit(
        :name, 
        :email, 
        :password, 
        :password_confirmation,
        :description
      )
    end

    # correct_person used by edit, update; verifies that we are editing only our own stuff
    # similar 'home' page forces change to current person
    def correct_person
      @person = Person.find(params[:id])
      redirect_to(root_url) unless current_person?(@person)
    end

    def admin_person
      redirect_to(root_url) unless current_person.admin?
    end

    def subscriber
      redirect_to(root_url) unless current_person.sub? || current_person.admin?
    end

    def talk_admin?
      # TBD:  add in membership status == 'admin'
      current_talk && current_talk.person_id = current_person.id
    end

    # TBD:  add in 'invite'? is this best place for invite?

end
