# Help controller

# massively parallel to credis
#
# TBD: on the footer, do we want to use the helps? or stick with about, contact, & privacy?

class HelpsController < ApplicationController
  before_action :set_help, only: [:show, :edit, :update, :destroy]

  # GET /helps
  # GET /helps.json
  def index
    super
    @helps = Help.all
  end

  # GET /helps/1
  # GET /helps/1.json
  def show
  end

  # GET /helps/new
  def new
    @help = Help.new
  end

  def feet_center
    feet_for_help_pages
  end

  # NOTE:  don't use 'help_params' or similar on 'get', as no ':help' param will be defined!
  def help
    # logger.debug("HelpsController.help: params: #{params.inspect}")
    # logger.debug("HelpsController.help: admin? #{admin?.inspect}")
    @help = Help.where('name = ?', params[:name]).first
    if ! @help 
      if admin?
        # then give the admin a change to create the help
        @help = Help.new( name: params[:name], title: params[:name], description: "Help for page " + params[:name], help_type: "page" )
        render 'new' and return
      end
      render 'index' and return
    end
    if admin?
      render 'edit' and return
    end
    render 'show' and return
  end

  # GET /helps/1/edit
  def edit
  end

  # POST /helps
  # POST /helps.json
  def create
    @help = Help.new(help_params)
    create_q(@help)
  end

  # PATCH/PUT /helps/1
  # PATCH/PUT /helps/1.json
  def update
    update_q(@help, help_params)
  end

  # DELETE /helps/1
  # DELETE /helps/1.json
  def destroy
    logger.debug("HelpsController.destroy")
    destroy_q(@help, helps_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_help
      @help = Help.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def help_params
      logger.debug("HelpsController.help_params: params: #{params.inspect}")
      params.require(:help).permit(:name, :title, :description, :help_type)
    end
end
