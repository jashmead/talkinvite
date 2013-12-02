# FAQs Controller
#
# only admins can add faqs?
#
class FaqsController < ApplicationController
  before_action :set_faq, only: [:show, :edit, :update, :destroy ]

  def search_fields
    [ 'question', 'answer' ]
  end

  def feet_center
    feet_for_help_pages
  end

  # GET /faqs
  # GET /faqs.json
  def index
    super
    @faqs = Faq.all
    logger.debug("FaqsController.index: @faqs: #{@faqs.inspect}")
  end

  # GET /faqs/1
  # GET /faqs/1.json
  def show
  end

  # GET /faqs/new
  def new
    @faq = Faq.new
  end

  # GET /faqs/1/edit
  def edit
    # logger.debug("FaqsController.edit: session: #{session.inspect}  return_to: #{session[:return_to].inspect}")
  end

  # POST /faqs
  # POST /faqs.json
  def create
    # logger.debug("FaqsController.create: session: #{session.inspect}  return_to: #{session[:return_to].inspect}")
    @faq = Faq.new(faq_params)
    create_q(@faq)
  end

  # PATCH/PUT /faqs/1
  # PATCH/PUT /faqs/1.json
  def update
    # logger.debug("FaqsController.update: session: #{session.inspect}  return_to: #{session[:return_to].inspect}")
    update_q(@faq, faq_params)
  end

  # DELETE /faqs/1
  # DELETE /faqs/1.json
  def destroy
    destroy_q(@faq, faqs_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_faq
      @faq = Faq.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def faq_params
      params.require(:faq).permit(:question, :answer)
    end
end
