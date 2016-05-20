class DiscussionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @discussions = Discussion.topics
  end

  def show
    @discussion = Discussion.where(id: params[:id], hidden: false)
  end

end
