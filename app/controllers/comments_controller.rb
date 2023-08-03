class CommentsController < ApplicationController
  before_action :authenticate_user

  def create
    gossip = Gossip.find(params[:comment][:gossip_id])
    @comment = Comment.new(
      commentable: gossip,
      user: current_user,
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
    @gossip = Gossip.find(params[:gossip_id])
  end

  def update
    @comment = Comment.find(params[:id])
    @gossip = Gossip.find(params[:gossip_id])
    if check_if_current_user(@comment.user) && @comment.update(content: params[:comment][:content])
      flash[:notice] = 'Comment update successful'
      redirect_to gossip_path(@gossip.id)
    else
      flash[:alert] = 'Comment update failed'
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if check_if_current_user(@comment.user) && @comment.destroy
      flash[:notice] = 'Comment deleted successfully'
    else
      flash[:alert] = 'Failed to delete comment'
    end
    redirect_to gossip_path(params[:gossip_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
