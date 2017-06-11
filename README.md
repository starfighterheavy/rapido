# Rapido

Rapido is a simple module library that can be included into your Rails controllers to dry up a standard, RESTful API.

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
  include Radid::Controller

  resource_owner_name :widget_factory
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jskirst/rapido.

