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

  handleMessage: function(e) {
    $.ajax({
      type: 'POST',
      url: '/conversations',
      data: {
        sender_id: this.props.current_user.id,
        recipient_id: this.props.user.id
      }
    }).done(function(data){
      window.location = '/conversations?active_conversation=' + data.id
    }.bind(this));
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
      <div className="business-card-content">
        {/* Edit profile */}
        <div className="flex-end" style={{'height': '0'}}>{link}</div>

        <div className="flex-column" style={{'height': '100%'}}>
          {/* Name, Job/Company, Location */}
          <div className="flex-column flex-around" style={{'flex': '0 0 23%', 'padding': '0 15px'}}>
            <div className="flex-center flex-wrap" style={{'padding': '0 20px'}}>
              <h1 style={{'margin-right': '5px'}}>{this.state.business_card.first_name}</h1>
              <h1>{this.state.business_card.last_name}</h1>
            </div>

            <div className="flex-center flex-wrap">
              <h2 style={{'margin-right': '5px'}}>{this.state.business_card.position}</h2>
              <h2>@ {this.state.business_card.company_name}</h2>
            </div>

            <div className="flex-center">
              <i className="material-icons location">location_on</i>
              <h3 style={{'margin-left': '5px'}}>{this.state.business_card.location}</h3>
            </div>
          </div>

          {/* Contacts, Message */}
          <div className="flex-between" style={{'flex': '0 0 12%', 'padding': '16px 15% 0 15%'}}>
            <div className="business-card-btn flex-center" id="contacts" onClick={this.handleContacts}>
              <p>Contacts</p>
            </div>
            <div className="business-card-btn flex-center" id="message" onClick={this.handleMessage}>
              <p>Message</p>
            </div>
          </div>

        {/* Email, Phone, Industry, Website, Description */}
          <div className="flex-between flex-column" style={{'flex': '0 0 65%', 'padding': '30px 0 15px 0'}}>
            <div className="flex-column" style={{'width': '100%', 'padding': '0 20px'}}>
              <h5>EMAIL</h5>
              <p>{this.state.business_card.email}</p>
            </div>

            <div className="flex-column" style={{'width': '100%', 'padding': '0 20px'}}>
              <h5>PHONE</h5>
              <p>{this.state.business_card.phone}</p>
            </div>

            <div className="flex-between business-card-band" style={{'width': '100%', 'height': '85px'}}>
              <div className="flex-column flex-center" style={{'flex': '0 0 50%', 'height': '100%'}}>
                <h5>INDUSTRY</h5>
                <p>{this.state.business_card.industry}</p>
              </div>
              <div className="flex-column flex-center" style={{'flex': '0 0 50%', 'height': '100%'}}>
                <h5>WEBSITE</h5>
                <a href="www.google.com"><i className="material-icons">home</i></a>
              </div>
            </div>

            <div className="flex-column" style={{'width': '100%', 'padding': '0 20px'}}>
              <h5>ABOUT ME</h5>
              <p>{this.state.business_card.description}</p>
            </div>
          </div>

        </div>

      </div>
    )
  },

  renderForm: function() {
    return (
      <div className="business-card-content">
        <div className="flex-center business-card-top-input" style={{'margin': '20px 0 15px 0'}}>
          <input name="first_name" placeholder={this.state.business_card.first_name} onChange={this.handleChange}/>
          <input name="last_name" placeholder={this.state.business_card.last_name} style={{'marginLeft': '20px'}} onChange={this.handleChange}/>
        </div>
        <div className="flex-end">
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
