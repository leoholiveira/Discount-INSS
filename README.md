
# Ruby on Rails Discount INSS

This project is a Ruby on Rails that leverages the Devise framework for authentication for secure user authentication.

## Environment Variables

To run this project, you will need to add the following environment variables to your .env file

`DB_USER`
`DB_PASS`
`DB_HOST`
`DB_PORT`
`DB_NAME`

## Environment Setup

Initialize docker:

```bash
  docker-compose up -d
```

Ensure you have Ruby and Rails installed on your system. Install project dependencies using the following command:

```bash
  bundle install
```

Additionally, configure the database by running the following commands:

```bash
  rails db:setup
  rails db:create
  rails db:migrate
  rails db:seed
```

### Start the project:

```bash
  bundle exec sidekiq
  rails s
```

### User login default:

| User | Password     |
| :-------- | :------- |
| `admin@admin.com` | `1234567` |

### Run test:

```bash
  rspec
```

## Contributions

Contributions are always welcome!

## Support

For support, email contatos_leo@hotmail.com.

## Tech Stack

**Client:** Stimulus, Bootstrap. 

**Server:** Ruby, Rspec, Docker, Sidekiq.

## License

This project is licensed under the [MIT License](https://choosealicense.com/licenses/mit/).

## Authors

- [@leoholiveira](https://github.com/leoholiveira)