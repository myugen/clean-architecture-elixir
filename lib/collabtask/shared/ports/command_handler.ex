defmodule Collabtask.Shared.Ports.CommandHandler do
  @type command :: any()
  @type dependencies :: map()

  @callback handle(command(), dependencies()) :: {:ok, any()} | {:error, term()}
end
