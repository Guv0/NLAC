class RequestMailer < ApplicationMailer
  def connection_request_received(request)
    @request = request

    mail(
      to:       User.find(@request.contact_id).email,
      subject:  "Somebody has requested to connect with you!"
    )
  end
end
