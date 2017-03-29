var TagForm = React.createClass({
  render: function() {
    console.log(this.props)
    return (
      <div>
        {this.props.tags}
      </div>
    )
  }
})
