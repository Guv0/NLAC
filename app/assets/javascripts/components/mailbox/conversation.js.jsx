var Conversation = React.createClass({
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
      </div>
    )
  }
})
