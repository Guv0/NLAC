class CommunityMailerPreview < ActionMailer::Preview

  def creation
    CommunityMailer.creation(Community.first)
  end

end
