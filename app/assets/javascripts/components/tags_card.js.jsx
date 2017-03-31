var TagsCard = React.createClass({
  getInitialState: function(){
    return {
      tags: this.props.tags,
      display_form: false
    }
  },

  handleClick: function(e) {
    e.preventDefault();
    this.setState({ display_form: true });
  },

  handleEnter: function(obj) {
    newTagsArr = this.props.tags;
    newTagsArr.push(obj);
    this.setState({ tags: newTagsArr });
  },

  killTag: function(index) {
    var tagsArr = this.state.tags;
    tagsArr.splice(index, 1);
    this.setState({tags: tagsArr});
  },

  handleFormSubmit: function() {
    var newTags = [];

    this.state.tags.map(function(tag){
      if (!tag.id) {
        newTags.push(tag.label)
      }
    })

    console.log(newTags)
    this.setState({display_form: false});
      $.ajax({
        type: 'POST',
        url: '/business_cards/' + this.props.business_card.id,
        data: {tags: newTags}
      }).done(function() {
          console.log("done");
        })
  },

  render: function() {
    console.log(this.props)
    var display_form = this.state.display_form
    var tags = [];

    this.state.tags.map(function(tag, i) {
      tags.push(<Tag tag={tag} key={i} index={i} handleCancelTag={this.killTag} />)
    }.bind(this))

    return (
      <div className="react-tags-card">
        <div className="flex">
          {tags}
        </div>
        <div className="add-tags flex-center">
        {!display_form && <button className="add-tags-btn btn" onClick={this.handleClick}>Add Tags</button>}
        </div>
        <div>
          {display_form && <TagsForm onFormSubmit={this.handleFormSubmit}
            onUserInput={this.handleUserInput} onEnter={this.handleEnter}/>}
        </div>
      </div>
    )
  }
})
