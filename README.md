# Shit My Wife Does

http://shitmywifedoes.com

Written with [Ruby](https://www.ruby-lang.org/en/)+[Middleman](http://middlemanapp.com)

**Included packages:**

* [Middleman](http://middlemanapp.com/)
* [Slim](http://slim-lang.com/)
* [Sass](http://sass-lang.com/)
* [Bootstrap 3 Sass](https://github.com/twbs/bootstrap-sass)
* [Favicon Maker](https://github.com/follmann/middleman-favicon-maker)

**Included features:**

* Autoprefixer
* CSS reset
* HTML5 layout
* Image compression
* Asset minification
* Favicon generation

## Setup in development

* Install [rbenv](https://github.com/sstephenson/rbenv) and [ruby-build](https://github.com/sstephenson/ruby-build#installing-as-an-rbenv-plugin-recommended)

* Clone project and cd into project directory

```bash
git clone repo-path.git
cd project-dir
```

* Install Ruby version set in `.ruby-version`

```
rbenv install && rbenv rehash
```

* Setup local ruby (this number should reflect the ruby version that was just installed)

```
rbenv local 2.2.3
```

* Install JavaScript runtime
You need a JS runtime. For [Nodejs](http://nodejs.org/), I suggest installing via [nvm](https://github.com/creationix/nvm). For [therubyracer](https://github.com/cowboyd/therubyracer), add `gem "therubyracer": "x.x.x"` to your Gemfile, then run `bundle install`

* Install dependencies

```
gem install bundler && bundle install
```

* Copy `source/environment_variables.rb.sample` to `source/environment_variables.rb`
* Set `site_url_production` and `site_url_development` in `source/environment_variables.rb`

* Start Middleman server

```
bundle exec middleman
```

## Building

* Run the following to build your website locally into a `build` folder

```bash
bundle exec middleman build
```

## Deploying
Middleman-deploy will deploy to GitHub Pages. Running the deploy command. Note, this will build for you before deploying.
```bash
bundle exec middleman deploy
```
