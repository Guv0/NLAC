var Message = React.createClass({
  render: function() {
    var id;

    if (this.props.message.user_id == this.props.current_user.id) {
      id = "current-user"
    } else {
      id = "other-user"
    }

    return (
      <div className="message" id={id} >
        {this.props.message.body}
      </div>
    )
  }
})
