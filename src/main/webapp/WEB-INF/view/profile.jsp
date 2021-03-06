<%--
  Copyright 2017 Google Inc.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
<%@ page import="codeu.model.data.User" %>
<%@ page import="codeu.model.store.basic.UserStore" %>
<%@ page import="codeu.model.data.Message" %>
<%@ page import="codeu.model.store.basic.MessageStore" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.util.Date" %>

<%
    String currentUsername = (String) request.getSession().getAttribute("user"); // attribute is an object type, so we allocate it accordingly
    User currentUser = UserStore.getInstance().getUser(currentUsername);
    String profile = (String) request.getAttribute("profile"); // attribute is an object type, so we allocate it accordingly
    User username = UserStore.getInstance().getUser(profile);
    List<Message> messages = MessageStore.getInstance().getMessagesByUser( (UUID) request.getAttribute("id"));
    boolean loggedIn = false;
    if (request.getSession().getAttribute("user") != null) {
      if (request.getSession().getAttribute("user").equals(profile))
        loggedIn = true;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title><%=profile%></title>
    <%@ include file="meta.jsp" %>
    <style>
        textarea {
            width: 750px;
            height: 100px;
        }
    </style>
</head>
<body id="convo-body">

<%@ include file="header.jsp" %>
<div class="convo-con">
    <div class="container">

        <h1><%=profile%>'s Profile Page</h1>

        <% if(request.getSession().getAttribute("error") != null) { %>
            <h2 style="color:red"><%= request.getSession().getAttribute("error") %></h2>
            <% /* reset so the user won't see it again since it is a session attribute, unless they try to input another bad URL */
            request.getSession().setAttribute("error", null); %>
        <% } %>

        <center><img src="<%=username.getPicture() %>" alt="Profile picture" style="width:250px;">
          <% if (loggedIn) { %>
            <form action="/users/<%= profile %>" method="POST">
              <div class="row">
                <div class="col-sm-12">
                  <span class="input input--hoshi">
                    <input class="input__field input__field--hoshi" type="text" id="input-4" name="url" />
                    <label class="input__label input__label--hoshi input__label--hoshi-color-1" for="input-4">
                      <span class="input__label-content input__label-content--hoshi">Picture Link</span>
                    </label>
                  </span>
                  <div class="button-con">
                    <button type="submit" name="button" value="picture">Change Picture</button>
                  </div>
                </div>
              </div>
            </form>
          <% } %>
        </center>
        <br>

        <%--Friend Button--%>
        <div class="friend">
            <% if (currentUser != null) { %>
              <% if (!currentUsername.equals(profile) && !currentUser.getFriends().contains(profile)) { %>
                <form action="/users/<%= profile %>" method="POST">
                  <button type="submit" name="button" value="add">Add Friend</button>
                </form>
              <% } else if (currentUser.getFriends().contains(profile)) { %>
                  <form action="/users/<%= profile %>" method="POST">
                    <button type="submit" name="button" value="remove" class="removefriend">Remove Friend</button>
                  </form>
              <% } %>
            <% } %>
        </div>
        <br>

        <%--About Me--%>
        <% if (currentUser != null) { %>
            <h2>About <%=profile%>
            <% if (currentUsername.equals(profile)) { %>
              <span class="friend-count">Friends: <%=currentUser.getFriends().size()%></span></h2>
            <% } else { %>
              <span class="friend-count">Friends: <%=username.getFriends().size()%></span></h2>
            <% } %>
        <% } %>
        <p class="about-me"><%=username.getAboutMe() %></p>
        <% if (loggedIn) { %>
          <h3>Edit your About Me</h3>
            <form action="/users/<%= profile %>" method="POST">
              <textarea type="text" name="aboutme" id="aboutme"></textarea>
              <br/>
              <button type="submit" name="button" value="aboutme">Submit</button>
            </form>
        <% } %>
        <hr>
        <h2><%=profile%>'s Sent Messages</h2>
        <p class="about-me">
          <% if (messages.size() == 0) { %>
            This user has not sent any messages yet.
          <% } else { %>
              <% for (Message message : messages) {
                  Date date = Date.from(message.getCreationTime()); %>
              <b><%=date%>:</b> <%=message.getContent()%>
              <br>
              <% } %>
              <% } %>
          </p>
          <br/>

      </div>
  </div>

<%@ include file="footer.jsp" %>
</body>
</html>
