var Conversation = React.createClass({
  getInitialState: function() {
    return {
      reply: ""
    }
  },

  handleChange: function(e) {
    e.preventDefault;
    this.setState({ reply: e.target.value});
  },

  handleSubmit: function(e) {
    e.preventDefault;
    this.props.handleSubmit(this.state.reply);
  },

  render: function() {
    console.log(this.props.conversation[3]);
    console.log(this.props.conversation[3][0]);
    var messages = [];

    this.props.conversation[3].map(function(message, i) {
      messages.push(<Message message={message} key={i} />);
    })

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
