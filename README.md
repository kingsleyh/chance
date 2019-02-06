# Chance

This is a Crystal port of the Ruby [Chance library](https://github.com/chanceagency/chance)

Chance is a library for exploring uncertainty in code. Maybe you always wanted to program with probability, to be boldly indecisive, to roll the dice without scratching your head? That's what we're all about here.

## Installation

1. Add the dependency to your `shard.yml`:
```yaml
dependencies:
  chance:
    github: kingsleyh/chance
```
2. Run `shards install`

## Usage

```crystal
require "chance"
```

## Chance Case Statements

Chance Cases take any number of args, each one being a probability statement with an outcome block attached.  The probabilities must add to 100 percent (sorry, for once in your life you will have to give less than 110%).  Only one outcome will be evaluated, as you would expect:

    outcome = Chance.case(
      Chance(String).new(70.percent).will {"snow"},
      Chance(String).new(20.percent).will {"sleet"},
      Chance(String).new(8.percent).will  {"sun"},
      Chance(String).new(1.percent).will  {"knives"}
    )

## Contributing

1. Fork it (<https://github.com/kingsleyh/chance/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Kingsley Hendrickse](https://github.com/kingsleyh) - creator and maintainer
