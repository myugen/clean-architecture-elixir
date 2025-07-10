defmodule Collabtask.Shared.Adapters.UuidGenerator do
  @behaviour Collabtask.Shared.Ports.IdGenerator

  @impl Collabtask.Shared.Ports.IdGenerator
  def generate do
    UUID.uuid4()
  end
end
