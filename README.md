# Getting it running

First, run `bundle install` to get rails set up

Next, run `rake db:create` to create the database.  The config assumes that you're running mysql locally as root. If you have a different configuration, you may need to set it in the config/db.yml file.

Then, run `rake db:seed` to import the CSV data.

Finally, `rails s` will get you running on port 3000.

# Note:

I received two files - applications.csv and credit.csv - but something in the instructions gave me a suspicion that there should have been a clients file as well.  I've completed it to the best of my ability given the two files I receive, but if there's is meant to be a third, I'll be happy to rework anyting as necessary.
