# The Gossip Project
The Gossip Project is a simple Ruby on Rails web application designed for practicing Rails and its features. It's a small-scale social media application where users can share gossips.

## Features

Here are some of the features The Gossip Project provides:

- User System: Users can create an account to share their gossips.
- Gossip Management: The application has show and index actions for displaying gossips.
- Static Pages: The application includes static pages like Contacts, Team, and Welcome.

## Setup and Installation

To get the application up and running, follow these steps:

1. Clone the repository to your local machine using 'git clone'.
   ```
    git clone https://github.com/Creiwry/the_gossip_project_week_6.git
   ```
2. Navigate to the project directory
   ```
    cd gossip_project_week_6
   ```
3. Install the necessary dependencies.
   ```
    bundle install
    yarn install
   ```
4. Set up the database.
   ```
    rails db:schema:load
    rails db:seed
   ```
5. Start the Rails server 
  ```
  rails s
  ```

The application should now be running at http://localhost:3000.
