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
  before_action :signed_in_person, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_person, only: [:edit, :update]
  before_action :admin_person, only: [:destroy]

  def search_fields
    [ 'name', 'email' ]
  end

  # GET /people
  # GET /people.json
  def index
    # logger.debug("CC: PeopleController.index: params: '#{params.inspect}'")
    @people = Person.all(params[:search]).paginate(page: params[:page])
  end

  # GET /people/1
  # GET /people/1.json
  def show
    # don't need to look for person here; done in 'before_action' callback by set_person
    if ! @person 
      logger.debug("CC: PeopleController.show: no person found for id# #{params[:id]}")
      flash.now[:alert] = "There isn't any person# " + :id.to_s
      render :search and return
    end
    @talks = @person.talks.paginate(page: params[:page])
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
    # don't need to look for person here; done in 'before_action' callback by set_person
  end

  # POST /people
  # POST /people.json
  def create
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
  def destroy
    ## note use of method chaining to combine find & destroy into one line
    Person.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :no_content }
    end
  end

  ## codeclimate complained about duplication in following & followers, so sweated it out to follow_common
  def following
    follow_common('Following', 'followed_people')
  end

  def followers
    follow_common('Followers', 'followers')
  end

  def follow_common(title, follow_method) 
    @title = title
    @person = Person.find(params[:id])
    @people = @person.send(follow_method).paginate(page: params[:page])

    render :show_follow
  end

  def search
  end

  def found
    @people = search_q(Person)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      ## ActiveRecord will raise an exception if the record is not found
      @person = Person.find(params[:id])
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

    def correct_person
      @person = Person.find(params[:id])
      ## what is ontological status of 'current_person'?
      redirect_to(root_url) unless current_person?(@person)
    end

    def admin_person
      redirect_to(root_url) unless current_person.admin?
    end

    def subscriber
      redirect_to(root_url) unless current_person.sub? || current_person.admin?
    end

    ## expect we will have a def subscriber here at some point
end
