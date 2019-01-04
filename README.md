# flash_container

Simple framework-agnostic flash message container.

## Installation

1. Add the dependency to your `shard.yml`:
```yaml
dependencies:
  flash_container:
    github: imdrasil/flash_container.cr
```
2. Run `shards install`

## Usage

```crystal
require "flash_container"

# Load flash messages from session
flash = FlashContainer.from_session(session.string?(FlashContainer.key))

flash[:notice] = "Some message"

# Write messages back to session
session.string(FlashContainer.key, flash.to_session)
```

## Contributing

1. Fork it (<https://github.com/imdrasil/flash_container.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

Inspired by `Amber::Router::Flash::FlashStore`.

- [Roman Kalnytskyi](https://github.com/imdrasil) - creator and maintainer
