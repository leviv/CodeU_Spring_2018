// Copyright 2017 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package codeu.model.store.basic;

import codeu.model.data.Message;
import codeu.model.store.persistence.PersistentStorageAgent;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

/**
 * Store class that uses in-memory data structures to hold values and automatically loads from and
 * saves to PersistentStorageAgent. It's a singleton so all servlet classes can access the same
 * instance.
 */
public class MessageStore {

  /** Singleton instance of MessageStore. */
  private static MessageStore instance;

  /**
   * Returns the singleton instance of MessageStore that should be shared between all servlet
   * classes. Do not call this function from a test; use getTestInstance() instead.
   */
  public static MessageStore getInstance() {
    if (instance == null) {
      instance = new MessageStore(PersistentStorageAgent.getInstance());
    }
    return instance;
  }

  /**
   * Instance getter function used for testing. Supply a mock for PersistentStorageAgent.
   *
   * @param persistentStorageAgent a mock used for testing
   */
  public static MessageStore getTestInstance(PersistentStorageAgent persistentStorageAgent) {
    return new MessageStore(persistentStorageAgent);
  }

  /**
   * The PersistentStorageAgent responsible for loading Messages from and saving Messages to
   * Datastore.
   */
  private PersistentStorageAgent persistentStorageAgent;

  /** The in-memory list of Messages. */
  private List<Message> messages;

  /** This class is a singleton, so its constructor is private. Call getInstance() instead. */
  private MessageStore(PersistentStorageAgent persistentStorageAgent) {
    this.persistentStorageAgent = persistentStorageAgent;
    messages = new ArrayList<>();
  }

  /** Add a new message to the current set of messages known to the application. */
  public void addMessage(Message message) {
    messages.add(message);
    persistentStorageAgent.writeThrough(message);
  }

  /** Access the current set of Messages within the given Conversation. */
  public List<Message> getMessagesInConversation(UUID conversationId) {

    List<Message> messagesInConversation = new ArrayList<>();

    for (Message message : messages) {
      if (message.getConversationId().equals(conversationId)) {
        messagesInConversation.add(message);
      }
    }

    return messagesInConversation;
  }

  /** Access a set of Messages from a user for their profile page .*/
  public List<Message> getMessagesByUser(UUID userId) {

    List<Message> messagesByUser = new ArrayList<>();

    // start from the end to get most recent messages from the user
    for (int i = messages.size() - 1; i >= 0; i--) {
      // avoid the problem of too much messages on the page. not sure if this # should be smaller or not
      if (messagesByUser.size() >= 100) break;
      else if (messages.get(i).getAuthorId().equals(userId))
        messagesByUser.add(messages.get(i));
    }

    return messagesByUser;

  }

  /** Sets the List of Messages stored by this MessageStore. */
  public void setMessages(List<Message> messages) {
    this.messages = messages;
  }

  /**
   * Return the number of messsages that have been sent using the webapp
   * @return
   */
  public int numMessages() {
	  return messages.size();
  }

  /**
   * Get the UUID of the user with the most messages
   * @return the UUID
   */
  public UUID getMostActive() {

	  HashMap<UUID, int[]> messageFreq = new HashMap<>();

	  // Loop through every message
	  for (Message m : messages) {
		  UUID temp = m.getAuthorId();

		  // Assign message to a user
		  if (messageFreq.get(temp) == null) {
			  messageFreq.put(temp, new int[]{0});
		  }

		  messageFreq.get(temp)[0]++;
	  }

	  UUID highestUser = null;
	  int highestNumMessages = 0;

	  // Loop through the map to get the highest number
	  for (UUID u : messageFreq.keySet()) {
		  int cur = messageFreq.get(u)[0];

		  if (cur > highestNumMessages) {
			  highestUser = u;
			  highestNumMessages = cur;
		  }
	  }

	  return highestUser;
  }

  /**
   * Get the UUID of the user who has typed the most word
   * @return the UUID
   */
  public UUID getWordiest() {

	  HashMap<UUID, int[]> messageFreq = new HashMap<>();

	  // Loop through every message
	  for (Message m : messages) {

		  String content = m.getContent();
		  int numSpaces = 0;

		  for (int i = 0; i < content.length(); i++) {
			  if (content.charAt(i) == ' ') {
				  numSpaces++;
			  }
		  }

		  UUID temp = m.getAuthorId();

		  // Assign message to a user
		  if (messageFreq.get(temp) == null) {
			  messageFreq.put(temp, new int[]{0});
		  }

		  messageFreq.get(temp)[0]+= (numSpaces + 1);
	  }

	  UUID highestUser = null;
	  int highestNumMessages = 0;

	  // Loop through the map to get the highest number
	  for (UUID u : messageFreq.keySet()) {
		  int cur = messageFreq.get(u)[0];

		  if (cur > highestNumMessages) {
			  highestUser = u;
			  highestNumMessages = cur;
		  }
	  }

	  return highestUser;
  }

}
