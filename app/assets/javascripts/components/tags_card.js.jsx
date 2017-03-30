var TagsCard = React.createClass({
  getInitialState: function(){
    return {
      tags: this.props.tags,
      display_form: false
    }
  },

  handleClick: function(e) {
    e.preventDefault();
    this.setState({ display_form: true })
  },

  handleUserInput: function(obj, e) {
    newTagsArr = this.props.tags;
    newTagsArr.push(obj);
    if (e.keyCode == 13) {
      console.log(obj)
      this.setState({ tags: newTagsArr})
    }
  },

  render: function() {
    console.log(this.props)
    var display_form = this.state.display_form
    var tags = [];

    this.state.tags.map(function(tag, i) {
      tags.push(<Tag tag={tag} key={i} />)
    })

    return (
      <div>
      <div className="flex">
        {tags}
      </div>
      {!display_form && <button className="nlac-btn" onClick={this.handleClick}>Add Tags</button>}
      <div>
          {display_form && <TagsForm onFormSubmit={this.handleFormSubmit}
            onUserInput={this.handleUserInput} />}
        </div>
      </div>
    )
  }
})
