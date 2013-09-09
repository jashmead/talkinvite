##  will be adding actions:  signin, signout, settings
##  will be adding profile_picture
##  will be adding home_location (in settings, a JSON field)
##  will be adding current_location (in session on server, at this point)
##  will be adding checks on destroy
##  'format' bits are needed; how do they work? -- commented out for now...

class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_person, only: [:edit, :update, :index, :destroy]
  before_action :correct_person, only: [:edit, :update]
  before_action :admin_person, only: [:destroy]

  # GET /people
  # GET /people.json
  def index
    @people = Person.paginate(page: params[:page])
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @person = Person.find(params[:id])
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

    logger.debug "PeopleController.create: person #{@person.attributes.inspect}"  # DDT

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
      flash[:success] = "Profile updated"
      sign_in @person     # why needed?
      redirect_to @person
    else
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
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
        :password_confirmation,
        :screen_name, 
        :about_me, 
        :settings
    )
    end

    def signed_in_person
      unless signed_in?
        ## store location defined in sessions_helper.rb
        store_location
        redirect_to signin_url, notice:  'Please sign in.' 
      end
    end

    def correct_person
      @person = Person.find(params[:id])
      ## what is ontological status of 'current_person'?
      redirect_to(root_url) unless current_person?(@person)
    end

    def admin_person
      redirect_to(root_url) unless current_person.admin?
    end

    ## expect we will have a def subscriber here at some point
end
