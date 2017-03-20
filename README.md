# Dailies

> "You like my dailies, Clarence?"
>  \- True Romance, 1993

This is a fullscreen in-browser slideshow, intended to display a looping sequence of interesting, usually animated visuals. It includes a little editor for managing the list of displayed URLs and a matching JSON-centric API.

## Prerequisites
  * Elixir (tested with 1.3)
  * Phoenix (tested with 1.2)
  * Postgres (tested with 9.5)

## Running
To start the service:

  * Clone this repo
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

The editor is available at [`localhost:4000/editor`](http://localhost:4000/editor).

Ready to run in production? Please [check out the Phoenix deployment guides](http://www.phoenixframework.org/docs/deployment).

