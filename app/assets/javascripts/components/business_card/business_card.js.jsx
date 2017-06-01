var BusinessCard = React.createClass({
  getInitialState: function() {
    return {
      editable: false,
      business_card: this.props.business_card
    }
  },

  handleEdit: function(e) {
    e.preventDefault();
    this.setState({editable: true});
  },

  handleChange: function(e) {
    e.preventDefault();
    var business_card = this.state.business_card;
    business_card[e.target.name] = e.target.value;
    this.setState({business_card: business_card});
  },

  handleSave: function(e) {
    console.log(this.state.business_card);

    $.ajax({
        type: 'PATCH',
        url: '/business_cards/' + this.props.business_card.id,
        data: {business_card: this.state.business_card}
      }).done(function(data) {
          console.log(data);
          this.setState({editable: false});
        }.bind(this));
  },

  renderNormal: function() {
    return (
      <div>
        First Name: {this.state.business_card.first_name}<br/>
        Last Name: {this.state.business_card.last_name}<br/>
        Email: {this.state.business_card.email}<br/>
        City: {this.state.business_card.location}<br/>
        <button onClick={this.handleEdit}>Edit</button>
      </div>
    )
  },

  renderForm: function() {
    return (
      <div>
        <input name="first_name" placeholder={this.state.business_card.first_name} onChange={this.handleChange} ></input>
        <input name="last_name" placeholder={this.state.business_card.last_name} onChange={this.handleChange} ></input>
        <input name="location" placeholder={this.state.business_card.location} onChange={this.handleChange} ></input>
        <input name="email" placeholder={this.state.business_card.email} onChange={this.handleChange} ></input>
        <button onClick={this.handleSave}>Save</button>
      </div>

    )
  },

  render: function() {
    if (this.state.editable) {
      return this.renderForm()
    } else {
      return this.renderNormal()
    }
  }
})
