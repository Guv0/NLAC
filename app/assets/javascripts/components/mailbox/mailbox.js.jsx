var Mailbox = React.createClass({
  getInitialState: function() {
    return {
      display_conversation: false,
      conversation: [{}]
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
        handleConvClick={this.handleDisplayConversation}/>);
    }.bind(this))

    var display_conversation = this.state.display_conversation;


    return (
      <div className="flex">
        <div className="conversations">
          {conversations}
        </div>
        <div>
          {display_conversation && <Conversation conversation={this.state.conversation}
            key={this.state.conversation.id} setMessages={this.setNewMessage} /> }
        </div>
      </div>
    )
  }
})
