Simple, Heroku-friendly Rails app configuration using `ENV` and a single YAML file

### Figaro for [Apollo](https://github.com/ctripcorp/apollo)

Apollo is a applicaiton configuration center. When we hanve many sub-portal and
want to unified management all `config/application.yml`. This Gem result from the
idea.

### Getting Started

Add Figaro to your Gemfile and `bundle install`:

```ruby
gem 'figaro', git: "https://github.com/feed-mob/feedmob-figaro", branch: 'master'
```

### Using exclude development

It detected and used ENV named `ENV['APOLLO_HOST']`, `ENV['APOLLO_APP_ID']`, `ENV['APOLLO_CLUSTER']`,
when you execute `rails c` or `rails s` within `ENV` variables.
Just like `RAILS_ENV=stage rails s`.

```bash
APOLLO_HOST='https://your_host' APOLLO_APP_ID='your_application_id'
APOLLO_CLUSTER='your_cluster_name' rails s
```
If Apollo has configured, after this will overwrite local `config/application.yml` and `config/sidekiq.yml`

### Using in development

Just see the [doc](https://github.com/laserlemon/figaro) from the official.
