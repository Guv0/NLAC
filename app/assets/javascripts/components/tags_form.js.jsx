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
      <div>
        <input name='label' onChange={this.handleChange} onKeyPress={this.handleKeyPress}></input>

       <button className="nlac-btn" >Confirm</button>
       </div>
    )
  }
})
