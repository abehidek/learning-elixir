defmodule HelloWeb.Router do
  use HelloWeb, :router

  # Pipeline are a series of plugs that can be attached to specific scopes.
  # Routes are defined inside scopes and scopes may through multiple pipelines. Once a route matches Phoenix invokes all plugs defined on the pipelines associated to that route

  # there are two main pipelines defined by default
  # :browser => prepare for routes which render requests for a browser
  pipeline :browser do
    plug :accepts, ["html"]
    # fetch session data and makes it avaiable in the connection
    plug :fetch_session
    # fetchs any flash messages from LiveView and merges them with the controller flash messages
    plug :fetch_live_flash
    # stores the root layout for rendering purposes
    plug :put_root_layout, {HelloWeb.LayoutView, :root}
    # protect forms posts from cross-site forgery
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug HelloWeb.Plugs.Locale, "pt"
  end

  # :api => prepare for routes which produce data for an API
  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelloWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/hello", HelloController, :index
    get "/another", AnotherController, :index
    get "/another/:message", AnotherController, :index
    # set standard matrix of HTTP verbs
    resources "/users", UserController do
      # nested resources
      resources "/posts", PostController

      # to call path helper functio you do:
      # HelloWeb.Router.Helpers.user_post_path(HelloWeb.Endpoint, :show, 42, 17)
      # "/users/42/posts/17"
    end

    # set phoenix liveview
    live "/counter", CounterLive
  end

  scope "/admin", HelloWeb.Admin, as: :admin do
    pipe_through :browser

    resources "/reviews", ReviewController
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelloWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: HelloWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
