# RetroCasts

[![Code Climate](https://codeclimate.com/github/snsavage/retro_casts/badges/gpa.svg)](https://codeclimate.com/github/snsavage/retro_casts) [![Test Coverage](https://codeclimate.com/github/snsavage/retro_casts/badges/coverage.svg)](https://codeclimate.com/github/snsavage/retro_casts/coverage) [![Issue Count](https://codeclimate.com/github/snsavage/retro_casts/badges/issue_count.svg)](https://codeclimate.com/github/snsavage/retro_casts)

```
   _____      _              _____          _
  |  __ \    | |            / ____|        | |
  | |__) |___| |_ _ __ ___ | |     __ _ ___| |_ ___
  |  _  // _ \ __| '__/ _ \| |    / _` / __| __/ __|
  | | \ \  __/ |_| | | (_) | |___| (_| \__ \ |_\__ \
  |_|  \_\___|\__|_|  \___/ \_____\__,_|___/\__|___/
```
The RetroCasts gem provides access to [RailsCasts.com](http://railscasts.com) through a command line utility.  The utility allows browsing and searching of RailsCasts episodes with the option to view a description of the episode and to open the episode in your web browser.  See usage below for more detail.

*RetroCasts was created as a project for  the Flatiron School's Online Web Developer program.  You can find more information here: [learn.co/with/snavage](http://learn.co/with/snavage).  Or to find out more about the making of RetroCasts checkout my post at [snsavage.com](http://www.snsavage.com/blog/2016/the_making_of_retrocasts.html)* 

## Installation

To install run: 

    $ gem install retro_casts

## Usage

To access RetroCasts run the ```retrocasts``` command.  

	$ retrocasts

This will open the episode menu.

```
 _____      _              _____          _
|  __ \    | |            / ____|        | |
| |__) |___| |_ _ __ ___ | |     __ _ ___| |_ ___
|  _  // _ \ __| '__/ _ \| |    / _` / __| __/ __|
| | \ \  __/ |_| | | (_) | |___| (_| \__ \ |_\__ \
|_|  \_\___|\__|_|  \___/ \_____\__,_|___/\__|___/
Welcome to RetroCasts!
##################################################
1. Foundation - Jun 16, 2013
2. Form Objects - Jun 3, 2013
3. Model Caching (revised) - May 13, 2013
4. Upgrading to Rails 4 - May 6, 2013
5. Batch API Requests - Apr 27, 2013
6. Handling Exceptions (revised) - Apr 20, 2013
7. Fast Tests - Apr 10, 2013
8. Fast Rails Commands - Apr 4, 2013
9. Performance Testing - Mar 27, 2013
10. Eager Loading (revised) - Mar 20, 2013
Please select an option...
Episodes: 1 to 10  | home | search {search terms} | next | back | exit
>
```
In the background, RetroCasts is scraping the RailsCasts website.  Therefore, the results shown above represent the episode results shown on the homepage of RailsCasts.  From here several options are available.

To view an episode's details chose an episode number.

```
>1
Title: Foundation
Number: 417
Date: Jun 16, 2013
Length: 11 minutes
Description: ZURB's Foundation is a front-end for quickly building
applications and prototypes. It is similar to Twitter Bootstrap but
uses Sass instead of LESS. Here you will learn the basics of the grid
system, navigation, tooltips and more.
Link: /episodes/417-foundation
Type 'back' to go back or 'open' to open the episode in your browser.
>
```
From the detail screen, ```back``` will return to the main menu and ```open``` will open the episode in your browser.

Back on the episode menu, other options include...

* ```home``` - Go back to the RailsCasts homepage results. 
* ```next``` - Go to the next page of episode results.
* ```back``` - Go to the previous page of episode results.
* ```search {search terms}``` - Search RailsCasts.  There is no need to enter the search terms in quotes.  Something like ```search model caching``` will work fine.  the ```next``` and ```back``` commands move through search results until you go back to ```home```.
* ```exit``` - Closes the program.

### Command Line Search
RetroCasts also lets you search from the command line.  For example...

	$ retrocasts model caching

...will run a search instead of opening the home page results.

```
$ retrocasts model caching
 _____      _              _____          _
|  __ \    | |            / ____|        | |
| |__) |___| |_ _ __ ___ | |     __ _ ___| |_ ___
|  _  // _ \ __| '__/ _ \| |    / _` / __| __/ __|
| | \ \  __/ |_| | | (_) | |___| (_| \__ \ |_\__ \
|_|  \_\___|\__|_|  \___/ \_____\__,_|___/\__|___/
Welcome to RetroCasts!
##################################################
1. Model Caching (revised) - May 13, 2013
2. Facebook Authentication - Jun 25, 2012
3. What's New in Rails 4 - Jan 4, 2013
4. Caching in Rails 2.1 - Jun 23, 2008
Please select an option...
Episodes: 1 to 4  | home | search {search terms} | next | back | exit
>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/snsavage/retro_casts](https://github.com/snsavage/retro_casts). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

