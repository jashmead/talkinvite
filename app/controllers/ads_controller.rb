class AdsController < ApplicationController
  before_action :set_ad, only: [:show, :edit, :update, :destroy]

  # GET /ads
  # GET /ads.json
  def index
    @ads = Ad.all
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
  end

  # GET /ads/new
  def new
    @ad = Ad.new
  end

  # GET /ads/1/edit
  def edit
  end

  # POST /ads
  # POST /ads.json
  def create
    @ad = Ad.new(ad_params)
    create_q(@ad)
  end

  # PATCH/PUT /ads/1
  # PATCH/PUT /ads/1.json
  def update
    update_q(@ad, ad_params)
  end

  # DELETE /ads/1
  # DELETE /ads/1.json
  def destroy
    destroy_q(@ad, ads_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad
      @ad = Ad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_params
      params.require(:ad).permit(:name, :description, :internal_flag, :content, :source, :strategy, :stats)
    end
end
