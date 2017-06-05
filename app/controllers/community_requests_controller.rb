class CommunityRequestsController < ApplicationController
  before_action :set_community_request, only: [ :update, :destroy ]

  def create
    community = Community.find(params[:community_id])
    @community_request = current_user.community_requests.new(user: current_user, community: community, status: 'pending')
    @community_request.save
    redirect_to :back
  end

  def update
    @community_request.accept
    redirect_to :back
  end

  def destroy
    @community_request.destroy
    redirect_to :back
  end

  private

  def set_community_request
    @community_request = CommunityRequest.find(params[:id])
  end
end
