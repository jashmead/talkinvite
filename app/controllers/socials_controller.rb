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

    respond_to do |format|
      if @social.save
        format.html { redirect_to @social, notice: 'Social was successfully created.' }
        format.json { render action: 'show', status: :created, location: @social }
      else
        format.html { render action: 'new' }
        format.json { render json: @social.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /socials/1
  # PATCH/PUT /socials/1.json
  def update
    respond_to do |format|
      if @social.update(social_params)
        format.html { redirect_to @social, notice: 'Social was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @social.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /socials/1
  # DELETE /socials/1.json
  def destroy
    @social.destroy
    respond_to do |format|
      format.html { redirect_to socials_url }
      format.json { head :no_content }
    end
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
