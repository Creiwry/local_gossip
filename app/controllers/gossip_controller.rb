class GossipController < ApplicationController
  before_action :authenticate_user, except: [:index]
  def index
    @gossips = Gossip.all
  end

  def show
    @gossip = Gossip.find(params[:id])
    @comment = Comment.new
  end

  def new
    @tags = Tag.all
  end

  def create
    @tags = Tag.all
    @gossip = Gossip.new(title: params[:title], content: params[:content], user: current_user)

    if @gossip.save
      create_tags(@gossip, params[:gossip][:tag_ids])

      flash[:notice] = 'Gossip creation successful'
      redirect_to gossip_path(@gossip.id)
    else
      flash[:alert] = 'Failed to create gossip'
      render :new
    end
  end

  def edit
    @tags = Tag.all
    @gossip = Gossip.find(params[:id])
  end

  def update
    @tags = Tag.all
    @gossip = Gossip.find(params[:id])

    if chack_if_current_user(@gossip.user) && @gossip.update(gossip_params)
      create_tags(@gossip, params[:gossip][:tag_ids])
      flash[:notice] = 'Gossip updated successful'
      redirect_to gossip_path(@gossip.id)
    else
      flash[:alert] = 'Failed to update gossip'
      render :edit
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    if check_if_current_user(@gossip.user) && @gossip.destroy
      flash[:notice] = 'Gossip deleted successfully'
      redirect_to gossip_index_path
    else
      flash[:alert] = 'Failed to delete gossip'
      render :show
    end
  end

  private

  def record_not_found
    flash[:alert] = '404 not found'
    redirect_to :back
  end

  def gossip_params
    params.require(:gossip).permit(:title, :content, :user_id)
  end

  def create_tags(gossip, tag_ids)
    @gossip.tags.clear
    params[:gossip][:tag_ids].each do |tag_id|
      GossipTag.create(gossip: @gossip, tag_id: tag_id)
    end
  end
end
