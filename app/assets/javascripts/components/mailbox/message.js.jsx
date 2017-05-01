var Message = React.createClass({
  render: function() {
    return (
      <div>
        {this.props.message.body}
      </div>
    )
  }
})
