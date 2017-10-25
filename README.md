# Rapido

[![Code Climate](https://codeclimate.com/github/starfighterheavy/rapido/badges/gpa.svg)](https://codeclimate.com/github/starfighterheavy/rapido)

Rapido is a simple, highly opinionated library that can be included into your Rails controllers to dry up a standard, RESTful API.

## First Principles

1. Routes should not deeply nest resources
2. Resources should not be referred to with auto-incrementing IDs.
3. JSON should be sent and recieved.
4. API keys should be placed in the URL.
5. Resource should be returned by the API for all methods and in the same form.
6. Resources should be represented at the root level in JSON without a container object.
7. Getting resources should always be paginated.
8. Complex business processes should be represented as resources, not special methods

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rapido'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rapido

## Usage

Simply including the Rapido::Controller module into your controller is all you need to do if:

1. Odd controller name: your controller's name follows the standard [Resource.pluralize]Controller format.
1. Odd controller methods: you don't need any additional API endpoints other then the standard REST create/show/index/delete/update endpoints.
1. Resource ownership: the resource governed by your controller is not nested within an owner, e.g. /api/v1/[parent_resource]/[parent_resource_id]/[my_resource]

If your controller has any of these characteristics, you'll need to do a little bit more work to properly configure your controller.

### Odd controller name

If for some reason your controller name does not follow the standard format, you'll need to override the override the `resource_class` method. For example, if you have a controller named `MyOddleNamedWidgetController` for the `Widget` resource:

```
class MyOddlyNamedWidgetController < ApplicationController
  include Rapido::Controller

  private

  def resource_class
    Widget
  end
end
```


### Odd controller methods

If you have endpoints other than create, show, index, update, and delete, you can add them as additional methods like so:

```
class WidgetsController < ApplicationController
  include Rapido::Controller

  def spin
    resource.spin!
    head :ok
  end
end
```

### Resource ownership

If your resources has a `belongs_to` relationship that is reflected in the API route as a nested resource, you can specify the `resource_owner` class to include the relationship when retrieving the resource.

```
class WidgetsController < ApplicationController
  include Radido::Controller

  resource_owner_name :widget_factory
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jskirst/rapido.

