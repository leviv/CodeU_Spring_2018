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
<%@ page import="java.util.List" %>
<%@ page import="codeu.model.data.Conversation" %>

<!DOCTYPE html>
<html>
<head>
  <title>Conversations</title>
  <%@ include file="meta.jsp" %>  
</head>
<body>

<%@ include file="header.jsp" %>  


  <div class="container">

    <% if(request.getAttribute("error") != null){ %>
        <h2 style="color:red"><%= request.getAttribute("error") %></h2>
    <% } %>

    <% if(request.getSession().getAttribute("user") != null){ %>
      <h1><span>New Conversation</span></h1>
      
    <div class="new-convo">
        <form action="/conversations" method="POST">
        <span class="input input--hoshi">
        <input class="input__field input__field--hoshi" type="text" id="input-4" name="conversationTitle" />
        <label class="input__label input__label--hoshi input__label--hoshi-color-1" for="input-4">
            <span class="input__label-content input__label-content--hoshi">Title</span>
        </label>
        </span>
       
        <div class="button-con">
            <button type="submit">Create</button>
        </div>
      </form>
    </div>

      <hr/>
    <% } %>

    <h1><span>Conversations</span></h1>

    <% List<Conversation> conversations = (List<Conversation>) request.getAttribute("conversations");
    
    if(conversations == null || conversations.isEmpty()){
    %>
      <p>Create a conversation to get started.</p>
      
    <% } else { %>
        
        
         <%
            int numOfCols = 3;
            int rowCount = 0;
            int bootstrapColWidth = 12 / numOfCols;
            int fieldCount = -1;
            
            for(Conversation conversation : conversations){
                fieldCount++;
            }
            
            %>
            <div class="row">
                <% for(Conversation conversation2 : conversations){ %>
                    <div class="col-sm-<%= bootstrapColWidth %> organization">
                        <div class="convo">
                            <a href="/chat/<%= conversation2.getTitle() %>" class="hover">
                        <%= conversation2.getTitle() %></a>
                        </div>
                    </div>

                    <% rowCount++;
                    if(rowCount % numOfCols == 0) {  %>
                        </div><div class="row">
                    <% } %>
                <% } %>
            </div>        
        
    <% }%>
    <br/><br/>
  </div>

<%@ include file="footer.jsp" %>  

</body>
</html>
