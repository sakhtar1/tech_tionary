# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- MVC model used
- [x] Use ActiveRecord for storing information in a database
- Data is stored in the database
- [x] Include more than one model class (list of model class names e.g. User, Post, Category)
- 2 models used, user and word
- [x] Include at least one has_many relationship on your User model (x has_many y, e.g. User has_many Posts)
- User class has_many :words
- [x] Include at least one belongs_to relationship on another model (x belongs_to y, e.g. Post belongs_to User)
- Word class belongs_to :user
- [x] Include user accounts
- User accounts are included
- [x] Ensure that users can't modify content created by other users
- Users can only modify their own content.
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
- CRUD was used
- [x] Include user input validations
- Used validation for Word class
- [x] Display validation failures to user with error message (example form URL e.g. /posts/new)
- Validation failures were dispayed on url
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
- README.md includes all requirements

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
