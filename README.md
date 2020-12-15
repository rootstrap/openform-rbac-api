# Rootstrap RBAC+

[![CircleCI](https://circleci.com/gh/rootstrap/rails_api_base.svg?style=svg)](https://circleci.com/gh/rootstrap/rails_api_base)
[![Code Climate](https://codeclimate.com/github/rootstrap/rails_api_base/badges/gpa.svg)](https://codeclimate.com/github/rootstrap/rails_api_base)
[![Test Coverage](https://api.codeclimate.com/v1/badges/63de7f82c79f5fe82f46/test_coverage)](https://codeclimate.com/github/rootstrap/rails_api_base/test_coverage)

Role-based access control for Rootstrap projects.

RBAC+ restricts access based on a person's role within an organization 
and has become one of the main methods for advanced access control. 

The roles in RBAC refer to the levels of access that users
have in a platform.

The "+" stands for positive RBAC. We give access to specified resources,
but no access is denied explicitly. 

Finally, it contains a plug an play Administration console (thanks to [ActiveAdmin](https://github.com/activeadmin/activeadmin)).

## Features

RBAC comes with: 


## How to use

1. Clone this repo
2. Install PostgreSQL in case you don't have it
3. Create your `database.yml` and `application.yml` file
4. `bundle install`
5. Generate a secret key with `rake secret` and paste this value into the `application.yml`.
6. `rails db:create db:migrate`
7. `rspec` and make sure all tests pass
8. `rails s`
9. You can now try your REST services!

## How to use with docker


## Api Docs

http://docs.railsapibase.apiary.io

## Code quality

With `rake code_analysis` you can run the code analysis tool, you can omit rules with:

- [Rubocop](https://github.com/bbatsov/rubocop/blob/master/config/default.yml) Edit `.rubocop.yml`
- [Reek](https://github.com/troessner/reek#configuration-file) Edit `config.reek`
- [Rails Best Practices](https://github.com/flyerhzm/rails_best_practices#custom-configuration) Edit `config/rails_best_practices.yml`
- [Brakeman](https://github.com/presidentbeef/brakeman) Run `brakeman -I` to generate `config/brakeman.ignore`
- [Bullet](https://github.com/flyerhzm/bullet#whitelist) You can add exceptions to a bullet initializer or in the controller

## Configuring Code Climate
1. After adding the project to CC, go to `Repo Settings`
2. On the `Test Coverage` tab, copy the `Test Reporter ID`
3. Replace the current value of `CC_TEST_REPORTER_ID` on the `config.yml file (.circleci/config.yml)` with the one you copied from CC

## Code Owners

You can use [CODEOWNERS](https://help.github.com/en/articles/about-code-owners) file to define individuals or teams that are responsible for code in the repository.

Code owners are automatically requested for review when someone opens a pull request that modifies code that they own.

## Credits

Rails Api Base is maintained by [Rootstrap](http://www.rootstrap.com) with the help of our
[contributors](https://github.com/rootstrap/rails_api_base/contributors).

[<img src="https://s3-us-west-1.amazonaws.com/rootstrap.com/img/rs.png" width="100"/>](http://www.rootstrap.com)
