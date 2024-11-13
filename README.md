# Cleo's Kata club repo

This repo stores the katas that we work on as part of Cleo's internal Kata club.

[![Ruby Lint](https://github.com/meetcleo/cleo-katas/actions/workflows/ruby-lint.yml/badge.svg?branch=main)](https://github.com/meetcleo/cleo-katas/actions/workflows/ruby-lint.yml) 

## Installing 

```bash
git clone git@github.com:Bodacious/cleo-katas.git
```

## Listing the available katas 

```bash
bin/cleo-katas list 
```


## Start working on a kata

```bash
bin/cleo-katas attempt [kata-name]
```

So, to begin working on the rock_paper_scissors kata, you would type 

```bash
bin/cleo-katas attempt rock_paper_scissors
```

This will create a new directory within this repository for you to work within.

## What's a `main.rb` file?

Since we're just writing plain Ruby code, outside of the context of a web application, we need a file to run as an entry point to our application. The `cleo-katas attempt` script will create a new `main.rb` file for you. You can run this by calling 

```bash
bundle exec ruby katas/[name-of-kata]/your-username/main.rb
```

## Submitting your solution 

Everyone is welcome to submit their own solution to a given kata. This is, of course, completely optional, but submitting your solution is a great way to share ideas with others and discuss and learn from eachother. 

Simply push a new PR to the repo's `main` branch with your changes. As long as these are contained within your own named directory, there should be very little risk of this impacting anyone else's contributions

## How can I change my name?

By default, all of the katas you attempt will be created in a directory with your name. This is automatically set to your git config username or the user name on your local machine, but you can configure it to be any value you want to be. Simply add a new file to the repo called `.cleo-katas.yml` and add the following configuration:

```yaml
username: yourname
```
