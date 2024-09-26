import Hash "mo:base/Hash";

import Array "mo:base/Array";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

actor {
  // Chat history storage
  private stable var messageEntries : [(Text, Text)] = [];
  private var messages = HashMap.HashMap<Text, Text>(10, Text.equal, Text.hash);

  // Initialize messages from stable storage
  private func loadMessages() {
    for ((k, v) in messageEntries.vals()) {
      messages.put(k, v);
    }
  };

  // Save messages to stable storage
  system func preupgrade() {
    messageEntries := Iter.toArray(messages.entries());
  };

  // Clear temporary storage after upgrade
  system func postupgrade() {
    messageEntries := [];
  };

  // Add a new message to the chat history
  public func addMessage(sender: Text, content: Text) : async () {
    let id = Nat.toText(messages.size());
    messages.put(id, sender # ": " # content);
  };

  // Get all messages in the chat history
  public query func getMessages() : async [Text] {
    let messageArray = Iter.toArray(messages.vals());
    Array.sort(messageArray, Text.compare)
  };

  // Generate a simple AI response
  public func generateResponse(input: Text) : async Text {
    let lowercaseInput = Text.toLowercase(input);
    if (Text.contains(lowercaseInput, #text "hello") or Text.contains(lowercaseInput, #text "hi")) {
      return "Hello! How can I assist you with engineering tasks today?";
    } else if (Text.contains(lowercaseInput, #text "bye") or Text.contains(lowercaseInput, #text "goodbye")) {
      return "Goodbye! Feel free to come back if you have more engineering questions.";
    } else if (Text.contains(lowercaseInput, #text "thank")) {
      return "You're welcome! Is there anything else I can help you with?";
    } else {
      return "As an AI engineer assistant, I'm here to help. Could you please provide more details about your engineering question or problem?";
    }
  };

  // Initialize the actor
  loadMessages();
}
