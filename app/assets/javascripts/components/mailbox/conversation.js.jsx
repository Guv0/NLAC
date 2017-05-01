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
      messages.push(<Message message={message} key={i} />);
    }.bind(this));

    return (
      <div>
        {messages}
        <form onSubmit={this.handleSubmit}>
          <input type="textarea" onChange={this.handleChange} />
          <input type='submit' className="btn" />
        </form>
      </div>
    )
  }
})
