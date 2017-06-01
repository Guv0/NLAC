var TagsCard = React.createClass({
  getInitialState: function(){
    return {
      tags: this.props.tags,
      newTag: "",
      // display_form: false,
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

  handleChange: function(e) {
    this.setState({newTag: e.target.value});
  },

  handleKeyPress: function(e) {
    if (e.key === 'Enter') {
      this.handleFormSubmit();
      e.target.value = '';
    }
  },

  handleFormSubmit: function() {
    var newTag = this.state.newTag

    // this.state.tags.map(function(tag){
    //   if (!tag[0].id) {
    //     newTags.push(tag[0].label)
    //   }
    // })

    if (this.props.current_user.guest) {
      this.setState({error: "Please add to contacts before creating new tags"});
    } else {
      $.ajax({
        type: 'POST',
        url: '/business_cards/' + this.props.business_card.id,
        data: {tag: newTag}
      }).done(function(data) {
          console.log(data);
          this.setState({ tags: data, newTag: ""});
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

        <div className="profile-add-tags-form flex-center">
          <div className="flex-column">
            <input name='label' onChange={this.handleChange} onKeyPress={this.handleKeyPress}></input>
            <p>Type in a tag & hit 'Enter'</p>
          </div>
        </div>
      </div>
    )
  }
})
