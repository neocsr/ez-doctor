# ez-doctor

Basic proxy using memory caching.

## Development

```
USER_KEY=<betterdoctor_user_key> rails server
```

```
curl -i "http://localhost:3000/api/v1/doctors/search?name=John%20Doe"
```
## Testing

```
bundle exec rake
```

```
bundle exec guard -i -P minitest
```

## Initial Setup

```
rails new ez-doctor --skip-active-record --skip-javascript --skip-sprockets --skip-turbolinks
rails generate controller Api::V1::Doctors search --no-view-specs --no-helper --no-assets
bundle exec guard init
bundle exec guard -i -P minitest
```
