# Getting it running

First, run `bundle install` to get rails set up

Next, run `rake db:create` to create the database.  The config assumes that you're running mysql locally as root. If you have a different configuration, you may need to set it in the config/db.yml file.

Then, run `rake db:seed` to import the CSV data.

Finally, `rails s` will get you running on port 3000.

