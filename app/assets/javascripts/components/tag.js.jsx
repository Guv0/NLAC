var Tag = React.createClass({
  render: function() {
    var cancel;

    if (!this.props.tag.id) {
      cancel = <CancelTag/>;
    }

    return (
      <div className="tag flex-around">
        <p>#</p>{this.props.tag.label}{cancel}
      </div>
    )
  }
})
