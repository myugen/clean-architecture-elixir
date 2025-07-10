defmodule Collabtask.Shared.Ports.IdGenerator do
  @type t :: module()

  @callback generate() :: String.t()
end
