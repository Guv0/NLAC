class CommunityMailer < ApplicationMailer

  def creation(community)
    @community = community

    mail(
      to:       @community.managers.first.email,
      subject:  "#{@community.name} created!"
    )
  end

  def message_post(community, message)
    @community = community
    @message_title = message.title

    mail(
      bcc: @community.members.map(&:email).uniq,
      subject: "#{@community.name}'s manager posted a message"
    )
  end
end
