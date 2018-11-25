# Spawn API

[![Build Status](https://travis-ci.com/spawnfest/spawn_api.svg?token=8sfwqwpMxagtpynxF44p&branch=master)](https://travis-ci.com/spawnfest/spawn_api)

## Local Installation and Setup - Instructions to Run Locally

Step 1: Install Elixir 1.7 on your machine if you haven't already done so. One easy way to do this is by following these [instructions](https://elixirschool.com/blog/asdf-version-management/)

Step 2: Install Phoenix 1.4 if you haven't already done so. You can follow [these instructions](https://medium.com/flatiron-labs/til-how-to-install-phoenix-1-4-dev-beta-e5a4d849727a)

Step 3: Install Postgres if you haven't already done so. You can follow [these instructions for your specific platform](https://www.codefellows.org/blog/three-battle-tested-ways-to-install-postgresql/)

Step 4: Run `mix deps.get` to fetch the dependencies in the top-level spawn_api directory.

Step 5: Install the front end dependencies via npm.

```
cd assets
npm install
```

If you don't have npm installed, check out [the get npm](https://www.npmjs.com/get-npm) page.

Step 6: In the top level directory (called spawn_api), run `mix ecto.setup`.

Step 7: Spin up the local phoenix server with `mix phx.server`.

Step 8: In your browser, go to http://localhost:4000. You should now be able to generate a CSV file of randomized data.

## About this project

The purpose of this project is to allow a user to generate randomized test data that you can use when building out your application. It is intended to be a clone of [mockaroo](https://www.mockaroo.com/).

The idea is that having realistic looking data that closely mimics production will help you test your API and front-end user flows.
