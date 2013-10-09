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
    logger.debug("CC: TalkController.new")
    @talk = Talk.new
  end

  # GET /talks/1/edit
  def edit
  end

  # POST /talks
  # POST /talks.json
  def create
    @talk = current_person.talks.build(talk_params)
    if @talk.save
      flash[:success] = "Talk Started"
      redirect_to home_url
    else
      @feed_talks = []
      render 'people/home'
    end
  end

  # PATCH/PUT /talks/1
  # PATCH/PUT /talks/1.json
  ## what is correct handling of update of current talk? -- use logger.debug to find
  def update
    ## the format stuff is likely to fail
    ## format stuff seems to work here but not in 'people'
    respond_to do |format|
      if @talk.update(talk_params)
        format.html { redirect_to @talk, notice: 'Talk was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: :edit }
        format.json { render json: @talk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /talks/1
  # DELETE /talks/1.json
  def destroy
    @talk.destroy
    redirect_to root_url
  end

  def search
    ## logger.debug("CC: TalksController.search")
  end

  # start is the default starting point for the entire website
  def start
    logger.debug("CC: TalksController.start")
    if signed_in?
      @talks = Talk.talks_by_person( current_person )
      render 'my_talks' and return
    else 
      @talks = Talk.hot_talks
      render 'gottalk' and return
    end
  end

  def gottalk
    logger.debug("CC: TalksController.gottalk")
    @talks = Talk.hot_talks
  end

  ## specialized search-y tasks:

  def my_talks
    logger.debug("CC: TalksController.my_talks")
    ## can probably consolidate once we have debugged
    if signed_in?
      person = current_person
      @talks = Talk.talks_by_person(person)
    else
      @talks = Talk.hot_talks
    end
    @talks
  end

  def found
    @talks = search_q(Talk)
  end

  def recent
    @talks = Talk.recent(page: params[:page])
    logger.debug("CC: TalksController.recent: @talks: #{@talks.inspect}")
    @talks
  end

  def hot_talks
    @talks = Talk.recent(page: params[:page])
  end

  def nearby
    @talks = Talk.nearby(page: params[:page])
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
