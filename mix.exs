defmodule KindleClippings.Mixfile do
  use Mix.Project

  def project do
    [app: :kindle_clippings,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     escript: [main_module: KindleClippings.CLI],
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: ["coveralls": :test, "coveralls.html": :test, "coveralls.detail": :test, "coveralls.post": :test],
     docs: [main: "KindleClippings", # The main page in the docs
          #logo: "path/to/logo.png",
          extras: ["README.md"]]
   ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :eex]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:credo, "~> 0.3.5", only: [:test, :dev]},
      {:excoveralls, "~> 0.4", only: :test},
      {:ex_doc, "~> 0.14", only: :dev}
    ]
  end
end
