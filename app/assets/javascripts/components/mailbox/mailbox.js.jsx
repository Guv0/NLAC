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

  handleReply: function(data) {
    // e.preventDefault;
    console.log(data)
    $.ajax({
        type: 'POST',
        url: '/conversations/' + this.props.conversation[0].id + '/messages',
  //       dataType: 'json',
        data: {message: data}
      }).done(function(data) {
          this.setState({conversation: data});
        }.bind(this));
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
        <div className="conversation">
          {display_conversation && <Conversation conversation={this.state.conversation}
            key={this.state.conversation.id} handleSubmit={this.handleReply} /> }
        </div>
      </div>
    )
  }
})
