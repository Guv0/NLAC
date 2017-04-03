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
      <div className="flex-column flex-center">
        <input className='add-tags-input' name='label' placeholder='Type your tag and hit ENTER' onChange={this.handleChange} onKeyPress={this.handleKeyPress}></input>
       <button className="confirm-add-tags-btn btn" onClick={this.props.onFormSubmit}>Confirm these tags</button>
       </div>
    )
  }
})
