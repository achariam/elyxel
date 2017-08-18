# Elyxel

[Elyxel](https://www.elyxel.com) is a space to gather and share stories.

# Info

This code base serves as an example of a fully functional Elixir and Phoenix application running on a small production server. For more extensive details please read about the build process [here](http://www.achariam.com/elyxel).

# Local Setup

- Install [Docker](https://docs.docker.com/engine/installation/#supported-platforms)
- `docker-compose build web`
- `docker-compose up`
- Visit [http://elyxel.localhost:8000](http://elyxel.localhost:8000)

- Setup local environment as described in [Phoenix documentation](https://hexdocs.pm/phoenix/installation.html#content).
- Seed database with `seeds.exs` & `wire_seeds.exs`
- `mix phoenix.server`
- Visit `localhost:4000` in browser.

# Production

- This depends on your setup but for Elyxel simple deployment is handled by the `automata` script.

