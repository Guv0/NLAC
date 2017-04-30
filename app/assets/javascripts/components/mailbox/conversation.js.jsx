var Conversation = React.createClass({
  render: function() {
    console.log(this.props.conversation[3]);
    console.log(this.props.conversation[3][0]);
    return (
      <div>
        {this.props.conversation[3][0].body}
      </div>
    )
  }
})
