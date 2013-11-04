class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_person, only: [:new, :create, :edit, :update, :destroy]

  def search_fields
    [ 'message_text' ]
  end

  # GET /messages
  # GET /messages.json
  def index
    super
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    create_q(@message)
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    update_q(@message, message_params)
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    destroy_q(@message, messages_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:sender_id, :receiver_id, :message_type, :message_text)
    end
end
