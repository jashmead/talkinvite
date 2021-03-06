# Credits Controller
#
# only admins can add credits?
#
# massively parallel to credis

class CreditsController < ApplicationController
  before_action :set_credit, only: [:show, :edit, :update, :destroy]

  def feet_center
    feet_for_help_pages
  end

  # GET /credits
  # GET /credits.json
  def index
    super
    @credits = Credit.all
    logger.debug("CreditsController.index: @credits: #{@credits.inspect}")
  end

  # GET /credits/1
  # GET /credits/1.json
  def show
  end

  # GET /credits/new
  def new
    @credit = Credit.new
  end

  # GET /credits/1/edit
  def edit
  end

  # POST /credits
  # POST /credits.json
  def create
    @credit = Credit.new(credit_params)
    # logger.debug("CreditsController.create: credit_params: #{credit_params.inspect}, @credit: #{@credit.inspect}")
    create_q(@credit)
  end

  # PATCH/PUT /credits/1
  # PATCH/PUT /credits/1.json
  def update
    update_q(@credit, credit_params)
  end

  # DELETE /credits/1
  # DELETE /credits/1.json
  def destroy
    destroy_q(@credit, credits_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credit
      @credit = Credit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def credit_params
      params.require(:credit).permit(:name, :description, :url)
    end
end
