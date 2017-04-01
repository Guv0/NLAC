var TagsForm = React.createClass({

  handleKeyPress: function(e) {
    e.preventDefault;
    var label = e.target.name
    obj = {};

    obj[label] = e.target.value;

    if (e.key === 'Enter') {
      console.log('enter');
      this.props.onEnter(obj);
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
