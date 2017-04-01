var Tag = React.createClass({
  cancelTag: function(e){
    e.preventDefault();
    this.props.handleCancelTag(this.props.index);
  },

  render: function() {
    var cancel;
    var destroy;
    console.log(this.props.tag[0].label);
    console.log(this.props.tag[1]);

    if (!this.props.tag[0].id) {
      cancel = <CancelTag handleClick={this.cancelTag} />;
    }


    return (
      <div className="tag flex-around">
        <p>#</p>{this.props.tag[0].label}{cancel}
      </div>
    )
  }
})
