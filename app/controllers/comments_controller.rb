class CommentsController < ApplicationController
  before_action :authenticate_user
  before_action :set_commentable, only: [:create]

  def create
    @comment = Comment.new(
      commentable: @commentable,
      user: current_user,
      content: params[:comment][:content]
    )
    if @comment.save
      flash[:notice] = 'Comment creation successful'
    else
      flash.now[:alert] = error_string(@comment)
    end
    redirect_to gossip_path(root_gossip_id(@comment))
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if check_if_current_user(@comment.user) && @comment.update(content: params[:comment][:content])
      flash[:notice] = 'Comment update successful'
      redirect_to gossip_path(root_gossip_id(@comment))
    else
      flash.now[:alert] = error_string(@comment)
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    root_gossip_id = root_gossip_id(@comment)
    if check_if_current_user(@comment.user) && @comment.destroy
      flash[:notice] = 'Comment deleted successfully'
    else
      flash.now[:alert] = error_string(@comment)
    end
    redirect_to gossip_path(root_gossip_id)
  end

  private

  def set_commentable
    if params.key?(:gossip_id)
      @commentable = Gossip.find(params[:gossip_id])
    else
      @commentable = Comment.find(params[:comment_id])
    end
  end

  def root_gossip_id(comment)
    comment.commentable.instance_of?(Gossip) ? comment.commentable.id : comment.commentable.commentable.id
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
