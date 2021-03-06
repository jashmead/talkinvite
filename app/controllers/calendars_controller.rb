# Calendars Controller
#
# may need to use multiple source for calendars, i.e. google, yahoo, open street calendar
#
# default set of resources overrich
class CalendarsController < ApplicationController
  before_action :set_calendar, only: [:show, :edit, :update, :destroy]

  # GET /calendars
  # GET /calendars.json
  def index
    super
    @calendars = Calendar.all
  end

  # GET /calendars/1
  # GET /calendars/1.json
  def show
  end

  # GET /calendars/new
  def new
    @calendar = Calendar.new
  end

  # GET /calendars/1/edit
  def edit
  end

  # POST /calendars
  # POST /calendars.json
  def create
    @calendar = Calendar.new(calendar_params)
    create_q(@calendar)
  end

  # PATCH/PUT /calendars/1
  # PATCH/PUT /calendars/1.json
  def update
    update_q(@calendar, calendar_params)
  end

  # DELETE /calendars/1
  # DELETE /calendars/1.json
  def destroy
    destroy_q(@calendar, calendars_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar
      @calendar = Calendar.find(params[:id])
      @talk = @calendar.talk
      @person = @calendar.person
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def calendar_params
      params.require(:calendar).permit(:person_id, :talk_id, :name, :description, :scale)
    end
end
