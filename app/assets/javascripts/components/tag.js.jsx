var Tag = React.createClass({
  deleteTag: function(e){
    e.preventDefault();
    this.props.handleDeleteTag(this.props.tag);
  },

  render: function() {
    var destroy;
    var className = "";

    if (this.props.tag[1] == this.props.current_user.id) {
      destroy = <DeleteTag handleClick={this.deleteTag} />;
    }

    return (
      <div className="flex-center tag-bc">
        <p>{this.props.tag[0].label}</p>{destroy}
      </div>
    )
  }
})
