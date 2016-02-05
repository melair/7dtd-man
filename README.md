# 7 Days to Die

A script to manage the day number on a 7 days to die server to sync it to the real world date.

# Install

* Install ruby, rubygems and git from your systems package manager.
* `git clone https://github.com/melair/7dtd-man.git`
* `cd 7dtd-man`
* `gem install bundler`
* `bundle install`

# Run

Run with the date you wish the first day to be on, this can be a day in the future.

* `screen -S 7dtd-man bundle exec ruby manager.rb 2016 2 10 0`

The number after manager.rb are START_YEAR, START_MONTH, START_DAY and START_HOUR. The time is your systems timezone.

# Limitations

It will only manage one 7dtd server on the default port.
