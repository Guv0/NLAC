var Message = React.createClass({
  render: function() {
    var id = this.props.message.user_id == this.props.current_user.id ? "current-user" : "other-user";
    return (
      <div>
        {this.props.newDay}
        <div className="message-container" id={id + "-message-container"}>
          <div className="message-content">
            <div className="message-info flex-end">
              <p>{(this.props.message.sent_at).substring(0,10)}</p>
            </div>
            <div className="message-bubble" id={id + "-message-bubble"}>
              <p>{this.props.message.body}</p>
            </div>
          </div>
        </div>

      </div>
    )
  }
})
