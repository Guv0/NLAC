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
    var messages = [];

    this.props.conversation[3].map(function(message, i) {
      messages.push(<Message message={message} current_user={this.props.current_user}
        key={i} />);
    }.bind(this));

    return (
      <div>
        <div className="conversation-banner">
          <img src={this.props.conversation[2].linkedin_picture_url} className="conversation-banner-avatar" />
          <div className="conversation-banner-center">
            <h4>Conversation with <span>{this.props.conversation[2].first_name} {this.props.conversation[2].last_name}</span></h4>
          </div>
          <div className="conversation-banner-right">
            <p><span>Started on:</span> {this.props.conversation[0].started_on}</p>
            </div>
        </div>
        <div className="conversation" id="conversation">
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
