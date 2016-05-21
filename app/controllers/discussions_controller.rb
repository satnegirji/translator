class DiscussionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @discussions = Discussion.topics
  end

  def show
    @discussion = Discussion.where(hidden: false).find(params[:id])
  end

  def new
    @discussion = Discussion.new( user: current_user )
  end


  def create
    params = discussion_params
    if @discussion = Discussion.create_thread(params[:title], current_user)
      Discussion.create_answer(params[:body], current_user, @discussion.id)
      redirect_to @discussion
    else
      render 'new'
    end

  end

  private

  def discussion_params
    params.require(:discussion).permit(:title, :body)
  end

end
