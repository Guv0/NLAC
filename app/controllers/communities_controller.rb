class CommunitiesController < ApplicationController
  before_action :set_community, except: [ :index, :my_communities, :create ]
  skip_after_action :verify_policy_scoped, only: [:index]
  skip_after_action :verify_authorized, only: [:my_communities]

  def index
    # Search
    if params[:info].present?
      @communities = Community.search_for(params[:info])
    else
      @communities = Community.all
    end
    authorize @communities
    # Creation
    @community = Community.new
  end

  def my_communities

    my_community_memberships = CommunityMembership.where(member_id: current_user.id)
    my_community_ids = []
    my_community_memberships.each do |membership|
      my_community_ids << membership.community_id
    end
    my_communities = Community.where(id: my_community_ids)

    # Search
    if params[:info].present?
      @communities = my_communities.search_for(params[:info])
    else
      @communities = my_communities
    end

    # Creation
    @community = Community.new

  end


  def show
    community_ids =  @community.members.each do |member|
                      member.id
                    end
    # Search
    if params[:info].present? && params[:tag].present?
      business_cards_query = BusinessCard.where(user_id: community_ids).search_for(params[:info])
      search = params[:tag].split(' ')
      valid_tags_search = []
      search.each do |keyword|
        business_cards_query.each do |business_card|
          valid_tags_search << Tag.valid_tags(business_card.id, current_user.id).search_tag(keyword)
        end
      end
      business_cards_search = []
      valid_tags_search.flatten.each do |tag|
      tag.tag_relations.where(business_card_id: community_ids).each do |tag_relation|
        business_cards_search << tag_relation.business_card
      end
      end
      @members = business_cards_query & business_cards_search.sort_by { |e| e.first_name }
    elsif params[:info].present?
      @members = BusinessCard.where(user_id: community_ids).search_for(params[:info]).sort_by { |e| e.first_name }
    elsif params[:tag].present?
      search = params[:tag].split(' ')
      valid_tags_search = []
      search.each do |keyword|
        @community.members.each do |member|
          valid_tags_search << Tag.valid_tags(member.id, current_user.id).search_tag(keyword)
        end
      end
      @members = []
      valid_tags_search.flatten.each do |tag|
        tag.tag_relations.where(business_card_id: community_ids).each do |tag_relation|
          @members << tag_relation.business_card
        end
      end
      @members = @members.uniq.sort_by { |e| e.first_name }
    else
      @members = BusinessCard.where(user_id: community_ids).sort_by { |e| e.first_name }
    end

    # Most popular tags
    tags_list = []
    @community.members.each do |member|
      member.business_card.tag_relations.each do |tag_relation|
        if tag_relation.valid_tag_relation?(member.id, current_user.id)
          tags_list << tag_relation.tag.label
        end
      end
    end

    tags_count = Hash.new(0)
    tags_list.each do |tag|
      tags_count[tag] += 1
    end

    tags_sorted = tags_count.sort_by { |tag, frequency| -frequency }

    @hot_tags = tags_sorted.first(8)

    @community_message = CommunityMessage.new

    @community_messages = CommunityMessage.where(community_id: @community.id)
  end

  def create
    @community = Community.new(community_params)
    if @community.save
      CommunityMembership.create(member_id: current_user.id, community_id: @community.id, manager: true)
      redirect_to community_path(@community)
    else
      redirect_to :back
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def join_community
    CommunityMembership.create(member_id: current_user.id, community_id: @community.id)
    flash[:notice] = "You are now a member of #{@community.name}!"
    redirect_to community_path(@community)
  end

  def leave_community
    if @community.managers.include?(current_user)
      CommunityMembership.where(kick_out_params).first.destroy
      redirect_to community_path(@community)
    else
      CommunityMembership.where(community_id: @community.id, member_id: current_user.id).first.destroy
      redirect_to my_communities_path
    end
  end

  def post_message
    if @community.managers.include?(current_user)
      @community_message = CommunityMessage.new(community_message_params)
      @community_message.community = @community
      @community_message.author = current_user
      @community_message.save
    end
    @community.members. each do |member|
      CommunityMailer.message_post(member, @community, @community_message).deliver_now
    end
    redirect_to community_path(@community)
  end

  private

  def set_community
    @community = Community.find(params[:id])
    authorize @community
  end

  def community_message_params
    params.require(:community_message).permit(:title, :body)
  end

  def community_params
    params.require(:community).permit(:name, :description, :photo)
  end

  def kick_out_params
    params.require(:kick_out).permit(:community_id, :member_id)
  end
end

