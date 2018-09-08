Chess Camp

Ensure that you have Ruby and SQLite (Version 3) installed. Once you are in the project directory, run the following commands from the terminal

- "bundle install"
- "rails db:migrate"
- "rails db:populate" (this may take a minute)
- "rails s" (This runs the app locally on http://localhost:3000/)


This web application is designed to be used by distinct user groups.

Guests- Can register for an account and then begin adding students to their family. Afterwards they can register and add camps to their cart.

Administrators - Have the ability to register a student, parent, or instructor into the system. Can also create new camps and curriculums and assign instructors to specific camps. Login as an administrator using the following username and password...
username: mark
password: secret


Parents: Have the ability to register their children for camps and checkout. They can also add students to their family. It's important to note that students can only be registered for camps to which their rating is appropriate (meaning the students rating must be between the min and max ratings for that specific camp). Login as a parent using the following username and password
username: may
password: secret


Instructors: Have the ability to view the students they have been assigned to and the camps they are assigned to. Login as an instructor using the following username and password...
username: rachel
password: secret
