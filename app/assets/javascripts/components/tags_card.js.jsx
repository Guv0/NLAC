var TagsCard = React.createClass({
  getInitialState: function(){
    return {
      tags: this.props.tags,
      display_form: false,
      error: ""
    }
  },

  handleClick: function(e) {
    e.preventDefault();
    this.setState({ display_form: true });
  },

  handleEnter: function(obj) {
    newTagsArr = this.state.tags;
    newTagsArr.push(obj);
    this.setState({ tags: newTagsArr });
  },

  killTag: function(index) {
    var tagsArr = this.state.tags;
    tagsArr.splice(index, 1);
    this.setState({tags: tagsArr});
  },

  deleteTag: function(tag) {
    var deleteTag = {};
    deleteTag["id"] = tag[0].id;
    deleteTag["creator_id"] = tag[1];
    deleteTag["business_card_id"] = this.props.business_card.id;

    $.ajax({
        type: 'DELETE',
        url: '/business_cards/' + this.props.business_card.id + '/deletetag',
        dataType: 'json',
        data: {deleteTag}
      }).done(function(data) {
        this.setState({ tags: data});
        }.bind(this));
  },

  handleFormSubmit: function() {
    var newTags = [];

    this.state.tags.map(function(tag){
      if (!tag[0].id) {
        newTags.push(tag[0].label)
      }
    })

    this.setState({display_form: false});

    if (this.props.current_user.guest) {
      this.setState({error: "Please add to contacts before creating new tags"});
    } else {
      $.ajax({
        type: 'POST',
        url: '/business_cards/' + this.props.business_card.id,
        data: {tags: newTags}
      }).done(function(data) {
          console.log(data);
          this.setState({ tags: data});
        }.bind(this));
    }
  },

  render: function() {
    var display_form = this.state.display_form
    var tags = [];

    this.state.tags.map(function(tag, i) {
      tags.push(<Tag tag={tag} key={i} index={i} current_user={this.props.current_user}
        business_card={this.props.business_card} handleCancelTag={this.killTag}
          handleDeleteTag={this.deleteTag} />)
    }.bind(this))

    return (
      <div className="profile-tags-content flex-column">
        <div className=" profile-tags-display">
          {tags}
        </div>
        <div className="add-tags-error">
          {this.state.error}
        </div>
        <div className="add-tags flex-center">
        {!display_form && <button className="profile-add-tags-btn" onClick={this.handleClick}>Add Tags</button>}
        </div>
        <div>
          {display_form && <TagsForm current_user={this.props.current_user}
          onFormSubmit={this.handleFormSubmit}
            onUserInput={this.handleUserInput} onEnter={this.handleEnter}/>}
        </div>
      </div>
    )
  }
})
