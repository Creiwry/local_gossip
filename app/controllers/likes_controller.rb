class LikesController < ApplicationController
  before_action :authenticate_user
  before_action :set_likeable, only: [:create]

  def create
    @like = @likeable.likes.new(user: current_user)
    flash[:alert] = error_string(@like) unless @like.save
    redirect_to gossip_path(root_gossip_id(@like))
  end

  def destroy
    @like = Like.find(params[:id])

    flash[:alert] = error_string(@like) unless @like.destroy

    redirect_to gossip_path(root_gossip_id(@like))
  end

  private

  def root_gossip_id(like)
    like.likeable.instance_of?(Gossip) ? like.likeable.id : like.likeable.commentable.id
  end

  def set_likeable
    @likeable = params[:likeable].classify.constantize.find(params[:like][:likeable_id])
  end
end
