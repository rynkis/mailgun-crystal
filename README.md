# mailgun-crystal

send text or html by mailgun.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     mailgun-crystal:
       github: Shy07/mailgun-crystal
   ```

2. Run `shards install`

## Usage

```crystal
require "mailgun-crystal"

client = MailgunCrystal::Client.new(
  api_key: api_key,
  domain: DOMAIN
)

res = client.send_text(
  from: "Excited User <me@samples.mailgun.org>",
  to: %w(bar@example.com YOU@YOUR_DOMAIN_NAME),
  subject: "Hello",
  content: "Testing some Mailgun awesomness!"
)

#
# => or send html
#
# res = client.send_html(
#   from: "Excited User <me@samples.mailgun.org>",
#   to: %w(bar@example.com YOU@YOUR_DOMAIN_NAME),
#   subject: "Hello",
#   content: "<h1>Testing some Mailgun awesomness!</h1>"
# )

p res # => {
      #      "status_code" => 200 if success,
      #      "id" => mailgun id if success,
      #      "message" => success message or error message
      #    }

```

## Contributing

1. Fork it (<https://github.com/Shy07/mailgun-crystal/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [HSU Rynki](https://github.com/Shy07) - creator and maintainer
