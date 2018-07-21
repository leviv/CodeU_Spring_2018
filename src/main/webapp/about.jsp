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
<!DOCTYPE html>
<html>
<head>
  <title>CodeU Chat App</title>
  <%@ include file="WEB-INF/view/meta.jsp" %>
</head>
<body>

<%@ include file="WEB-INF/view/header.jsp" %>

  <div class="container about">

      <h1><span>About Team 11</span></h1>

      <div class="row team">
          <div class="col-sm-4">
              <img src="https://download200.com/wp-content/uploads/2017/12/League-of-Legends-Cover.jpg" alt="LoL picture" class="rounded-circle">
              <h3>Leonardo Lopez</h3>
              <p>A UIUC student who likes volleyball and League of Legends.</p>
          </div>
          <div class="col-sm-4">
              <img src="https://archive.is/AXz9f/11d2d898ab06f601c27dc8ba0aad482bdf0d5309.jpg" alt="BOTW picture" class="rounded-circle">
              <h3>Levi Villarreal</h3>
              <p>A UTAustin student who likes ultimate frisbee and Breath of the Wild (BOTW is best).</p>
          </div>
          <div class="col-sm-4">
              <img src="https://fire-emblem-heroes.com/common/img/pc/index/characterSlide/character_slide_13_c.png" alt="Fire emblem picture" class="rounded-circle">
              <h3>Jessica Zhu</h3>
              <p>A UMN student who likes Game of Thrones and Fire Emblem.</p>
          </div>
      </div>

	  <h1><span>New Features and Improvements</span></h1>

      <div id="new-features">
          <div class="row">
              <div class="col-sm-3">
                  <h2>Add Friends</h2>
              </div>
              <div class="col-sm-9">
                  <p>The ability to add friends and have a friend list featured on your page.</p>
              </div>
          </div>

          <div class="row">
              <div class="col-sm-3">
                  <h2>Profile Pictures</h2>
              </div>
              <div class="col-sm-9">
                  <p>The ability to upload a profile picture, featured on your page.</p>
              </div>
          </div>

          <div class="row">
              <div class="col-sm-3">
                  <h2>Reaction Gifs</h2>
              </div>
              <div class="col-sm-9">
                  <p>Access to a gif library in the chat system - think twitter or discord's gifs (uploaded by admins)</p>
              </div>
          </div>
      </div>
    </div>
  </div>

<%@ include file="WEB-INF/view/footer.jsp" %>

</body>
</html>
