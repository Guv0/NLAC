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

  handleTagIt: function() {
    this.handleFormSubmit();
    document.getElementById('bc-tag-input').value = '';
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
    var ownerTags = [];
    var myTags = [];

    this.state.tags.map(function(tag, i) {
      if (this.props.current_user.id === tag[1]) {
        myTags.push(<Tag tag={tag} key={i} index={i} current_user={this.props.current_user} business_card={this.props.business_card} handleDeleteTag={this.deleteTag} />)
      } else {
        ownerTags.push(<Tag tag={tag} key={i} index={i} current_user={this.props.current_user} business_card={this.props.business_card} handleDeleteTag={this.deleteTag} />)
      }
    }.bind(this))

    return (
      <div>
        {this.props.business_card.user_id !== this.props.current_user.id &&
          <h3>{this.props.business_card.first_name.toUpperCase() + "'S TAGS"}</h3>
        }
        <div className="flex-wrap" style={{'margin-bottom': '25px'}}>
          {ownerTags}
        </div>
        <h3>MY TAGS</h3>
        <div className="flex-wrap" style={{'margin-bottom': '25px'}}>
          {myTags}
        </div>
        <div className="add-tags-error">
          {this.state.error}
        </div>
        <div className="tags-card-form flex">
          <input name='label' id='bc-tag-input' placeholder='Enter a descriptive tag' onChange={this.handleChange} onKeyPress={this.handleKeyPress}></input>
          <button className='btn business-card-btn' onClick={this.handleTagIt}>Tag it !</button>
        </div>
      </div>
    )
  }
})
