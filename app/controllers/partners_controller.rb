# Partners Controller
# 
##  TBD: add accept/decline/maybe operations here, calling on the model functions with the same names
##  TBD: add admin/unadmin operations here, calling on the model functions with the same names
##    -- expect these will be using ajax in final design

class PartnersController < ApplicationController
  before_action :set_partner, only: [:show, :edit, :update, :destroy]

  # TBD:  add in searches on partnership type, status, name of person, ...
  def search_fields
    []
  end

  # GET /partners
  # GET /partners.json
  def index
    super
    @partners = Partner.all
  end

  # GET /partners/1
  # GET /partners/1.json
  def show
  end

  # GET /partners/new
  def new
    @partner = Partner.new
  end

  # GET /partners/1/edit
  def edit
  end

  # POST /partners
  # POST /partners.json
  def create
    @partner = Partner.new(partner_params)
    create_q(@partner)
  end

  # PATCH/PUT /partners/1
  # PATCH/PUT /partners/1.json
  def update
    update_q(@partner, partner_params)
  end

  # DELETE /partners/1
  # DELETE /partners/1.json
  # destroy for partners like destroy for services, may need to be specialized
  def destroy
    destroy_q(@partner, partners_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_partner
      @partner = Partner.find(params[:id])
      @talk = @partner.talk
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def partner_params
      params.require(:partner).permit(:talk_id, :person_id, :rsvp_status, :partner_type)
    end
end
