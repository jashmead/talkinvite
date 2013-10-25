## only admins can add faqs?
## they double as help text; we'll see how that evolves
class FaqsController < ApplicationController
  before_action :set_faq, only: [:show, :edit, :update, :destroy, :help]

  def search_fields
    [ 'question', 'answer' ]
  end

  # GET /faqs
  # GET /faqs.json
  def index
    @faqs = Faq.all
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
  end

  # POST /faqs
  # POST /faqs.json
  def create
    @faq = Faq.new(faq_params)
    create_q(@faq)
  end

  # PATCH/PUT /faqs/1
  # PATCH/PUT /faqs/1.json
  def update
    update_q(@faq, faq_params)
  end

  # DELETE /faqs/1
  # DELETE /faqs/1.json
  def destroy
    @faq.destroy
    destroy_q(@faq, faqs_url)
  end

  def helps
    # could use a 'help_flag' to be a bit less ad-hoc
    @helps = Faq.where("faq_type = ?", 'help')
  end

  def help 
    @help = Faq.where("id = ? and faq_type = ?", params[:id], 'help')
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
