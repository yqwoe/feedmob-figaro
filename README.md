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

It load ```apollo.yml``` to config apollo configuration center.

example:

```
APOLLO_CLUSTER: default
APOLLO_APP_ID: feedmob-XXX
APOLLO_HOST: http://localhost:8080

 stage:
  APOLLO_HOST: http://xxx.com:8080

 production:
  APOLLO_HOST: http://xxx.com:8080

```

If Apollo has configured, after this will overwrite local `config/application.yml` and `config/sidekiq.yml`

### Tip
This Gem start when rails before configuration,
If you single start sidekiq, Please pull sart rails server first.

### Using in development

Just see the [doc](https://github.com/laserlemon/figaro) from the official.
