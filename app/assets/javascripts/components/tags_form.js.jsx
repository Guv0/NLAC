var TagsForm = React.createClass({

  handleChange: function(e) {
    obj = {};
    obj["label"] = e.target.value;
    this.props.onUserInput(obj, e);
  },

  render: function() {
    return (
      <div>
        <input name='label' placeholder='add tag here' onChange={this.handleChange}></input>

       <button className="nlac-btn" >Confirm</button>
       </div>
    )
  }
})
