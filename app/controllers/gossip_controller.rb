class GossipController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @gossips = Gossip.all
  end

  def show
    @gossip = Gossip.find(params[:id])
  end

  def new
  end

  def create
    @gossip = Gossip.new(gossip_params)
    if @gossip.save
      flash[:notice] = 'Gossip creation successful'
      redirect_to gossip_path(@gossip.id)
    else
      flash[:alert] = 'Failed to create gossip'
      render :new
    end
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])
    if @gossip.update(gossip_params)
      flash[:notice] = 'Gossip updated successful'
      redirect_to gossip_path(@gossip.id)
    else
      flash[:alert] = 'Failed to update gossip'
      render :edit
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    if @gossip.destroy
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
end
