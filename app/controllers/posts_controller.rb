# Posts
#
# change talk status & post messages

class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    super
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    # TBD: '@talk'?
    @post = Post.new
    logger.debug("PostsController.new: current_person: #{current_person}")
    @originator_person = current_person
  end

  # GET /posts/1/edit
  def edit
    # TBD:  only the author can edit!
  end

  # POST /posts
  # POST /posts.json
  def create
    # TBD:  do we need to set person_id explicitly?
    @post = Post.new(post_params)
    create_q(@post)
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    # TBD:  only the author can edit!
    update_q(@post, post_params)
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  # TBD:  is 'destroy_q' the right way to destory a post?
  def destroy
    destroy_q(@post, posts_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
      @talk = @post.talk
      @originator_person = @post.person
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:person_id, :talk_id, :service_type, :service_notes, :post_type, :post_message)
    end
end
