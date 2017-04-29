class CommunitiesController < ApplicationController
  before_action :set_community, only: [:show, :update, :destroy]

  def index
    @communities = Communities.all
  end

  def show
    @members = User.find(CommunityMembership.where(community_id: @community.id).user_ids)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_community
    @community = Community.find(params[:id])
  end
end

