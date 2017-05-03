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

  onDisplay: function() {
    var objDiv = this.refs.converse;
      objDiv.scrollTop = objDiv.scrollHeight;
  },

  render: function() {
    var messages = [];

    this.props.conversation[3].map(function(message, i) {
      messages.push(<Message message={message} current_user={this.props.current_user}
        key={i} />);
    }.bind(this));

    return (
      <div>
        <div className="conversation-banner">
          {this.props.conversation[2].first_name}
          {this.props.conversation[2].last_name}
          {this.props.conversation[2].linkedin_picture_url}
        </div>
        <div className="conversation" ref="converse" onLoad={this.onDisplay}>
          {messages}
        </div>
        <form className="reply-form" onSubmit={this.handleSubmit}>
          <textarea id="reply" className="reply-input" onChange={this.handleChange} />
          <div className="flex-center" style={{flex: '0 0 15%'}}>
            <input type='submit' className="conversation-send-btn" value="SEND" />
          </div>
        </form>
      </div>
    )
  }
})
