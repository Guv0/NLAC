var ConversationCard = React.createClass({
  getInitialState: function(){
    return {
      // display_conversation: false
      read_messages: false
    }
  },

  handleClick: function(e) {
    e.preventDefault;
    //change conv card style
    this.setState({read_messages: true})

    //display conversation
    this.props.handleConvClick(this.props.conversation);

    //mark messages as read
    var messages = [];

    this.props.conversation[3].forEach(function(message){
      if (message.user_id != this.props.current_user.id) {
        messages.push(message.id);
      }
    }.bind(this))

    $.ajax({
      type: 'POST',
      url: '/conversations/' + this.props.conversation[0].id + '/readmessages',
      dataType: 'json',
      data: {messages: messages}
    }).done(function(data) {
        this.props.setReadMessages(data);
      }.bind(this));
  },


  render: function(){
    var display_conversation = this.state.display_conversation;
    var messages = this.props.conversation[3];
    // var status = messages[messages.length - 1].read;
    var id
    var active;

    this.props.conversation[3].forEach(function(message){
      if (message.user_id != this.props.current_user.id) {
        if (message.read == false){
          id = "unread";
        }
      } else if (this.state.read_messages == true) {
          id = "";
        }
    }.bind(this))

    if (this.props.active_id == this.props.conversation[0].id) {
      active = "active";
    } else {
      active = "";
    }

    return (
      <div className={"conversation-card " + active} id={id} onClick={this.handleClick}>
        <div className="conversation-card-left">
          <img src={this.props.conversation[2].linkedin_picture_url} className="conversation-card-avatar" />
          <p>{messages[messages.length - 1].sent_at}</p>
        </div>
        <div className="conversation-card-right">
          <h3>{this.props.conversation[2].first_name} {this.props.conversation[2].last_name}</h3>
          <p>{messages[messages.length - 1].body.slice(0, 60)}...</p>
        </div>
      </div>
    )
  }
})
