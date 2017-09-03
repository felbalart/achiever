# Achiever 
This is a Rails application, initially generated using [Potassium](https://github.com/platanus/potassium) by Platanus.

## Local installation

Assuming you've just cloned the repo, run this script to setup the project in your
machine:

    $ ./bin/setup

It assumes you have a machine equipped with Ruby, Postgresql, etc. If not, set up
your machine with [boxen].

The script will do the following among other things:

- Install the dependecies
- Prepare your database
- Adds heroku remotes

After the app setup is done you can run it with [Heroku Local]

    $ heroku local

[Heroku Local]: https://devcenter.heroku.com/articles/heroku-local
[boxen]: http://github.com/platanus/our-boxen


## Style Guides

The style guides are enforced through a self hosted version of [Hound CI](http://monkeyci.platan.us). The style configuration can also be used locally
in development runing `rubocop` or just using the rubocop integration for your text editor of choice.

You can add custom rules to this project just adding them to the `.ruby-style.yml` file.


## Sending Emails

The emails can be send through the gem `send_grid_mailer` using the `sendgrid` delivery method.
All the `action_mailer` configuration can be found at `config/mailer.rb`, which is loaded only on production environments.

All emails should be sent using background jobs, by default we install `sidekiq` for that purpuse.

#### Testing in staging

If you add the `EMAIL_RECIPIENTS=` environmental variable, the emails will be intercepted and redirected to the email in the variable.


## Internal dependencies

### Authorization

For defining which parts of the system each user has access to, we have chosen to include the [Pundit](https://github.com/elabs/pundit) gem, by [Elabs](http://elabs.se/).

### Authentication

We are using the great [Devise](https://github.com/plataformatec/devise) library by [PlataformaTec](http://plataformatec.com.br/)

### Rails pattern enforcing types

This projects uses [Power-Types](https://github.com/platanus/power-types) to generate Services, Commands, Utils and Values.

### Error Reporting

To report our errors we use [Sentry](https://github.com/getsentry/raven-ruby)

### Scheduled Tasks

To schedule recurring work at particular times or dates, this project uses [Sidekiq Scheduler](https://github.com/moove-it/sidekiq-scheduler)

### Queue System

For managing tasks in the background, this project uses [Sidekiq](https://github.com/mperham/sidekiq)

## Seeds

To populate your database with initial data you can add, inside the `/db/seeds.rb` file, the code to generate **only the necessary data** to run the application.
If you need to generate data with **development purposes**, you can customize the `lib/fake_data_loader.rb` module and then to run the `rake load_fake_data` task from your terminal.

