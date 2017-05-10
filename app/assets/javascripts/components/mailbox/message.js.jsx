var Message = React.createClass({
  render: function() {
    var id;

    if (this.props.message.user_id == this.props.current_user.id) {
      id = "current-user"
    } else {
      id = "other-user"
    }

    return (
      <div>
        <div className="message-container">
          <div className="message-info" id={id + "-info"}>
            <h6>{this.props.message.sender}</h6>
            <p>{this.props.message.sent_at}</p>
          </div>
          <div className="message" id={id}>
            <p>{this.props.message.body}</p>
          </div>
        </div>

      </div>
    )
  }
})
