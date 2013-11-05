##  will be adding actions:  signin, signout, settings
##  will be adding profile_picture
##  will be adding current_location (in session on server, at this point)
##  will be adding checks on destroy:  you have to be signed in, an admin, & not deleting yourself
##  'format' bits are needed; how do they work? -- commented out for now...
##  params[:page] defaults to nil, presumably a way to override the default page

class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  ## removed index (& therefore search) from list of routes that require you to be signed in; 
  ##    no this cause additional failures
  ##    need deeper understanding before we can continue
  ##    put :index back in for now
  before_action :signed_in_person, only: [:index, :edit, :settings, :home, :update, :destroy ]
  before_action :correct_person, only: [:edit, :update]
  before_action :admin_person, only: [:destroy]

  def search_fields
    [ 'name', 'email' ]
  end

  # TBD: switch on admin flag to an admin menu?
  def feet_center
    if signed_in?
      [ '/talks/new', '/talks/my_talks', '/talks/search' ]
    else
      [ '/talks/new', '/talks/active', '/talks/search' ]
    end
  end

  # GET /people
  # GET /people.json
  def index
    super
    logger.debug("CC: PeopleController.index: params: '#{params.inspect}'")
    @title = "List of People"
    @people = Person.all(params[:search]).paginate(page: params[:page])
  end

  # GET /people/1
  # GET /people/1.json
  def show
    # don't need to look for person here; done in 'before_action' callback by set_person
    if ! @person 
      ## logger.debug("CC: PeopleController.show: no person found for id# #{params[:id]}")
      flash.now[:alert] = "There isn't any person# " + :id.to_s
      render :search and return
    end
    @talks = @person.talks.paginate(page: params[:page])
  end

  # GET /people/new
  def new
    ## logger.debug("PeopleController.new")
    @person = Person.new
  end

  # GET /people/1/edit
  # 'settings' is almost a synonym for 'edit', except that the person is forced to be the signed in person
  def edit
    logger.debug("PeopleController.edit: params: #{params.inspect}, @current_person: #{@current_person.inspect}")
    # don't need to look for person here; done in 'before_action' callback by set_person
  end

  def settings
    logger.debug("PeopleController.settings: params: #{params.inspect}, @current_person: #{@current_person.inspect}")
    @person = current_person
  end

  # 'home' is a control panel type thing
  def home
    # we should already have checked that we are signed in!
    @person = current_person
    fetch_children
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

  def upgrade
    # return to upgrade on failure, to settings on success
  end

  # DELETE /people/1
  # DELETE /people/1.json
  # commenting out the respond_to bit causes tests to fail with a missing template error.  Hunh?
  # TBD: destroy is not using 'destroy_q' at this point.  Should it? probably not
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
        ## logger.debug("PeopleController.set_person: params: #{params.inspect}")
        @person = Person.new
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # Here we allow only password & password_confirmation, but not the true field, password_digest!
    # We also do *not* allow admin or sub flags to be set from here
    def person_params
      params.require(:person).permit(
        :name, 
        :email, 
        :password, 
        :password_confirmation
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

    # fetch_children likely to be slow; may want to break it down, once it is working
    # TBD:  how do we save these back? there must be a tool!
    # TBD:  how do we fetch all the records for an association?
    def fetch_children
=begin
      @my_talks = @person.talks # talks we've created

      @comments = @person.comments
      @posts = @person.posts

      @sent_messages = @person.sent_messages
      @received_messages = @person.received_messages

      @talks = @person.memberships
=end
    end

    # person has no parents, so no fetch_parents

end
