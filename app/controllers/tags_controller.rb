class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.all
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
  end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(tag_params)
    create_q(@tag)
  end

  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
    update_q(@tag, tag_params)
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    destroy_q(@tag, tags_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:tag_type, :tagable_id, :tagable_type)
    end
end
