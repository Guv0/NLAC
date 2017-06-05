class CommunityMailer < ApplicationMailer

  def creation(community)
    @community = community

    mail(
      to:       @community.managers.first.email,
      subject:  "#{@community.name} created!"
    )
  end

  def message_post(member, community, message)
    @community = community
    @message_title = message.title
    @member = member

    mail(
      to: member.email,
      subject: "#{@community.name}'s manager posted a message"
    )

    # mail(
    #   bcc: @community.members.map(&:email).uniq,
    #   subject: "#{@community.name}'s manager posted a message"
    # )
  end
end
