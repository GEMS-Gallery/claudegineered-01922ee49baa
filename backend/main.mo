import Hash "mo:base/Hash";

import Array "mo:base/Array";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

actor {
  private stable var messageEntries : [(Text, Text)] = [];
  private var messages = HashMap.HashMap<Text, Text>(10, Text.equal, Text.hash);
  private stable var fileEntries : [(Text, Text)] = [];
  private var files = HashMap.HashMap<Text, Text>(10, Text.equal, Text.hash);

  private func loadData() {
    for ((k, v) in messageEntries.vals()) {
      messages.put(k, v);
    };
    for ((k, v) in fileEntries.vals()) {
      files.put(k, v);
    };
  };

  system func preupgrade() {
    messageEntries := Iter.toArray(messages.entries());
    fileEntries := Iter.toArray(files.entries());
  };

  system func postupgrade() {
    messageEntries := [];
    fileEntries := [];
  };

  public func addMessage(role: Text, content: Text) : async () {
    let id = Nat.toText(messages.size());
    messages.put(id, role # ": " # content);
  };

  public query func getConversationHistory() : async [(Text, Text)] {
    Iter.toArray(messages.entries())
  };

  public func resetConversation() : async () {
    messages := HashMap.HashMap<Text, Text>(10, Text.equal, Text.hash);
  };

  public func autoMode(iterations: Nat, initialPrompt: Text) : async [Text] {
    var responses : [Text] = [];
    var currentPrompt = initialPrompt;

    for (i in Iter.range(0, iterations - 1)) {
      let response = await generateResponse(currentPrompt);
      responses := Array.append(responses, [response]);
      currentPrompt := response;
    };

    responses
  };

  public func createOrUpdateFile(name: Text, content: Text) : async () {
    files.put(name, content);
  };

  public query func readFile(name: Text) : async ?Text {
    files.get(name)
  };

  public query func listFiles() : async [(Text, Text)] {
    Iter.toArray(files.entries())
  };

  public func executeCode(code: Text) : async Text {
    // Note: This is a placeholder. Actual code execution would require a safe execution environment.
    "Code execution result: " # code
  };

  private func generateResponse(input: Text) : async Text {
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
  loadData();
}
