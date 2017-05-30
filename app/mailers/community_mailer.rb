class CommunityMailer < ApplicationMailer

  def creation(community)
    @community = community

    mail(
      to:       @community.managers.first.email,
      subject:  "#{@community.name} created!"
    )
  end
end
