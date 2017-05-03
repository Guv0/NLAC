var Mailbox = React.createClass({
  getInitialState: function() {
    return {
      display_conversation: true,
      conversation: this.props.conversations[0]
    }
  },

  handleDisplayConversation: function(data) {
    this.setState({display_conversation: true, conversation: data});
  },

  setNewMessage: function(data) {
    this.setState({ conversation: data });
  },

  render: function() {
    var conversations = [];

    this.props.conversations.map(function(conversation, i){
      conversations.push(<ConversationCard conversation={conversation} key={i}
        current_user={this.props.current_user} handleConvClick=
          {this.handleDisplayConversation} setReadMessages={this.setNewMessage}/>);
    }.bind(this))

    var display_conversation = this.state.display_conversation;

    console.log(this.props.conversations[0]);

    return (
      <div className="mailbox-container">
        <div className="mailbox-left">
          {conversations}
        </div>
        <div className="mailbox-right">
          {display_conversation && <Conversation conversation={this.state.conversation}
            key={this.state.conversation.id} current_user={this.props.current_user}
              setMessages={this.setNewMessage} /> }
        </div>
      </div>
    )
  }
})
