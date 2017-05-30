class RequestMailerPreview < ActionMailer::Preview

  def connection_request_received
    RequestMailer.connection_request_received(ConnectionRequest.first)
  end


end
