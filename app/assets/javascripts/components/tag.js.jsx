var Tag = React.createClass({
  cancelTag: function(e){
    e.preventDefault();
    this.props.handleCancelTag(this.props.index);
  },

  deleteTag: function(e){
    e.preventDefault();
    this.props.handleDeleteTag(this.props.tag);
  },

  render: function() {
    var cancel;
    var destroy;

    console.log(this.props.tag[0].label);
    console.log(this.props.tag[1]);

    if (!this.props.tag[0].id) {
      cancel = <CancelTag handleClick={this.cancelTag} />;
    } else if (this.props.tag[1] == this.props.current_user.id) {
      cancel = <DeleteTag handleClick={this.deleteTag} />;
    }

    return (
      <div className="tag flex-around">
        <p>#</p>{this.props.tag[0].label}{cancel}
      </div>
    )
  }
})
