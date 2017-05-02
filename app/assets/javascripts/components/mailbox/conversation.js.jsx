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
      <div className="conversation">
        {messages}
        <form onSubmit={this.handleSubmit}>
          <input type="textarea" id="reply" className="reply-input" onChange={this.handleChange} />
          <input type='submit' className="btn" value="Send" />
        </form>
      </div>
    )
  }
})
