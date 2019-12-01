use Mix.Config

config :iasc_tp, Endpoint,
  port: String.to_integer(System.get_env("PORT") || "4444")

config :iasc_tp, redirect_url: System.get_env("REDIRECT_URL")
