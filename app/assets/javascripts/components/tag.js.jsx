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

    if (this.props.tag[1] != this.props.business_card.id) {
      className = "my-tag";
    }

    return (
      <div className={"flex-center business-card-tag " + className}>
        <p>{this.props.tag[0].label}</p>{destroy}
      </div>
    )
  }
})
