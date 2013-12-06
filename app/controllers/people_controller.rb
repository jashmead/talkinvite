# People Controller
# 
# 2nd most important controller
#
# TBD:  add in separate change password form

# note:  inheriting from Devise::RegistrationController opened up can-of-worms
# class PeopleController < Devise::RegistrationsController
class PeopleController < ApplicationController

  # edit, update & home are only available to the 'correct_person': logged in as the person being profiled, set, or home'd

  # the 'set_person' commands are expecting an 'id' in the params
  before_action :set_person, only: [:show, :edit, :update, :destroy ] 
  before_action :authenticate_person!, only: [:edit, :update, :destroy, :home, :change_password]

  ## removed index (& therefore search) from list of routes that require you to be signed in; 
  ##    -- no, this caused additional failures
  ##    -- need deeper understanding before we can continue
  ##    -- put :index back in for now

  # do not need correct_person for home because it reroutes *to* the correct_person
  before_action :correct_person, only: [:edit, :update]

  # most a regular person can do is inactivate
  before_action :admin_person, only: [:destroy]

  # TBD:  add in the new fields, as url
  def search_fields
    [ 'name', 'email', 'description' ]
  end

  def feet_center
    if person_signed_in?
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
      # logger.debug("PeopleController.show: no person found for id# #{params[:id]}")
      flash.now[:alert] = "There isn't any person# " + :id.to_s
      render :search and return
    end
    # logger.debug("PeopleController.show: @person: #{@person.inspect}")
    @title = @person.name.titlecase
    @data_role = 'dialog' if @person != current_person
    if @person == current_person 
      flash[:notice] = "This is what others see when they click on your name"
    end
  end

  # GET /people/new
  def new
    ## logger.debug("PeopleController.new")
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
    logger.debug("PeopleController.edit: params: #{params.inspect}, @current_person: #{@current_person.inspect}")
    # note: don't need to look for person here; done in 'before_action' callback by set_person
    if @person != current_person
      render 'show' and return
    end
  end

  # 'home' is a control panel type thing
  # TBD:  add talks box, eliminate update fields
  def home
    # TBD:  replace sitemap with my messages, once we are there
    logger.debug("PeopleController.home: current_person: #{current_person.inspect}")
    store_location  # so if we click on something we'll come back here:  it is home, after all!
    @person = current_person
    @talks = Talk.talks_by_person(@person)
    @title = @person.name.titlecase
  end

  # POST /people
  # POST /people.json
  def create
    logger.debug("PeopleController.create: person_params: #{person_params.inspect}")

    @person = Person.new(person_params)
    logger.debug("PeopleController.create: @person: #{@person.inspect}")

    respond_to do |format|
      if @person.save 
        # TBD:  setup specs for this:  or we will be adding to our 'technical debt'!
        Notifier.notice(@person, 'new account').deliver
        format.html do
          sign_in @person
          flash[:success] = "Welcome to Talk Invite!"
          redirect_to @person
        end
        format.json { render json: @person, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  # update should be called by edit
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

  # 'found' called on successful search
  # TBD:  fold found, search, index in together?
  def found
    logger.debug("PeopleController.found")
    # TBD:  add in a title of the form N people found?
    @people = search_q(Person)
  end

  # oauth is placeholder for work on twitter authorization
  def oauth
    teapot_q
  end

  # people can have a location associated with them so get a map as well
  # 'map' is placeholder for map work
  def map
    @person = Person.find(params[:id])
    map_q(@person, params)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      ## with 'find', ActiveRecord will raise an exception if the record is not found
      begin
        @person = Person.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # Here we allow only password & password_confirmation, but not the true field, password_digest!
    # We also do *not* allow admin or sub flags to be set from here
    def person_params
      # params whitelist does *not* include admin, sub, remember_token
      # TBD:  share this whitelist with the list used by configuration_permitted_parameters
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
      redirect_to(root_url) unless current_person == @person
    end

    def admin_person
      redirect_to(root_url) unless current_person.admin?
    end

end
