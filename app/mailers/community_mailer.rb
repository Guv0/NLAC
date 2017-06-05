class CommunityMailer < ApplicationMailer

  def creation(community)
    @community = community

    mail(
      to:       @community.managers.first.email,
      subject:  "#{@community.name} created!"
    )
  end

  def message_post(community)
    @community = community

    @community.members.each do |member|
      mail(
        to: member.email,
        subject: "#{@community.name}'s manager posted a message"
      )
    end
  end
end
