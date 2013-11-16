# Comments Controller
#
# index is always nested
#
## all that we can really do with comments are add them, delete if owner (or admin), edit if owner (or admin?)
class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def search_fields
    [ 'comment_text' ]
  end

  # GET /comments
  # GET /comments.json
  def index
    super
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    create_q(@comment)
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    update_q(@comment, comment_params)
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    destroy_q(@comment, comments_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
      current_talk = @comment.talk
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:person_id, :talk_id, :comment_text)
    end
end
