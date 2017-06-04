var ConversationCard = React.createClass({
  getInitialState: function(){
    return {
      // display_conversation: false
      conv_card_id: "fuck",
    }
  },

  handleClick: function(e) {
    e.preventDefault();
    //change conv card style
    this.setState({conv_card_id: "read"})

    //Hide unread number
    $('.active-conversation span').addClass('hidden');

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
    var id, active, count = 0, unread_count;

    this.props.conversation[3].forEach(function(message){
      if (message.user_id != this.props.current_user.id) {
        if (message.read == false){
          id = "unread";
          count += 1;
        }
      } else if (this.state.conv_card_id === "read") {
          id = "read";
        }
    }.bind(this))

    if (this.props.active_id == this.props.conversation[0].id) {
      active = "active-conversation";
    } else {
      active = "";
    }

    if (count !== 0) {
      unread_count = count;
    }


    return (
      <div className={"conversation-card " + active} onClick={this.handleClick}>
        <div className="conversation-card-left">
          <img src={this.props.conversation[2].linkedin_picture_url} className="conversation-card-avatar" />
          <p>{messages[messages.length - 1].sent_at}</p>
        </div>
        <div className="conversation-card-right">
          <h3>{this.props.conversation[2].first_name} {this.props.conversation[2].last_name}</h3>
          <p>{messages[messages.length - 1].body.slice(0, 60)}...</p>
        </div>
        <div id={id}><span><p>{unread_count}</p></span></div>
      </div>
    )
  }
})
