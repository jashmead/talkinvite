##  will be adding actions:  signin, signout, settings
##  will be adding profile_picture
##  will be adding home_location (in settings, a JSON field)
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

  # GET /people
  # GET /people.json
  def index
    # @people = Person.all
    ## logger.debug("CC: PeopleController.index: current_person: #{current_person}") #DDT
    ## logger.debug("CC: PeopleController.index: @people: #{@people.inspect}")#DDT
    ## @people = Person.paginate(page: params[:page])
    ## will paginate play nicely with ransack?
    ## backing out 'ransack', too much weirdness
    ## @q = Person.search(params[:q])
    ## @people = @q.result(distinct: true).paginate(page: params[:page])
    ## logger.debug("CC: PeopleController.index: @people: #{@people.inspect}")#DDT
    logger.debug("CC: PeopleController.index: params: '#{params.inspect}'")
    @people = Person.search(params[:search]).paginate(page: params[:page])
  end

  # GET /people/1
  # GET /people/1.json
  def show
    # don't need to look for person here, because done in 'before_action' callback by set_person
    # @person = Person.find(params[:id])
    if ! @person 
      logger.debug("CC: PeopleController.show: no person found for id# #{params[:id]}")
      flash.now[:alert] = "There isn't any person# " + :id.to_s
      render 'search' and return
    end
    @talks = @person.talks.paginate(page: params[:page])
  ##  logger.debug("PeopleController#show: params[:page]: #{params[:page].inspect}")#DDT
  ##  logger.debug("PeopleController#show: @talks: #{@talks.inspect}") #DDT
  ##  logger.debug("PeopleController: Faker: methods: #{Faker.methods.inspect}") #DDT
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
    ## correct_person finds the appropriate person
    ## @person = Person.find(params[:id])
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)

  ##  logger.debug "PeopleController.create: person #{@person.attributes.inspect}"  # DDT

=begin
    respond_to do |format|
      if @person.save
        # format.html { redirect_to @person, notice: 'Person was successfully created.' }
        # format.json { render action: 'show', status: :created, location: @person }
      else
        # format.html { render action: 'new' }
        # format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
=end

    if @person.save 
      sign_in @person
      flash[:success] = "Welcome to Talk Invite!"
      redirect_to @person
    else
      render 'new'
    end

  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update

  ## logger.debug("QQ: PeopleController.update: @person: #{@person.inspect}")
=begin
    respond_to do |format|
      if @person.update(person_params)
        # notice use of notice!
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
=end

    ## correct_person finds the appropriate person
    ## @person = Person.find(params[:id])
    if @person.update_attributes(person_params)
      ## logger.debug("QQ: PeopleController.update: success");
      flash[:success] = "Profile updated"
      sign_in @person     # why needed?
      redirect_to @person
    else
      ## logger.debug("QQ: PeopleController.update: failure");
      render 'edit'
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
    @person = Person.find(params[:id])
    follow_common('Following', @person, @person.followed_people.paginate(page: params[:page]))
  end

  def followers
    @person = Person.find(params[:id])
    follow_common('Followers', @person, @person.followers.paginate(page: params[:page]))
  end

  def follow_common( title, person, people )
    logger.debug("QQ: title: #{title}, person: #{person}, people: #{people.inspect}") #DDT

    @title = title
    @person = person
    @people = people.paginate(page: params[:page])

    render 'show_follow'
  end

  def search
    ## logger.debug("CC: PeopleController.search")
  end

  ## may be able to DRY found using pluralize and related tools
  ## can we put shared code in ./concerns?
  def found
    logger.debug("CC: PeopleController.found: params: #{params.inspect}")

    q = params['search']['q']
    q.strip! if q
    if ! q || q == ''
      flash.now[:error] = "Please specify something to search for."
      render :search and return
    end
      
    @people = Person.search(q)
    if ! @people || @people.size == 0
      flash.now[:error] = "No matching people found for search '#{q}'.  Please try again."
      # redirect_to :back # this will kill the flash message, so is no good
      render :search and return
    end

    ## render found ## apparently 'render found' creates an infinite stack; why? try: render 'found' instead?
    ## 'pluralize' not available in controller-space
    if @people.size == 1
      flash.now[:success] = "Found one matching person."
    else 
      flash.now[:success] = "Found " + @people.size.to_s + " matching people."
    end
    @people = @people.paginate(page: params[:page])
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
