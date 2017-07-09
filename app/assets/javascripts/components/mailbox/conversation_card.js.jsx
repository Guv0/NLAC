var ConversationCard = React.createClass({

  handleClick: function(e) {
    //hide notification
    $(".unread-messages" + this.props.conversation[0].id).addClass('hidden');

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
    // var display_conversation = this.state.display_conversation;
    var messages;
    if (this.props.conversation[3].length > 1) {
      messages = this.props.conversation[3];
    } else {
      messages = [{"sent_at": "", "body": ""}];
    }
    console.log(this.props.conversation[3]);
    // var status = messages[messages.length - 1].read;

    var id, active, count = 0, unread_count;

    this.props.conversation[3].forEach(function(message){
      if (message.user_id != this.props.current_user.id) {
        if (message.read == false){
          count += 1;
          id = "unread";
        }
      }
    }.bind(this))

    count === 0 ? id = "read" : unread_count = count;

    active = (this.props.active_id == this.props.conversation[0].id) ? "active-conversation" : "";

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
        <div className={"unread-messages" + this.props.conversation[0].id} id={id}><span><p>{unread_count}</p></span></div>
      </div>
    )
  }
})
