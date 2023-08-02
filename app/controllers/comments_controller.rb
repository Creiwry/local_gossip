class CommentsController < ApplicationController

  def create
    gossip = Gossip.find(params[:comment][:gossip_id])
    @comment = Comment.new(
      commentable: gossip,
      user: User.all.sample,
      content: params[:comment][:content]
    )
    if @comment.save
      flash[:notice] = 'Comment creation successful'
    else
      flash[:alert] = 'Failed to create comment'
    end
    redirect_to gossip_path(gossip.id)
  end

  def edit
    @comment = Comment.find(params[:id])
  end
end
