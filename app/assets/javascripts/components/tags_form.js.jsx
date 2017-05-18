var TagsForm = React.createClass({

  handleKeyPress: function(e) {
    e.preventDefault;
    var label = e.target.name
    var newTag = [];
    obj = {};
    obj[label] = e.target.value;
    newTag.push(obj);
    newTag.push("new");

    if (e.key === 'Enter') {
      this.props.onEnter(newTag);
      e.target.value = '';
    }
  },

  render: function() {
    return (
      <div className="profile-add-tags-form flex-center">
        <div className="flex-column">
          <input name='label' onChange={this.handleChange} onKeyPress={this.handleKeyPress}></input>
          <p>Type in a tag & hit 'Enter'</p>
        </div>
        <button className="profile-confirm-tags-btn" onClick={this.props.onFormSubmit}>Confirm tags</button>
      </div>
    )
  }
})
