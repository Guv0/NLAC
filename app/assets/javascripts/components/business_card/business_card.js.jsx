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
        Company Name: {this.state.business_card.company_name}<br/>
        Industry: {this.state.business_card.industry}<br/>
        LinkedIn: {this.state.business_card.linkedin_profile_url}<br/>
        Phone: {this.state.business_card.phone}<br/>
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
        <input name="company_name" placeholder={this.state.business_card.company_name} onChange={this.handleChange} ></input>
        <input name="industry" placeholder={this.state.business_card.industry} onChange={this.handleChange} ></input>
        <input name="linkedin_profile_url" placeholder={this.state.linkedin_profile_url} onChange={this.handleChange} ></input>
        <input name="phone" placeholder={this.state.business_card.phone} onChange={this.handleChange} ></input>
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
