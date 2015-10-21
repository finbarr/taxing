## Taxing

This gem scrapes US tax rates for individual states or the whole country.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'taxing'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install taxing

## Usage

The rates are returned as hashes with the following keys as symbols:

```
state
zip_code
tax_region_name
tax_region_code
combined_rate
state_rate
county_rate
city_rate
special_rate
```

Here's an example of one rate:

```ruby
{
  :state=>"CA",
  :zip_code=>"90001",
  :tax_region_name=>"LOS ANGELES COUNTY",
  :tax_region_code=>"AHBG",
  :combined_rate=>"0.090000",
  :state_rate=>"0.065000",
  :county_rate=>"0.010000",
  :city_rate=>"0",
  :special_rate=>"0.015000"
}
```

To load all of the rates for one state:

```ruby
Taxing::Rate.state("CA")
> [{...}, ...]
```

To load all of the rates for the USA:

```ruby
Taxing::Rate.all
> [{...}, ...]
```

The methods above can optionally take a `Time` instance as the second argument, and the gem will look up tax rates from that time. They may not all be available. If you get an error when trying to load rates, try passing in a `Time` object for 1 month ago, e.g., `Taxing::Rate.state("CA", 1.month.ago)` (assuming Rails).

This gem is not intended to be used as an API. You should scrape the rates periodically and cache them locally.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/taxing. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

