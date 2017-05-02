var ConversationCard = React.createClass({
  getInitialState: function(){
    return {
      // display_conversation: false
      read_messages: false
    }
  },

  handleClick: function(e) {
    e.preventDefault;
    // this.setState({display_conversation: true})
    this.setState({read_messages: true})
    this.props.handleConvClick(this.props.conversation);

  },


  render: function(){
    var display_conversation = this.state.display_conversation;
    var messages = this.props.conversation[3];
    var status = messages[messages.length - 1].read;
    var id;

    if (this.state.read_messages == true)
      id = "";
    else if (status == false) {
      id = "unread";
    }

    return (
      <div className="conversation-card" id={id} onClick={this.handleClick} >
        <div className="conversation-card-left">
          <img src={this.props.conversation[2].linkedin_picture_url} className="avatar-large" />
          {this.props.conversation[2].first_name}
        </div>
        <div>
        Subject: {this.props.conversation[0].subject}
        </div>
        <div><span>></span></div>
      </div>
    )
  }
})
