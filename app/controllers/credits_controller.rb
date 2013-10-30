class CreditsController < ApplicationController
  before_action :set_credit, only: [:show, :edit, :update, :destroy]

  # GET /credits
  # GET /credits.json
  def index
    @credits = Credit.all
    ## logger.debug("CreditsController.index: @credits: #{@credits.inspect}")
    @credits
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
    # get the tags & the attachments, using the association
  end

  # POST /credits
  # POST /credits.json
  def create
    @credit = Credit.new(credit_params)
    # what follows hacked over from create_q; fold back in once we have a handle on flow
    respond_to do |format|
      if @credit.save
        # once # of credits fills more than one page, be careful to position on the credit we just saved
        @credits = Credit.all
        format.html { 
          render 'index', 
          notice: @credit.name + ' thanked!'
        }
        format.json { render action: 'show', status: :created, location: @credit }
      else
        fail_q(@credit, format, 'new')
      end
    end
  end

  # PATCH/PUT /credits/1
  # PATCH/PUT /credits/1.json
  def update
    # what follows hacked over from update_q; fold back in once we have a handle on flow
    respond_to do |format|
      if @credit.update(credit_params)
        @credits = Credit.all
        format.html { 
          render 'index',
          notice: @credit.name + ' rethanked!'
        }
        format.json { head :no_content }
      else
        fail_q(@credit, format, 'edit')
      end
    end
  end

  # DELETE /credits/1
  # DELETE /credits/1.json
  def destroy
    destroy_q(@credit, Credit)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credit
      @credit = Credit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def credit_params
      params.require(:credit).permit(:name, :description)
    end
end
