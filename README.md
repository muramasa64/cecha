# cecha

cecha is "Check ELB Certificate Hash Algorithm" command.

## Installation

install it yourself as:

    $ gem install cecha

## Usage

```
Commands:
  cecha help [COMMAND]  # Describe available commands or one specific command
  cecha list            # show elb certificate list

Options:
  p, [--profile=PROFILE]                                   # Load credentials by profile name from shared credentials file.
  k, [--access-key-id=ACCESS_KEY_ID]                       # AWS access key id.
  s, [--secret-access-key=SECRET_ACCESS_KEY]               # AWS secret access key.
  r, [--region=REGION]                                     # AWS region.
     [--shared-credentials-path=SHARED_CREDENTIALS_PATH]   # AWS shared credentials path.
  v, [--verbose], [--no-verbose]
```

## Example

```
$ cecha list
012345678901	us-east-1	production-elb	443	prod.example.com	sha1WithRSAEncryption
012345678901	ap-northeast-1	development-elb	443	dev.example.com	sha256WithRSAEncryption
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec cecha` to use the gem in this directory, ignoring other installed copies of this gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/cecha. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

