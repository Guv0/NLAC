var DeleteTag = React.createClass({
  render: function() {
    return (
      <i className="material-icons" title="Remove tag" onClick={this.props.handleClick}>clear</i>
    )
  }
})
