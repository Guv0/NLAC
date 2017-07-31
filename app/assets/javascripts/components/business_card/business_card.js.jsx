var BusinessCard = React.createClass({
  getInitialState: function() {
    return {
      editable: false,
      business_card: this.props.business_card,
    }
  },

  handleContacts: function(e) {
    window.location = '/business_cards/' + this.state.business_card.id + '/connections';
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
    if (this.props.current_user.id === this.props.user.id) {
      var link = <i className="material-icons edit" title="Edit your information" onClick={this.handleEdit}>mode_edit</i>;
    }
    return (
      <div>
        <div className="flex-center business-card-name">{this.state.business_card.first_name + ' '} {this.state.business_card.last_name}</div>
        <div className="flex-end business-card-link" style={{'height': '20px'}}>{link}</div>
        <div className="flex-center business-card-job">{this.state.business_card.position}</div>
        <div className="flex-center business-card-job">@ {this.state.business_card.company_name}</div>
        <div className="flex-end">
          <div className="btn business-card-contacts" onClick={this.handleContacts}>
            {this.props.contacts.length}<span>contacts</span>
          </div>
        </div>
        <div className="flex-center">
          <div style={{'width': '85%', 'borderBottom': '1px solid #E0E0E0'}}></div>
        </div>
        <div className="flex-column" style={{'padding': '10px 25px'}}>
          <div className="flex-column">
            <h5>EMAIL</h5>
            <p>{this.state.business_card.email}</p>
          </div>
          <div className="flex-column">
            <h5>PHONE</h5>
            <p>{this.state.business_card.phone}</p>
          </div>
          <div className="flex-column">
            <h5>LOCATION</h5>
            <p>{this.state.business_card.location}</p>
          </div>
          <div className="flex-column">
            <h5>INDUSTRY</h5>
            <p>{this.state.business_card.industry}</p>
          </div>
          <div className="flex-column">
            <h5>WEBSITE</h5>
            <p>{this.state.business_card.linkedin_profile_url}</p>
          </div>
          <div className="flex-column">
            <h5>DESCRIPTION</h5>
            <p>{this.state.business_card.description}</p>
          </div>
        </div>
      </div>
    )
  },

  renderForm: function() {
    return (
      <div>
        <div className="flex-center business-card-top-input" style={{'margin': '20px 0 15px 0'}}>
          <input name="first_name" placeholder={this.state.business_card.first_name} onChange={this.handleChange}/>
          <input name="last_name" placeholder={this.state.business_card.last_name} style={{'marginLeft': '20px'}} onChange={this.handleChange}/>
        </div>
        <div className="flex-end business-card-link">
          <i className="fa fa-check edit" title="Save changes" aria-hidden="true" style={{'position': 'absolute', 'top': '215px'}} onClick={this.handleSave}></i>
        </div>
        <div className="flex-center">
          <input name="position" placeholder={this.state.business_card.position} onChange={this.handleChange}/>
        </div>
        <div className="flex-center">
          <input name="company_name" placeholder={this.state.business_card.company_name} onChange={this.handleChange}/>
        </div>
        <div className="flex-center">
          <div style={{'width': '85%', 'borderBottom': '1px solid #E0E0E0', 'marginTop': '17px'}}></div>
        </div>
        <div className="flex-column" style={{'padding': '10px 25px'}}>
          <div className="flex-column">
            <h5>EMAIL</h5>
            <input name="email" placeholder={this.state.business_card.email} onChange={this.handleChange}/>
          </div>
          <div className="flex-column">
            <h5>PHONE</h5>
            <input name="phone" placeholder={this.state.business_card.phone} onChange={this.handleChange}/>
          </div>
          <div className="flex-column">
            <h5>LOCATION</h5>
            <input name="location" placeholder={this.state.business_card.location} onChange={this.handleChange}/>
          </div>
          <div className="flex-column">
            <h5>INDUSTRY</h5>
            <input name="industry" placeholder={this.state.business_card.industry} onChange={this.handleChange}/>
          </div>
          <div className="flex-column">
            <h5>WEBSITE</h5>
            <input name="linkedin_profile_url" placeholder={this.state.business_card.linkedin_profile_url} onChange={this.handleChange}/>
          </div>
          <div className="flex-column">
            <h5>DESCRIPTION</h5>
            <textarea name="description" placeholder={this.state.business_card.description} onChange={this.handleChange}/>
          </div>
        </div>
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