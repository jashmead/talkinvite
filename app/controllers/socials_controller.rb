class SocialsController < ApplicationController
  before_action :set_social, only: [:show, :edit, :update, :destroy]

  # GET /socials
  # GET /socials.json
  def index
    @socials = Social.all
  end

  # GET /socials/1
  # GET /socials/1.json
  def show
  end

  # GET /socials/new
  def new
    @social = Social.new
  end

  # GET /socials/1/edit
  def edit
  end

  # POST /socials
  # POST /socials.json
  def create
    @social = Social.new(social_params)
    create_q(@social)
  end

  # PATCH/PUT /socials/1
  # PATCH/PUT /socials/1.json
  def update
    update_q(@social, social_params)
  end

  # DELETE /socials/1
  # DELETE /socials/1.json
  def destroy
    destroy_q(@social, socials_url)
  end

  def invite
  end

  def tweet
  end

  def faceit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_social
      @social = Social.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def social_params
      params.require(:social).permit(:person_id, :talk_id, :social_type, :social_text)
    end
end
