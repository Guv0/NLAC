var Conversation = React.createClass({
  getInitialState: function() {
    return {
      reply: ""
    }
  },

  handleChange: function(e) {
    e.preventDefault();
    this.setState({ reply: e.target.value});
  },

  handleSubmit: function(e) {
    e.preventDefault();
    var reply = this.state.reply;

    $('#reply').val('');

    $.ajax({
      type: 'POST',
      url: '/conversations/' + this.props.conversation[0].id + '/sendmessage',
      dataType: 'json',
      data: {message: reply}
    }).done(function(data) {
        this.props.setMessages(data);
      }.bind(this));
  },

  render: function() {
    // Messages
    var messages = [];
    var newDay = '';
    this.props.conversation[3].map(function(message, i) {
      if (messages[i - 1] !== undefined) {
        if ((message.sent_at).substring(0,10) !== (messages[i - 1].props.message.sent_at).substring(0,10)) {
          newDay = (message.sent_at).substring(0,10);
        }
      } else {
        newDay = (message.sent_at).substring(0,10);
      }
      messages.push(<Message message={message} current_user={this.props.current_user}
        key={i} newDay={newDay} />);
      newDay = '';
    }.bind(this));

    // Avatar
    var avatar;
    if (this.props.conversation[2].photo.url !== null) {
      avatar = this.props.conversation[2].photo.url
    } else if ( (this.props.conversation[2].linkedin_picture_url !== '') && (this.props.conversation[2].linkedin_picture_url !== null) ) {
      avatar = this.props.conversation[2].linkedin_picture_url
    } else {
      avatar = '/assets/default-avatar.png'
    }

    return (
      <div>
        {/* Banner */}
        <div className="conversation-banner flex">
          <div className="flex-center" style={{flex: '0 0 10%'}}>
            <img src={avatar} className="conversation-banner-avatar" />
          </div>
          <div className="flex-column flex-center" style={{height: '100%', alignItems: 'baseline'}}>
            <h4 className="flex-center">{this.props.conversation[2].first_name + ' ' + this.props.conversation[2].last_name}</h4>
            <p>Started on {this.props.conversation[0].started_on}</p>
          </div>
        </div>
        {/* Conversation */}
        <div className="conversation-content" id="conversation">
          {messages}
        </div>
        {/* Form */}
        <form className="conversation-form flex" onSubmit={this.handleSubmit}>
          <textarea id="reply" className="reply-input" placeholder="Type something..." onChange={this.handleChange} />
          <button><i className="fa fa-paper-plane"></i></button>
        </form>
      </div>
    )
  }
})
