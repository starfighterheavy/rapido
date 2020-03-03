# Rapido

[![Code Climate](https://codeclimate.com/github/starfighterheavy/rapido/badges/gpa.svg)](https://codeclimate.com/github/starfighterheavy/rapido)

Rapido is a simple, highly opinionated library that can be included into your Rails controllers to enforce standardized behavior and security.

## API

### `attr_permitted`

Accepts a list of symbols. These symbols specify the attributes that are supplied to StrongParameters as permitted parameters in `create` and `update` actions.

### `belongs_to`

Specifies the owner of the resource. For example, if many `Post` belonged to `User`, then in the `PostsController`, the following would be included: `belongs_to :user` and `Post` would be retrieved like so:

`User.find(params[:user_id]).posts.find([params[:id])`.

##### Optional Parameters

**has_one** 

Default `false`. If `true`, will treat the `belongs_to` as `has_one`.

**owner** 

This is the owner of the owner - if supplied, will be used to retrieve the owner. For example, if `User` belongs to `Group`, `Post` belongs to `User`, then in the `PostsController` if `belongs_to :user, owner: :current_group` was supplied, then the User would be retrieved from group before Post is retrieved from user, like so:

`current_group.users.find(params[:user_id]).posts.find(params[:id])`.

**getter**

Specifies the method to call to retrieve the owner, rather than retrieving by with URL parameters. For example, if `Post` belongs to `User`, then in the `PostsController` if `belongs_to :user, getter: :current_user` was supplied, then the post would be retrieved like so: 

`current_user.posts.find(params[:id])`. 

This can be useful when ownership exists but is not reflected in the route structure explicitly.

**build**

You can create override the class Rapido::Controller build method directly in situations where the owner class does not have a build_[resource] method. Note that `has_one` will execute first if set to true, ignoring any `build` method you create directly, so if you do override it do not set `has_one: true`.

**foreign_key**

Default `id`. Specifies the name of the lookup column for the owner. For example, if `Post` belongs to `User`, then in the `PostsController` if `belongs_to :user, foreign_key: :token` is supplied, then the post would be retrieved like so: 

`User.find_by(token: id).posts.find(params[:id])`.

**foreign_key_param**

Default `[singular owner name]_id`. Specifies the param used as the owner's foreign key. For example, if `Post` belongs to `User`, then in the `PostsController` if `belongs_to :user, foreign_key_param: :author_id` is supplied, then the post would be retrieved like so: 

`User.find(params[:author_id]).posts.find(params[:id])`.

### `lookup_param`

Specifies the param used to retrieve the resource. For example, if `Post` belongs to `User`, then in the `PostsController` if `lookup_param :token` is supplied, then the post would be retrieved like so: 

`User.find_by(params[:id]).posts.find_by(token: params[:token])`.

### `present_with`

Specifies the class that will present the resource. This class must accept the resource as the only parameter at initialization, and respond to the `as_json` for output when used with the `Rapido::ApiController`.

For example, if `params` contained a `:filter` parameter which should be used by the presenter , then the following would work:

`present_with WidgetsPresenter, :filter`

The `initialize` method of the presenter should be structured as such:

`def initialize(widgets, filter = nil)`

### `present_collection_with`

Specifies the class that will present a collection of resources, as in the index method. Similar to `presented_by`, the class must accept the resource collection as the only argument at initialization, and respond to `as_json` for output when used with the `Rapido::ApiController`. The `collection_presented_by` can also accept a list of arguments, as symbols, that should be pulled from the `params` hash and passed to presenter class at initialization as optional argments.

Collection presenters can also be provided args, similar to `present_with`

### `permit_no_params!`

This will disallow any parameters in `create` and `update` actions.

## Filters

The following filters are available to override, similar to the standard Rails action filters.

#### Create

* before_build
* before_create
* after_create_success
* after_create_failure

#### Destroy

* before_destroy
* after_destroy_success

#### Update

* before_assign_attributes
* before_updat
* after_update_success
* after_update_failure

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Testing

Run `cucumber test/test_5_1` to execute all the tests in the test application.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/starfighter/rapido.

