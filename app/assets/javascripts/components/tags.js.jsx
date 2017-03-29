var Tag = React.createClass({
  render: function() {
    return (
      <div className="tag flex-around">
        {this.props.tag.label}
      </div>
    )
  }
})
