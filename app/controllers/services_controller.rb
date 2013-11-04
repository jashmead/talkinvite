# TBD: Services don't really have a lot of actions associated with them; thin their controller out at some point
class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]

  # GET /services
  # GET /services.json
  def index
    super
    @services = Service.all
  end

  # GET /services/1
  # GET /services/1.json
  def show
  end

  # GET /services/new
  def new
    @service = Service.new
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(service_params)
    create_q(@service)
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    update_q(@service, service_params)
  end

  # DELETE /services/1
  # DELETE /services/1.json
  # since services, like members, never really seen on their own, this may not be correct
  def destroy
    # TBD: should not let a person destroy the 'talkinvite' service
    #destroy_q(@service, services_url) if @service.service_type != 'talkinvite'
    destroy_q(@service, services_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:person_id, :service_type, :service_notes)
    end
end
