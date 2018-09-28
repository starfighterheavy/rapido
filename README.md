# Rapido

[![Code Climate](https://codeclimate.com/github/starfighterheavy/rapido/badges/gpa.svg)](https://codeclimate.com/github/starfighterheavy/rapido)

Rapido is a simple, highly opinionated library that can be included into your Rails controllers to enforce standardized behavior and security.

## API

#### `belongs_to`

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

**foreign_key**

Default `id`. Specifies the name of the lookup column for the owner. For example, if `Post` belongs to `User`, then in the `PostsController` if `belongs_to :user, foreign_key: :token` is supplied, then the post would be retrieved like so: 

`User.find_by(token: id).posts.find(params[:id])`.

**foreign_key_param**

Default `[singular owner name]_id`. Specifies the param used as the owner's foreign key. For example, if `Post` belongs to `User`, then in the `PostsController` if `belongs_to :user, foreign_key_param: :author_id` is supplied, then the post would be retrieved like so: 

`User.find(params[:author_id]).posts.find(params[:id])`.

#### `lookup_param`

Specifies the param used to retrieve the resource. For example, if `Post` belongs to `User`, then in the `PostsController` if `lookup_param :token` is supplied, then the post would be retrieved like so: 

`User.find_by(params[:id]).posts.find_by(token: params[:token])`.

#### `presented_by`

Specifies the class that will present the resource. This class must accept the resource as the only parameter at initialization, and respond to the `as_json` for output when used with the `Rapido::ApiController`.

#### `collection_presented_by`

Specifies the class that will present a collection of resources, as in the index method. Similar to `presented_by`, the class must accept the resource collection as the only argument at initialization, and respond to `as_json` for output when used with the `Rapido::ApiController`. The `collection_presented_by` can also accept a list of arguments, as symbols, that should be pulled from the `params` hash and passed to presenter class at initialization as optional argments.

For example, if `params` contained a `:filter` parameter which should be used by the presenter to filter the collection, then the following would work: 

`collection_presented_by WidgetsCollectionPresenter, :filter`

The `initialize` method of the presenter should be structured as such:

`def initialize(widgets, filter = nil)`

#### `attr_permitted`

Accepts a list of symbols. These symbols specify the attributes that are supplied to StrongParameters as permitted parameters in `create` and `update` actions.

#### `permit_no_params!`

This will disallow any parameters in `create` and `update` actions.

#### `permit_all_params!`

This will permit all parameters in `create` and `update` actions.

## Notes

Authentication & AppController functionality will be deprecated in v0.6 and removed in v1.0. With the 1.0 release, Rapido will remove all functionality that is not strictly oriented to streamlining API Controller development and security.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Testing

Run `cucumber test/test_5_1` to execute all the tests in the test application.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/starfighter/rapido.

