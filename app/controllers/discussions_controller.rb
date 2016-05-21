class DiscussionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @discussions = Discussion.topics
  end

  def show
    @discussion = find_visible_discussion(params[:id])
    @answer = Discussion.new(parent_id: @discussion)
  end

  def new
    @discussion = Discussion.new( user: current_user )
  end

  def create_answer

    @discussion = find_visible_discussion(params[:id])
    if @answer = Discussion.create_answer(discussion_params[:body], current_user, @discussion.id)
      redirect_to @discussion
    else
      render 'show'
    end

  end

  def create
    if @discussion = Discussion.create_thread(discussion_params[:title], current_user)
      Discussion.create_answer(discussion_params[:body], current_user, @discussion.id)
      redirect_to @discussion
    else
      render 'new'
    end
  end

  private

  def find_visible_discussion(id)
    Discussion.where(hidden: false).find(id)
  end
  def discussion_params
    params.require(:discussion).permit(:title, :body)
  end

end
