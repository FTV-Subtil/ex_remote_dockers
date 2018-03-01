defmodule RemoteDockers.HostConfig do
  @enforce_keys [:hostname, :port]
  defstruct [:hostname, :port, :ssl]

  @default_port 2376

  @doc """
  Build configuration with defaults

  default:
  ```
  hostname: "localhost"
  port: #{@default_port}
  ```
  """
  def build() do
    build("localhost", @default_port)
  end

  @doc """
  Build configuration with a specific hostname

  default:
  ```
  port: #{@default_port}
  ```
  """
  def build(hostname) do
    build(hostname, @default_port)
  end

  @doc """
  Build configuration with specific hostname and port
  """
  def build(hostname, port) do
    %RemoteDockers.HostConfig{
      hostname: hostname,
      port: port
    }
  end

  @doc """
  Build configuration with SSL

  default:
  ```
  port: #{@default_port}
  ```
  """
  def build(hostname, certfile, keyfile) do
    build(hostname, @default_port, certfile, keyfile)
  end

  @doc """
  Build configuration with hostname, port and SSL
  """
  def build(hostname, port, certfile, keyfile) do
    %RemoteDockers.HostConfig{
      hostname: hostname,
      port: port,
      ssl: [
        certfile: certfile,
        keyfile: keyfile,
      ]
    }
  end

  @doc """
  Get HTTPoison default options with ssl if enabled
  """
  def get_options(%RemoteDockers.HostConfig{ssl: nil} = _host_config), do: []
  def get_options(host_config) do
    [
      ssl: host_config.ssl
    ]
  end
end
