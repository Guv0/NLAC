var Tag = React.createClass({
  cancelTag: function(e){
    e.preventDefault();
    this.props.handleCancelTag(this.props.index);
  },

  render: function() {
    var cancel;

    if (!this.props.tag.id) {
      cancel = <CancelTag handleClick={this.cancelTag} />;
    }

    return (
      <div className="tag flex-around">
        <p>#</p>{this.props.tag.label}{cancel}
      </div>
    )
  }
})
