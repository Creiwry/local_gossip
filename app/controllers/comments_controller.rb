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
    @gossip = Gossip.find(params[:gossip_id])
  end

  def update
    @comment = Comment.find(params[:id])
    @gossip = Gossip.find(params[:gossip_id])
    if @comment.update(content: params[:comment][:content])
      flash[:notice] = 'Comment update successful'
      redirect_to gossip_path(@gossip.id)
    else
      flash[:alert] = 'Comment update failed'
      render :edit
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
