var Tag = React.createClass({
  cancelTag: function(e){
    e.preventDefault();
    this.props.handleCancelTag(this.props.index);
  },

  render: function() {
    var cancel;
    var destroy;

    if (!this.props.tag.first.id) {
      cancel = <CancelTag handleClick={this.cancelTag} />;
    }
    console.log(this.props)


    return (
      <div className="tag flex-around">
        <p>#</p>{this.props.tag.first.label}{cancel}
      </div>
    )
  }
})
