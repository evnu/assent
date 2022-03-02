defmodule Assent.MixProject do
  use Mix.Project

  @source_url "https://github.com/pow-auth/assent"
  @version "0.2.0"

  def project do
    [
      app: :assent,
      version: @version,
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Hex
      description: "Multi-provider framework",
      package: package(),

      # Docs
      name: "Assent",
      docs: docs(),

      xref: [exclude: [:certifi, :httpc, Mint.HTTP, JOSE.JWT, JOSE.JWK, JOSE.JWS, :ssl_verify_hostname]],

      aliases: aliases()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :crypto, :public_key]
    ]
  end

  defp deps do
    [
      {:jose, "~> 1.8", optional: true},

      {:certifi, ">= 0.0.0", optional: true},
      {:ssl_verify_fun, ">= 0.0.0", optional: true},

      {:mint, "~> 1.0", optional: true},
      {:castore, "~> 0.1.0", optional: true},

      {:credo, "~> 1.1", only: [:dev, :test]},
      {:jason, "~> 1.0", only: [:dev, :test]},

      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},

      {:mime, "~> 1.0", only: :test},
      {:plug_cowboy, "~> 2.0", only: :test},
      {:x509, "~> 0.6.0", only: :test}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      maintainers: ["Dan Shultzer"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => @source_url,
        "Sponsor" => "https://github.com/sponsors/danschultzer"
      },
      files: ~w(lib LICENSE mix.exs README.md)
    ]
  end

  defp docs do
    [
      source_ref: "v#{@version}",
      main: "README",
      canonical: "http://hexdocs.pm/assent",
      source_url: @source_url,
      extras: [
        "README.md": [filename: "README"],
        "CHANGELOG.md": [filename: "CHANGELOG"],
      ],
      groups_for_modules: [
        Strategies: ~r/^Assent.Strategy/
      ],
      skip_undefined_reference_warnings_on: [
        "CHANGELOG.md"
      ]
    ]
  end

  defp aliases do
    [
      test: ["x509.gen.suite -f -o tmp/fixtures/ssl localhost", "test"]
    ]
  end
end
