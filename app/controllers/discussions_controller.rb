class DiscussionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @discussions = Discussion.topics
    if @discussions.length == 0
      render :empty_index
    else
      render :index
    end
  end


  def show
    @discussion = find_visible_discussion(params[:id])
    @reply = Discussion.new(parent_id: @discussion)
  end

  def new
    @discussion = Discussion.new( user: current_user )
  end

  def reply
    @discussion = find_visible_discussion(params[:id])
    if @reply = Discussion.create_reply(discussion_params[:body], current_user, @discussion.id)
      redirect_to @discussion
    else
      render 'show'
    end
  end

  def create
    if @discussion = Discussion.create_thread(discussion_params[:title], current_user)
      Discussion.create_reply(discussion_params[:body], current_user, @discussion.id)
      redirect_to @discussion
    else
      render 'new'
    end
  end

  def update_reply
    @discussion = find_visible_discussion(params[:id])
    if @discussion && @reply = find_visible_discussion(params[:reply_id], current_user)
      if @reply.update(body: discussion_params[:body])
        redirect_to @discussion
      else
        render 'edit_reply'
      end
    else
      render 'edit_reply'
    end
  end

  def edit_reply
    puts "  edit_reply() #{params.inspect}"
    @discussion = find_visible_discussion(params[:id])
    if @discussion && @reply = find_visible_discussion(params[:reply_id], current_user)
      render 'edit_reply'
    else
      redirect_to @discussion
    end
  end

  private

  def find_visible_discussion(id, user = nil)
    if user
      Discussion.where(hidden:false, user: user).find(id)
    else
      Discussion.where(hidden: false).find(id)
    end
  end
  def discussion_params
    params.require(:discussion).permit(:title, :body)
  end

end
