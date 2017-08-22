var Mailbox = React.createClass({
  getInitialState: function() {
    return {
      display_conversation: true,
      conversation: this.props.active_conversation,
      conversations: this.props.conversations
    }
  },

  handleDisplayConversation: function(data) {
    this.setState({display_conversation: true, conversation: data});
  },

  setNewMessage: function(data) {
    this.setState({ conversation: data });
  },

  handleSearch: function(e) {
    var search = e.target.value.toLowerCase();
    this.setState({conversations: this.props.conversations}, function(){
      var searchConv = [];
      this.state.conversations.map(function(conversation, i) {
        if (conversation[2].first_name.toLowerCase().startsWith(search) || conversation[2].last_name.toLowerCase().startsWith(search)) {
          searchConv.push(conversation);
          console.log(conversation)
        }
      }.bind(this));
      this.setState({conversations: searchConv});
    });
  },

  render: function() {
    var conversations = [];

    this.state.conversations.map(function(conversation, i){
      conversations.push(<ConversationCard conversation={conversation} key={conversation[0].id}
        current_user={this.props.current_user} active_id={this.state.conversation[0].id} handleConvClick=
          {this.handleDisplayConversation} setReadMessages={this.setNewMessage}/>);
    }.bind(this))

    var display_conversation = this.state.display_conversation;

    // console.log(this.state.conversations[0][0].id);

    return (
      <div className="mailbox-container">
        {/* Left */}
        <div className="mailbox-left">
          {/* Search */}
          <div className="mailbox-search flex-center">
            <input type="text" placeholder="Find a conversation" onChange={this.handleSearch}/>
          </div>
          {/* Conversations cards */}
          {conversations}
        </div>
        {/* Right */}
        <div className="mailbox-right">
          {display_conversation && <Conversation conversation={this.state.conversation}
            key={this.state.conversation.id} current_user={this.props.current_user}
              setMessages={this.setNewMessage} /> }
        </div>
      </div>
    )
  }
})
