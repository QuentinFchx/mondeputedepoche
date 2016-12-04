defmodule An.Router do
  use An.Web, :router

  use Plug.ErrorHandler
  use Sentry.Plug

  @lazy_auth %{lazy_auth: true}

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug An.AuthCitoyen
  end

  scope "/", An do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", An do
    pipe_through :api

    post "/auth", AuthController, :auth

    get "/activity/:actor_id/:object_id", FeedController, :activity
  end

  scope "/api", An do
    pipe_through :api
    pipe_through :auth

    get "/search", DeputeController, :search, private: @lazy_auth
    get "/feed", FeedController, :feed

    resources "/deputes", DeputeController, only: [:show], private: @lazy_auth do
      get "/feed", FeedController, :depute_feed
    end

    get "/followed", FollowController, :followed
    post "/follow/:id", FollowController, :follow
    post "/unfollow/:id", FollowController, :unfollow
  end
end
