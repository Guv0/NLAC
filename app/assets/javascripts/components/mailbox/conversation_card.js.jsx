var ConversationCard = React.createClass({

  handleClick: function(e) {
    // Hidding notifications badge
    $(".unread-messages-badge" + this.props.conversation[0].id).addClass('hidden');

    // Displaying conversation (active)
    this.props.handleConvClick(this.props.conversation);

    // Marking conversation's messages as read
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
    // Loading conversation's messages (if any)
    var messages;
    if (this.props.conversation[3].length > 1) {
      messages = this.props.conversation[3];
    } else {
      messages = [{"sent_at": "", "body": ""}];
    }

    // Setting active conversation + unread messages count
    var status, active, count = 0, unread_count;

    this.props.conversation[3].forEach(function(message){
      if (message.user_id != this.props.current_user.id) {
        if (message.read == false){
          count += 1;
          status = "unread";
        }
      }
    }.bind(this))

    count === 0 ? status = "read" : unread_count = count;

    active = (this.props.active_id == this.props.conversation[0].id) ? "active-conversation" : "";

    // Avatar
    var avatar;
    if (this.props.conversation[2].photo.url !== null) {
      avatar = this.props.conversation[2].photo.url
    } else if ( (this.props.conversation[2].linkedin_picture_url !== '') && (this.props.conversation[2].linkedin_picture_url !== null) ) {
      avatar = this.props.conversation[2].linkedin_picture_url
    } else {
      avatar = '/assets/default-avatar.png'
    }

    // Ellipsis
    var ellipsisPreview = '', ellipsisName = '';
    if (messages[messages.length - 1].body.length > 30) ellipsisPreview = '...'
    if (this.props.conversation[2].first_name.length + this.props.conversation[2].last_name.length > 15) ellipsisName = '...'

    return (
      <div className={"conversation-card flex " + active} onClick={this.handleClick}>
        {/* Avatar */}
        <div className="conversation-card-left flex-center">
          <img src={avatar} className="conversation-card-avatar" />
        </div>
        <div className="conversation-card-right">
          {/* Timestamp */}
          <div className="conversation-card-timestamp flex-end">
            <p>{(messages[messages.length - 1].sent_at).substring(0,10)}</p>
          </div>
          <div className="conversation-card-info flex-column">
            {/* Name + Notifications */}
            <div className="flex-between" style={{flex: '0 0 50%'}}>
              <h3>{(this.props.conversation[2].first_name + ' ' + this.props.conversation[2].last_name).substring(0, 15) + ellipsisName}</h3>
              <div className={"flex-center unread-messages-badge" + this.props.conversation[0].id} id={status}><p>{unread_count}</p></div>
            </div>
            {/* Preview */}
            <div style={{flex: '0 0 50%'}}>
              <p>{messages[messages.length - 1].body.substring(0, 30) + ellipsisPreview}</p>
            </div>
          </div>
        </div>
      </div>
    )
  }
})
