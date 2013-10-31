##  add accept/decline/maybe operations here, calling on the model functions with the same names
##  add admin/unadmin operations here, calling on the model functions with the same names
##  expect these will be using ajax in final design

class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  # at some point, may return member_type? a comment?
  def search_fields
    []
  end

  # GET /members
  # GET /members.json
  def index
    @members = Member.all
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)
    create_q(@member)
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    update_q(@member, member_params)
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    destroy_q(@member, members_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:talk_id, :person_id, :rsvp_status, :member_type)
    end
end
