# Elyxel

[Elyxel](https://www.elyxel.com) is a space to gather and share stories.

# Info

This code base serves as an example of a fully functional Elixir and Phoenix application running on a small production server. For more extensive details please read about the build process [here](http://www.achariam.com/elyxel).

# Local Setup

- Install [Docker](https://docs.docker.com/engine/installation/#supported-platforms)
- `docker-compose build web`
- `docker-compose up`
- Visit [http://elyxel.localhost:8000](http://elyxel.localhost:8000)

# Migrate and seed the database
- Exec into running docker container `docker exec -it elyxel_web_1 /bin/bash`
- `mix ecto.setup`

# Running Tests
- Exec into running docker container `docker exec -it elyxel_web_1 /bin/bash`
- `mix test`
- OR `docker-compose run --rm web mix test`

# Production

- This depends on your setup but for Elyxel simple deployment is handled by the `automata` script.

