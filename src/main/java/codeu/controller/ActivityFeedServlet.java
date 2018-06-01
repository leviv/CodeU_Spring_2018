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

package codeu.controller;

import codeu.model.data.Conversation;

import java.io.IOException;
import java.time.Instant;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** Servlet class responsible for the activity feed. */
public class ActivityFeedServlet extends HttpServlet {

  /** Set up state for handling related requests. */
  @Override
  public void init() throws ServletException {
    super.init();
  }

  /**
   * This function fires when a user navigates to the activity feed page.
   */
   @Override
   public void doGet(HttpServletRequest request, HttpServletResponse response)
       throws IOException, ServletException {
     request.getRequestDispatcher("/WEB-INF/view/activityfeed.jsp").forward(request, response);
   }

  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {

  }
}
