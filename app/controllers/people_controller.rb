# People Controller
# 
# 1. 2nd most important controller
#
##  will be adding actions:  signin, signout, settings
##  will be adding profile_picture
##  will be adding current_location (in session on server, at this point)
##  will be adding checks on destroy:  you have to be signed in, an admin, & not deleting yourself
##  'format' bits are needed; how do they work? -- commented out for now...
##  params[:page] defaults to nil, presumably a way to override the default page


class PeopleController < ApplicationController

  # profile, settings, & home are only available to the 'correct_person': logged in as the person being profiled, set, or home'd
  # edit & update only available to the 'correct_person'

  before_action :set_person, only: [:show, :edit, :update, :destroy, :settings, :home]

  ## removed index (& therefore search) from list of routes that require you to be signed in; 
  ##    -- no, this caused additional failures
  ##    -- need deeper understanding before we can continue
  ##    -- put :index back in for now

  before_action :signed_in_person, only: [ :index, :edit, :update, :destroy, :settings, :home, :profile ]

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
    # logger.debug("CC: PeopleController.index: params: '#{params.inspect}'")
    @title = "List of People"
    @people = Person.all(params[:search]).paginate(page: params[:page])
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
    @title = @person.name
    @data_role = 'dialog' if @person != current_person
    render 'show' # have to spell it out in case we were called from 'profile'
  end

  # TBD: merge profile back into 'show'
  def profile
    @person = current_person
    @title = @person.name
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
    @title = @person.name
    render 'edit' # have to spell it out in case we were called from 'settings'
  end

  # settings are the same as edit, except we force the person to be the current_person
  def settings
    logger.debug("PeopleController.settings: params: #{params.inspect}, @current_person: #{@current_person.inspect}")
    @person = current_person
    edit
  end

  # 'home' is a control panel type thing
  def home
    # we force the current @person to be the current_person
    @person = current_person
    @title = @person.name
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
  def update
    ## correct_person finds the appropriate person
    ## @person = Person.find(params[:id])
    if @person.update_attributes(person_params)
      ## logger.debug("QQ: PeopleController.update: success");
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
  end

  def found
    @people = search_q(Person)
  end

  def oauth
    teapot_q
  end

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

end
