# How to start developing RS

* You need to install PostgreSQL 9.x
* Install ruby build
* Install rbenv
* Using rbenv install 2.1.1
* git clone this repository
* cd remotestandup
* copy application.yml you received to config/
* rbenv local 2.1.1
* rbenv rehash
* gem install bundle
* bundle install
* gem install foreman
* bin/rake db:schema:load
* foreman start
* You should be running in development mode

# Rules of engagement

* Master represents production environment
* Do not commit directly to master
* Each commit needs to happen on a branch first
* We call branches feature/some-descriptive-name
* Branches need to be pushed and run on CI before they can merged
* Do not merge if CI ended with error
* For each branch you wish to merge create a pull request and allow others to review your changes
* Feature without tests is not complete and should not be merged